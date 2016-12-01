package core

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.SynchronizerTokensHolder
import org.hibernate.criterion.CriteriaSpecification

@Transactional(readOnly = true)
@Secured(['ROLE_COLLABORATOR'])
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
        response = [success: 'Salvo com sucesso', newToken: newToken]
        if (message)
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

            String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)
            def message = [error: listErrors, newToken: newToken]
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
            if(params.dateOfBirth)
                collaborator.dateOfBirth = Date.parse('dd/MM/yyyy', params.dateOfBirth)

            addressCollect.zipCode = params.zipCode
            addressCollect.street = params.street
            addressCollect.number = params.number
            addressCollect.neighborhood = params.neighborhood
            addressCollect.city = params.city
            addressCollect.state = params.states
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
        User currentUser = springSecurityService.loadCurrentUser()
        Collaborator currentCollaborator = currentUser.collaborator

        def collaboratorCollections = currentCollaborator?.collects?.sort { it.orderDate }

        if (collaboratorCollections == null) {
            render(view: "myCollections", model: ["collaboratorCollections": []])
        } else {
            render(view: "myCollections", model: ["collaboratorCollections": collaboratorCollections])
        }
    }

    def loadCompanyDetails() {
        Integer companyId = params.id.toInteger()
        Company company = Company.findById(companyId)
        Address address = company?.address

        if(company) {
            def response = ["company": company, "address": address]
            render response as JSON
        }else{
            def response = ["company": [], "address": []]
            render response as JSON
        }
    }

    def editCollaborator(){
        User currentUser = springSecurityService.currentUser as User
        // TODO: verificar no contexto do Spring como atualizar o vínculo entre usuário e companhia
        Collaborator currentCollaborator = currentUser.collaborator
        currentCollaborator = Collaborator.get(currentCollaborator.id)

        render(view: "edit", model: ["currentCollaborator" : currentCollaborator])
    }

    @Transactional
    def saveEditCollaborator() {
        withForm {
            Collaborator collaborator = Collaborator.get(params.id)
            Address addressCollect = collaborator.address
            // TODO: verificar a questão da foto
            collaborator.name = params.name
            collaborator.phone = params.phone
            //collaborator.photo = params.photo
            if (params.isAddressEqual == null){
                collaborator.isAddressEqual = false
            } else {
                collaborator.isAddressEqual = params.isAddressEqual
            }
            if(params.dateOfBirth)
                collaborator.dateOfBirth = Date.parse('dd/MM/yyyy', params.dateOfBirth)

            addressCollect.zipCode = params.zipCode
            addressCollect.street = params.street
            addressCollect.number = params.number
            addressCollect.neighborhood = params.neighborhood
            addressCollect.city = params.city
            addressCollect.state = params.states
            //addressCollect.latitude = params.latitude
            //addressCollect.longitude = params.longitude

            addressCollect.validate()
            collaborator.validate()

            def errors = verifyErrors(collaborator) || verifyErrors(addressCollect)

            if (!errors) {
                addressCollect.save(flush: true)
                collaborator.address = addressCollect
                collaborator.save(flush: true)
                successToken([success: 'Dados cadastrais salvos com sucesso'])
            }
        }.invalidToken {
            invalidToken()
        }
    }




}
