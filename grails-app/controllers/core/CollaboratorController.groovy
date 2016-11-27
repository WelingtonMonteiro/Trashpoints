package core

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.SynchronizerTokensHolder
import org.hibernate.criterion.CriteriaSpecification

@Transactional(readOnly = true)
@Secured(['ROLE_COLLABORATOR'])
//@Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
class CollaboratorController {

    def springSecurityService

    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def create() {
        render(view: "create")
    }

    private invalidToken() {
        def response = [:]
        String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)
        response = [error: 'Invalid_Token', newToken: newToken]
        render response as JSON
    }

    private successToken(message) {
        def response = [:]
        String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)
        response = [success: 'sucesso', newToken: newToken]
        response += message
        render response as JSON
    }

    private verifyErrors(InstanceClass) {
        def isErros = false
        if (InstanceClass.hasErrors()) {
            def listErrors = []

            InstanceClass.errors.allErrors.each { error ->
                listErrors += g.message(code: error.defaultMessage, error: error)
            }

            def message = [error: listErrors]
            render message as JSON

            isErros = true
        }
        isErros
    }

    @Transactional
    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def save() {
        withForm {
            Collaborator collaborator = new Collaborator()
            Address addressCollect = new Address()
            User user = new User()
            def userRole = Role.findByAuthority('ROLE_COLLABORATOR')


            user.username = params.j_username
            user.password = params.j_password

            collaborator.name = params.name
            collaborator.phone = params.phone
            collaborator.photo = params.photo
            collaborator.isAddressEqual = params.isAddressEqual
            collaborator.dateOfBirth = Date.parse('dd/MM/yyyy', params.dateOfBirth)

            addressCollect.zipCode = params.zipCode
            addressCollect.street = params.street
            addressCollect.number = params.number
            addressCollect.neighborhood = params.neighborhood
            addressCollect.city = params.city
            addressCollect.state = params.state
            addressCollect.latitude = params.latitude
            addressCollect.longitude = params.longitude

            collaborator.address = addressCollect

            user.validate()
            addressCollect.validate()
            collaborator.validate()

            def errors = verifyErrors(user) || verifyErrors(collaborator) || verifyErrors(addressCollect)

            if (!errors) {
                collaborator.save(flush: true)

                user.collaborator = collaborator

                user.save(flush: true)

                collaborator.user = user

                collaborator.save(flush: true)

                UserRole.create(user, userRole)

                UserRole.withSession {
                    it.flush()
                    it.clear()
                }

                successToken([success: 'Dados cadastrais salvos com sucesso'])
            }
        }.invalidToken {
            invalidToken()
        }
    }

    def myCollections() {
        //ID COLLABORATOR LOGGED IN
        def user = springSecurityService.principal
        def collaboratorId = 1//userManager?.collaborator?.id
        def collaboratorCollections = Collaborator.findById(collaboratorId)?.collects?.sort { it.orderDate }

        if (collaboratorCollections == null) {
            render(view: "myCollections", model: ["collaboratorCollections": []])
        } else {
            render(view: "myCollections", model: ["collaboratorCollections": collaboratorCollections])
        }
    }

    def loadCompanyDetails() {
        Integer companyId = params.id.toInteger()
        Company company = Company.findById(companyId)
        Address address = company.address

        def response = ["company": company, "address": address]
        render response as JSON
    }


}
