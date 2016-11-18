package core

import grails.converters.JSON
import grails.transaction.Transactional

@Transactional(readOnly = true)
class ClientController {

    def create() {
        render (view: "create")
    }

    def list() {
        def clients = Client.list()
        render clients as JSON
    }

    @Transactional
    def save() {

        Client client = new Client()

        Address addressCollect = new Address()



//        def passwordHash = params.password.encodeAsSHA256()
//
//        user.email = params.email
//        user.password = passwordHash

        client.name = params.name
        client.phone = params.phone
        client.photo = params.photo
        client.isAddressEqual = params.isAddressEqual
        client.dateOfBirth = new Date()//Date.parse('dd-MM-yyyy', params.dateOfBirth)

        addressCollect.zipCode = params.zipCode
        addressCollect.street = params.street
        addressCollect.number = params.number
        addressCollect.neighborhood = params.neighborhood
        addressCollect.city = params.city
        addressCollect.state = params.state
        addressCollect.latitude = params.latitude
        addressCollect.longitude = params.longitude

        client.address = addressCollect

//        user.validate()
        addressCollect.validate()
        client.validate()


        if(client.hasErrors()) {
            def listErrors = []

            client.errors.each { error ->
                listErrors += g.message(code: error.fieldError.defaultMessage, error: error.fieldError)
            }

            def message = [error: listErrors]
            render message as JSON
        }
        if(addressCollect.hasErrors()) {
            def listErrors = []

            addressCollect.errors.each { error ->
                listErrors += g.message(code: error.fieldError.defaultMessage, error: error.fieldError)
            }

            def message = [error: listErrors]
            render message as JSON
        }else{
            client.save(flush: true)

            def message = [success: 'Dados cadastrais salvos com sucesso']
            render message as JSON

//            redirect view: "index"
        }
    }

}
