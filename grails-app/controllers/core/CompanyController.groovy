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
        company.password = params.password
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
            def message = [error: company.errors.fieldErrors]
            render message as JSON
        }else{
            company.save(flush: true)
            redirect(view: "create")
        }
    }

    def list() {
        def companies = Company.list()
        render companies as JSON
    }

}
