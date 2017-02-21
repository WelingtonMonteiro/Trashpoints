package core

import grails.converters.JSON
import grails.plugin.mail.MailService
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.SynchronizerTokensHolder
import org.hibernate.criterion.CriteriaSpecification

@Transactional(readOnly = true)
@Secured(['ROLE_COLLABORATOR'])
class CollaboratorController {

    def springSecurityService
    MailService mailService

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
            addressCollect.latitude = params.latitude ? params.latitude.toFloat() : 0f
            addressCollect.longitude = params.longitude ? params.longitude.toFloat() : 0f
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

                //Todo: descobrir uma forma de enviar assincrono o email
//                mailService.sendMail {
//                    to params.j_username
//                    from 'info.trahspoints@gmail.com'
//                    subject "Cadastro no Sistema Trashpoints"
//                    text "Você está recebendo esse email, por que você foi cadastrado no Sistema Trashpoints. "
//                }

                successToken([success: 'Dados cadastrais salvos com sucesso'])
            }
        }.invalidToken {
            invalidToken()
        }
    }

    def myCollectedCollections() {
        User currentUser = springSecurityService.loadCurrentUser()
        Collaborator currentCollaborator = currentUser.collaborator

        def collaboratorCollections = Collect.createCriteria().list {
            createAlias("collaborator", "c")
            eq("c.id", currentCollaborator.id)
            eq("isCollected", true)
            order("orderDate", "desc")
        }

        if (collaboratorCollections == null) {
            render(view: "myCollectedCollections", model: ["collaboratorCollections": []])
        } else {
            render(view: "myCollectedCollections", model: ["collaboratorCollections": collaboratorCollections])
        }
    }

    def myCollectionsInProgress() {
        User currentUser = springSecurityService.loadCurrentUser()
        Collaborator currentCollaborator = currentUser.collaborator

        def collaboratorCollections = Collect.createCriteria().list {
            createAlias("collaborator", "c")
            eq("c.id", currentCollaborator.id)
            eq("isCollected", false)
            order("orderDate", "desc")
        }

        if (collaboratorCollections == null) {
            render(view: "myCollectionsInProgress", model: ["collaboratorCollections": []])
        } else {
            render(view: "myCollectionsInProgress", model: ["collaboratorCollections": collaboratorCollections])
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
        User currentUser = springSecurityService.getCurrentUser() as User
        // TODO: verificar no contexto do Spring como atualizar o vínculo entre usuário e companhia
        Collaborator currentCollaborator = currentUser.collaborator
        currentCollaborator = Collaborator.get(currentCollaborator.id)
        render(view: "edit", model: ["currentCollaborator" : currentCollaborator])
    }

    @Transactional
    def saveEditCollaborator() {
        withForm {
            User currentUser = springSecurityService.loadCurrentUser()
            Collaborator collaborator = currentUser.collaborator

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
            addressCollect.latitude = params.latitude ? params.latitude.toFloat() : 0f
            addressCollect.longitude = params.longitude ? params.longitude.toFloat() : 0f

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

    def sumQuantityOfCoins() {
        User currentUser = springSecurityService.loadCurrentUser()
        Collaborator currentCollaborator = currentUser.collaborator

        Double quantityOfCoins = Collect.createCriteria().get {
            createAlias("collaborator", "c")

            projections {
                sum('quantityOfCoins')
            }
            eq("c.id", currentCollaborator.id)
        }
        def response = ["quantityOfCoins": quantityOfCoins]

        render response as JSON
    }


}
