package core

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.SynchronizerTokensHolder
import org.hibernate.criterion.CriteriaSpecification

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

            user.username = params.j_username
            user.password = params.j_password

            if (params.typeOfCompany && params.typeOfCompany == "coleta") {
                String userRole = Role.findByAuthority('ROLE_COMPANY_COLLECT')
            } else {
                String userRole = Role.findByAuthority('ROLE_COMPANY_PARTNER')
            }

            address.zipCode = params.zipCode
            address.street = params.street
            address.number = params.number
            address.neighborhood = params.neighborhood
            address.city = params.city
            address.state = params.states
            address.latitude = params.latitude ? params.latitude.toFloat() : 0f
            address.longitude = params.longitude ? params.longitude.toFloat() : 0f

            company.companyName = params.companyName
            company.identificationNumber = params.identificationNumber
            company.tradingName = params.tradingName
            //company.segment = params.segment
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

    def myCollectedCollections() {
        User currentUser = springSecurityService.loadCurrentUser()
        Company currentCompany = currentUser.company

        Integer pageIndex = params.pageIndex ? params.pageIndex.toInteger() : 1
        pageIndex = pageIndex <= 0 ? 1 : pageIndex
        Integer offset = 5, maxResult = 5

        def companyCollections = Collect.createCriteria().list(max: maxResult, offset: (pageIndex - 1 * offset)) {
            createAlias("company", "c")
            eq("c.id", currentCompany.id)
            eq("isCollected", true)
            order("orderDate", "desc")
        }

        Integer totalCount = companyCollections.getTotalCount()

        if (companyCollections == null)
            render(view: "myCollectedCollections", model: ["companyCollections": []])
        else
            render(view: "myCollectedCollections", model: ["companyCollections": companyCollections, "numberOfPages": totalCount / maxResult])

    }

    @Transactional
    def myCollectionsInProgress() {
        User currentUser = springSecurityService.loadCurrentUser()
        Company currentCompany = currentUser.company

        Integer pageIndex = params.pageIndex ? params.pageIndex.toInteger() : 1
        pageIndex = pageIndex <= 0 ? 1 : pageIndex
        Integer offset = 5, maxResult = 5

        def companyCollections = Collect.createCriteria().list(max: maxResult, offset: (pageIndex - 1 * offset)) {
            createAlias("company", "c")
            eq("c.id", currentCompany.id)
            eq("isCollected", false)
            order("orderDate", "desc")
        }

        //FIND: schedule date exceeded
        companyCollections.each { companyCollect ->
            if(companyCollect.scheduleDateCollect > new Date()){
                companyCollect.scheduleDateCollect = null
                companyCollect.company = null
                companyCollect.save(flush: true)
            }
        }

        Integer totalCount = companyCollections.getTotalCount()

        if (companyCollections == null) {
            render(view: "myCollectionsInProgress", model: ["companyCollections": []])
        } else {
            render(view: "myCollectionsInProgress", model: ["companyCollections": companyCollections, "numberOfPages": totalCount / maxResult])
        }
    }

    @Transactional
    def markWasCollected() {
        Long collectId = params.collectId.toLong()
        withForm {
            User currentUser = springSecurityService.getCurrentUser()
            Company currentCompany = currentUser.company

            Collect collect = Collect.get(collectId)
            if (collect) {
                collect.isCollected = true
                collect.collectedDate = new Date()
                collect.company = currentCompany
                def collectedDateWithOutHour = collect.collectedDate.format("dd/MM/yyyy")
                collect.quantityOfCoins = 5.0
                collect.save(flush: true)

                successToken([collectedDate: collectedDateWithOutHour])
            }
        }.invalidToken {
            invalidToken()
        }

    }

    def loadCollaboratorDetails() {
        Integer collaboratorId = params.id.toInteger()
        Collaborator collaborator = Collaborator.findById(collaboratorId)
        Address address = collaborator.address

        def response = ["collaborator": collaborator, "address": address]
        render response as JSON
    }

    def editCompany() {
        User currentUser = springSecurityService.currentUser as User
        // TODO: verificar no contexto do Spring como atualizar o vínculo entre usuário e companhia
        Company currentCompany = currentUser.company
        currentCompany = Company.findById(currentCompany.id)
        render(view: "edit", model: ["currentCompany": currentCompany])
    }

    @Transactional
    def saveEditCompany() {
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
//            company.segment = params.segment
//            company.typeOfCompany = params.typeOfCompany
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
                } catch (Exception ex) {
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

    def getMyLocation() {
        User currentUser = springSecurityService.loadCurrentUser()
        Company currentCompany = currentUser.company

        def location = Company.createCriteria().get {
            resultTransformer(CriteriaSpecification.ALIAS_TO_ENTITY_MAP)
            createAlias("address", "adr")
            projections {
                property("adr.latitude", "latitude")
                property("adr.longitude", "longitude")
                property("adr.city", "city")
                property("adr.state", "state")
            }
            idEq(currentCompany.id)
        }
        render location as JSON
    }

    def list() {

    }
}
