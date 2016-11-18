package core

import grails.converters.JSON

class CollectController {

    def create() {
        List materialTypeList = MaterialType.list()
        render(view: "create", model: [materialTypes : materialTypeList])
    }

    def save() {
        Collect collect = new Collect()
        collect.date = new Date()
        collect.materialTypes = new ArrayList<MaterialType>()
        params.materialTypes?.each {materialTypeId ->
            MaterialType m = MaterialType.findById(materialTypeId)
            collect.materialTypes.add(m)
        }
        collect.image_upload = null
        // File Upload
        if (params.image_upload){
            if(params.image_upload instanceof org.springframework.web.multipart.commons.CommonsMultipartFile){
                def fileName = java.util.UUID.randomUUID().toString()
                new FileOutputStream('C:/Trashpoints/Uploads/' + fileName).leftShift( params.image_upload.getInputStream())
                collect.image_upload = fileName
            }else{
                log.error("wrong attachment type [${params.image_upload.getClass()}]");
            }
        }
        //
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
