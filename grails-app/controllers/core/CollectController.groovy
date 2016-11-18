package core

import grails.converters.JSON

class CollectController {

    def create() {
        render(view: "create")
    }

    def save() {
        Collect collect = new Collect()
        collect.date = params.date
        collect.type = params.type
        collect.image_upload = params.image_upload


        collect.validate()

        if(collect.hasErrors()){
            def message = [error: collect.errors.fieldErrors]
            render message as JSON
        }else{
            collect.save(flush: true)
            render(view: "create", controller: "company")
        }
    }

    def myCollections() {
        //ID CLIENT LOGGED IN
        def clientId = 1
        def clientCollections = Client.get(clientId).collects

        render(view: "myCollections", model: ["clientCollections": clientCollections])
    }

    def listCollect() {
        //ID CLIENT LOGGED IN
        def clientId = 1
        def clientCollections = Client.get(clientId).collects

        render(template:"/collect/listColletions", model:[clientCollections: clientCollections])
    }

    def markWasCollected() {
        def collectId = params.id.toLong()
        def message = [:]

        Collect collect = Collect.get(collectId)
        if (collect){
            collect.isCollected = true
            collect.save(flush: true)
            message = [success:"success"]
            render message as JSON
        }
    }

}
