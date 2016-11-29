package core

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.SynchronizerTokensHolder

@Transactional(readOnly = true)
@Secured(['ROLE_COMPANY_COLLECT'])
class CompanyController {

    transient springSecurityService

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
        def isErrors = false
        if (InstanceClass.hasErrors()) {
            def listErrors = []

            InstanceClass.errors.allErrors.each { error ->
                listErrors += g.message(code: error.defaultMessage, error: error)
            }

            String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)
            def message = [error: listErrors, newToken: newToken]
            render message as JSON

            isErrors = true
        }
        isErrors
    }

    @Transactional
    @Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
    def save() {
        withForm {

            Address address = new Address()
            Company company = new Company()
            User user = new User()
            def userRole = ""

            user.username = params.j_username
            user.password = params.j_password

            if(params.typeOfCompany && params.typeOfCompany == "coleta"){
                userRole = Role.findByAuthority('ROLE_COMPANY_COLLECT')
            }else{
                userRole = Role.findByAuthority('ROLE_COMPANY_PARTNER')
            }

            address.zipCode = params.zipCode
            address.street = params.street
            address.number = params.number
            address.neighborhood = params.neighborhood
            address.city = params.city
            address.state = params.states

            company.companyName = params.companyName
            company.identificationNumber = params.identificationNumber
            company.tradingName = params.tradingName
            company.segment = params.segment
            company.typeOfCompany = params.typeOfCompany
            company.phone = params.phone
            company.site = params.site

            company.address = address

            user.validate()
            address.validate()
            company.validate()

            def errors = verifyErrors(user) || verifyErrors(company) || verifyErrors(address)

            if (!errors) {
                company.save(flush: true)

                user.company = company

                user.save(flush: true)

                company.user = user

                company.save(flush: true)

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
        //User currentUser = springSecurityService.currentUser
        //Company currentCompany = currentUser.company
        //currentCompany = Company.findById(currentCompany.id)
        //def companyCollections = Company.findById(companyId)?.collects.sort{it.orderDate}
        def companyCollections = Collect.createCriteria().list {
            order("orderDate")
        }

        if (companyCollections == null) {
            render(view: "myCollections", model: ["companyCollections": []])
        } else {
            render(view: "myCollections", model: ["companyCollections": companyCollections])
        }
    }

    @Transactional
    def markWasCollected() {
        Long collectId = params.collectId.toLong()
        withForm {
            User currentUser = springSecurityService.currentUser
            Company currentCompany = currentUser.company

            Collect collect = Collect.get(collectId)
            if (collect) {
                collect.isCollected = true
                collect.collectedDate = new Date()
                collect.company = currentCompany
                def collectedDateWithOutHour = collect.collectedDate.format("dd/MM/yyyy")
                collect.save(flush: true)

                successToken([collectedDate: collectedDateWithOutHour])
            }
        }.invalidToken {
            invalidToken()
        }

    }

    def loadCollaboratorDetails() {
        Long collaboratorId = params.id.toLong()
        Collaborator collaborator = Collaborator.findById(collaboratorId)
        Address address = collaborator?.address

        def response = ["collaborator": collaborator, "address": address]
        render response as JSON
    }

    /*def list() {
        def companies = Company.createCriteria().list(){
            address {
            }
        }
        render companies as JSON
    }*/

    def editCompany(){
        User currentUser = springSecurityService.currentUser as User
        // TODO: verificar no contexto do Spring como atualizar o vínculo entre usuário e companhia
        Company currentCompany = currentUser.company
        currentCompany = Company.findById(currentCompany.id)
        render(view: "edit", model: ["currentCompany" : currentCompany])
    }

    @Transactional
    def saveEditCompany(){
        // TODO: controlar transação entre companhia e endereço
        withForm {
            Company company = Company.get(params.id)
            Address address = Address.get(company.addressId)
            address.zipCode = params.zipCode
            address.street = params.street
            address.number = params.number
            address.neighborhood = params.neighborhood
            address.city = params.city
            address.state = params.states
            company.companyName = params.companyName
            company.identificationNumber = params.identificationNumber
            company.tradingName = params.tradingName
            company.segment = params.segment
            company.typeOfCompany = params.typeOfCompany
            company.phone = params.phone
            company.site = params.site
            address.validate()
            company.validate()
            def errors = verifyErrors(company) || verifyErrors(address)
            if (!errors) {
                try {
                    address.save(flush: true)
                    company.address = address
                    company.save(flush: true)
                    successToken([success: 'Dados cadastrais salvos com sucesso'])
                } catch (Exception ex){
                    def response = [:]
                    String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)
                    response = [error: ex.message, newToken: newToken]
                    render response as JSON
                }
            }
        }.invalidToken {
            invalidToken()
        }
    }

}
