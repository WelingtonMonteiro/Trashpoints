package core

import grails.converters.JSON

class ClientController {

    def create() {
        render (view: "create")
    }

    def list() {
        def clients = Client.list()
        render clients as JSON
    }

    def save() {

        Client client = new Client()
        Address addressCollect = new Address()

        def passwordHash = params.password.encodeAsSHA256()

        client.name = params.name
        client.email = params.email
        client.password = passwordHash
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

        addressCollect.validate()
        client.validate()

        if(client.hasErrors()) {
            def listErrors = []

            client.errors.each { error ->
                listErrors += g.message(code: error.fieldError.defaultMessage, error: error.fieldError)
            }

            def message = [error: listErrors]
            render message as JSON
        }else if(addressCollect.hasErrors()) {
            def listErrors = []

            addressCollect.errors.each { error ->
                listErrors += g.message(code: error.fieldError.defaultMessage, error: error.fieldError)
            }

            def message = [error: listErrors]
            render message as JSON
        }else{
            client.save(flush: true)

            render (view: "/Trashpoints")

        }
    }
}
