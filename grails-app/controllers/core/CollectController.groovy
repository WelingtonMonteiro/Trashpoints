package core

import grails.converters.JSON

class CollectController {

    def create() {
        List materialTypeList = MaterialType.list()
        render(view: "create", model: [materialTypes : materialTypeList])
    }

    def save() {
        Collect collect = new Collect()
        //ID COLLABORATOR LOGGED IN
        Collaborator collaborator = Collaborator.get(1)
        collect.collaborator = collaborator

        collect.orderDate = new Date()
        collect.isCollected = false
        collect.materialTypes = []
        params.materialTypes?.each {materialTypeId ->
            MaterialType m = MaterialType.findById(materialTypeId)
            collect.addToMaterialTypes(m)
        }
        collect.imageUpload = null

        // File Upload
        if (params.imageUpload){
            if(params.imageUpload instanceof org.springframework.web.multipart.commons.CommonsMultipartFile){
                def fileName = java.util.UUID.randomUUID().toString()
                new FileOutputStream('C:/Trashpoints/Uploads/' + fileName).leftShift( params.imageUpload.getInputStream())
                collect.imageUpload = fileName
            }else{
                log.error("wrong attachment type [${params.imageUpload.getClass()}]");
            }
        }

        collect.validate()
        if(collect.hasErrors()){
            def listErrors = []

            collect.errors.allErrors.each { error ->
                listErrors += g.message(code: error.defaultMessage, error: error)
            }

            def message = [error: listErrors]
            render message as JSON
        }else{
            collect.save(flush: true)
            def message = [success: "Dados para coleta salvos com sucesso!"]
            render message as JSON
        }
    }

    def myCollections() {
        //ID COLLABORATOR LOGGED IN
        def collaboratorId = 1
        def collaboratorCollections = Collaborator.get(collaboratorId)?.collects

        if(collaboratorCollections == null) {
            render(view: "myCollections", model: ["collaboratorCollections": []])
        } else {
            render(view: "myCollections", model: ["collaboratorCollections": collaboratorCollections])
        }
    }

    def listCollect() {
        //ID COLLABORATOR LOGGED IN
        def collaboratorId = 1
        def collaboratorCollections = Collaborator.get(collaboratorId)?.collects

        render(template:"/collect/listCollections", model:[collaboratorCollections: collaboratorCollections])
    }

    def markWasCollected() {
        def collectId = params.id
        def message = [:]

        Collect collect = Collect.get(collectId)
        if (collect){
            collect.isCollected = true
            collect.save(flush: true)

            message = [success: 'Coleta recolhida']
            render message as JSON
        }
    }
}
