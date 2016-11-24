package core

import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class CompanyController {

    def create() {
        render(view: "create")
    }

    @Transactional
    def save() {
        Address address = new Address()

        address.zipCode = params.zipCode
        address.street = params.street
        address.number = params.number
        address.neighborhood = params.neighborhood
        address.city = params.city
        address.state = params.states
        println(params)
        Company company = new Company()

        company.companyName = params.companyName
//        company.email = params.email
//        def passwordHash = params.password.encodeAsSHA256()
//        company.password = passwordHash
        company.identificationNumber = params.identificationNumber
        company.tradingName = params.tradingName
        company.segment = params.segment
        company.typeOfCompany = params.typeOfCompany
        company.phone = params.phone
        company.site = params.site
        company.address = address

        address.validate()
        company.validate()

        if(company.hasErrors()) {
            def listErrors = []

            company.errors.allErrors.each { error ->
                listErrors += g.message(code: error.defaultMessage, error: error)
            }

            def message = [error: listErrors]
            render message as JSON
        }else
            if(address.hasErrors()) {
                def listErrors = []

                address.errors.allErrors.each { error ->
                    listErrors += g.message(code: error.defaultMessage, error: error)
                }

                def message = [error: listErrors]
                render message as JSON
            }else{
                company.save(flush: true)
//                redirect(action: "create", controller: "collect")

                def message = [success: 'Dados cadastrais salvos com sucesso']
                render message as JSON
            }
    }

    def myCollections() {
        //ID COMPANY LOGGED IN
        def companyId = 1
        //def companyCollections = Company.findById(companyId)?.collects.sort{it.orderDate}
        def companyCollections = Collect.createCriteria().list{
            order("orderDate")
        }

        if(companyCollections == null) {
            render(view: "myCollections", model: ["companyCollections": []])
        } else {
            render(view: "myCollections", model: ["companyCollections": companyCollections])
        }
    }

    @Transactional
    def markWasCollected() {
        Integer collectId = params.id.toInteger()
        def response = [:]

        Collect collect = Collect.get(collectId)
        if (collect){
            collect.isCollected = true
            collect.collectedDate = new Date()
            def collectedDateWithOutHour = collect.collectedDate.format("dd/MM/yyyy")
            collect.save(flush: true)

            response = [success: 'sucesso', collectedDate: collectedDateWithOutHour]
            render response as JSON
        }
    }

    def loadCollaboratorDetails() {
        Integer collaboratorId = params.id.toInteger()
        Collaborator collaborator = Collaborator.findById(collaboratorId)
        Address address = collaborator.address

        def response = ["collaborator": collaborator, "address": address]
        render response as JSON
    }

    def list() {
        def companies = Company.createCriteria().list(){
            address {
            }
        }
        render companies as JSON
    }

}
