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

        ///def passwordddHash = params.password

        client.name = params.name
        client.email = params.email
        client.password = params.password
        client.phone = params.phone
        client.photo = params.photo
        client.isAddressEqual = params.isAddressEqual

        addressCollect.zipCode = params.zipCode
        addressCollect.street = params.street
        addressCollect.number = params.number
        addressCollect.neighborhood = params.neighborhood
        addressCollect.city = params.city
        addressCollect.state = params.state
        addressCollect.latitude = params.latitude
        addressCollect.longitude = params.longitude

        client.addresses.add(addressCollect)

        if(!client.isAddressEqual){
            Address addressPersonal = new Address()

            addressPersonal.zipCode = params.zipCode2
            addressPersonal.street = params.street2
            addressPersonal.number = params.number2
            addressPersonal.neighborhood = params.neighborhood2
            addressPersonal.city = params.city2
            addressPersonal.state = params.state2
            addressPersonal.latitude = params.latitude2
            addressPersonal.longitude = params.longitude2

            client.addresses.add(addressPersonal)
        }

        client.validate()

        if(client.hasErrors()){
            def listErrors = []

            client.errors.each { error ->
                listErrors += g.message(code: error.fieldError.defaultMessage, error: error.fieldError)
            }

            def message = [error: listErrors]
            render message as JSON
        }else{
            client.save flush: true

            render (view: "/Trashpoints")
        }
    }
}
