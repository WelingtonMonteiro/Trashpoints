package core

import grails.converters.JSON

class CompanyController {

    def create() {
        render(view: "create")
    }

    def save() {
        Company company = new Company()

        company.name = params.name
        company.email = params.email
        def passwordHash = params.password.encodeAsSHA256()
        company.password = passwordHash
        company.identificationNumber = params.identificationNumber
        company.tradingName = params.tradingName
        company.segment = params.segment
        company.typeOfCompany = params.typeOfCompany
        company.phone = params.phone
        company.site = params.site
        company.zipCode = params.zipCode
        company.street = params.street
        company.number = params.number
        company.neighborhood = params.neighborhood
        company.city = params.city
        company.state = params.state

        company.validate()

        if(company.hasErrors()){
            def listErrors = []

            company.errors.each { error ->
                listErrors += g.message(code: error.fieldError.defaultMessage, error: error.fieldError)
            }

            def message = [error: listErrors]
            render message as JSON
        }else{
            company.save(flush: true)
            redirect(controller: "company", action: "create")
            //redirect (controller: "", view:"/")
        }
    }

    def list() {
        def companies = Company.list()
        render companies as JSON
    }

}
