package core

import grails.converters.JSON

class ClientController {

    def create() {
        //render (view: "create")
    }

    def list() {
        def clients = Client.list()
        render clients as JSON
    }
}
