package core

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.hibernate.criterion.CriteriaSpecification

@Transactional(readOnly = true)
@Secured(['ROLE_COLLABORATOR'])
//@Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
class CollaboratorController {

    def springSecurityService

    def create() {
        render (view: "create")
    }

    @Transactional
    def save() {
        Collaborator collaborator = new Collaborator()
        Address addressCollect = new Address()

//        def passwordHash = params.password.encodeAsSHA256()//
//        userManager.email = params.email
//        userManager.password = passwordHash

        collaborator.name = params.name
        collaborator.phone = params.phone
        collaborator.photo = params.photo
        collaborator.isAddressEqual = params.isAddressEqual
        collaborator.dateOfBirth = /*new Date()*/Date.parse('dd/MM/yyyy', params.dateOfBirth)

        addressCollect.zipCode = params.zipCode
        addressCollect.street = params.street
        addressCollect.number = params.number
        addressCollect.neighborhood = params.neighborhood
        addressCollect.city = params.city
        addressCollect.state = params.state
        addressCollect.latitude = params.latitude
        addressCollect.longitude = params.longitude

        collaborator.address = addressCollect

//        userManager.validate()
        addressCollect.validate()
        collaborator.validate()

        if(collaborator.hasErrors()) {
            def listErrors = []

            collaborator.errors.allErrors.each { error ->
                listErrors += g.message(code: error.defaultMessage, error: error)
            }

            def message = [error: listErrors]
            render message as JSON
        }
        if(addressCollect.hasErrors()) {
            def listErrors = []

            addressCollect.errors.allErrors.each { error ->
                listErrors += g.message(code: error.defaultMessage, error: error)
            }

            def message = [error: listErrors]
            render message as JSON
        }else{
            collaborator.save(flush: true)

            def message = [success: 'Dados cadastrais salvos com sucesso']
            render message as JSON

//            redirect view: "index"
        }
    }

    def myCollections() {
        //ID COLLABORATOR LOGGED IN
        def user = springSecurityService.currentUser
        def collaboratorId = 1//userManager?.collaborator?.id
        def collaboratorCollections = Collaborator.findById(collaboratorId)?.collects?.sort{it.orderDate}

        if(collaboratorCollections == null) {
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
