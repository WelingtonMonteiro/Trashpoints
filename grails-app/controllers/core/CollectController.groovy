package core

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional

@Transactional(readOnly = true)
@Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
class CollectController {
//// render a file
// //render(file: new File(absolutePath), fileName: "book.pdf")

    def create() {
        List materialTypeList = MaterialType.list()
        render(view: "create", model: [materialTypes : materialTypeList])
    }

    @Transactional
    //Todo: mudar a view , remover o form e inserir as tags do grails,
    def save() {
        Collect collect = new Collect()
        //ID COLLABORATOR LOGGED IN
        Collaborator collaborator = Collaborator.get(1)

        if(!collaborator){
            def message = [error: 'Não existem colaboradores cadastrados.<br>Por favor cadastre um colaborador']
//            render message as JSON
            return render (view: 'create', message: message, model: [materialTypes : MaterialType.list()])

        }
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
            message as JSON
            render (view: 'create', message: message, model: [materialTypes : MaterialType.list()])

        }
    }

    def myCollections() {
        //ID COLLABORATOR LOGGED IN
        def collaboratorId = 1
        def collaboratorCollections = Collaborator.findById(collaboratorId)?.collects?.sort{it.orderDate}

        if(collaboratorCollections == null) {
            render(view: "myCollections", model: ["collaboratorCollections": []])
        } else {
            render(view: "myCollections", model: ["collaboratorCollections": collaboratorCollections])
        }
    }

    def markWasCollected() {
        def collectId = params.id
        def response = [:]

        Collect collect = Collect.get(collectId)
        if (collect){
            collect.isCollected = true
            collect.collectedDate = new Date()
            def collectedDateWithOutHour = collect.collectedDate.format("dd/MM/yyyy")
            collect.save(flush: true)

            response = [success: 'sucesso', collectedDate: collectedDateWithOutHour]
            render response as JSON
        }
    }

    def loadCollectImage() {
        Integer collectId = params.id.toInteger()
        def imagePath = Collect.createCriteria().get {
            idEq(collectId)
            projections {
                property("imageUpload")
            }
        }
        def response = ["imagePath": imagePath + '.jpg']
        render response as JSON
    }

    def list() {
        //ID COLLABORATOR LOGGED IN
        def collaboratorId = 1
        def collaboratorCollections = Collaborator.get(collaboratorId)?.collects

        render collaboratorCollections as JSON
    }

}
