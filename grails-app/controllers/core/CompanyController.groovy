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

            company.errors.each { error ->
                listErrors += g.message(code: error.fieldError.defaultMessage, error: error.fieldError)
            }

            def message = [error: listErrors]
            render message as JSON
        }else
            if(address.hasErrors()) {
                def listErrors = []

                address.errors.each { error ->
                    listErrors += g.message(code: error.fieldError.defaultMessage, error: error.fieldError)
                }

                def message = [error: listErrors]
                render message as JSON
            }else{
                company.save(flush: true)
                redirect(action: "create", controller: "collect")
            }
    }

    def list() {
        def companies = Address.createCriteria().list(){
            user {

            }
        }
        render companies as JSON
    }

}
