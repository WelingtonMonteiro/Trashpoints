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
}
