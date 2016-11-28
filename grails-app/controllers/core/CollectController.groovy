package core

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.SynchronizerTokensHolder

@Transactional(readOnly = true)
//@Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
@Secured(['ROLE_COLLABORATOR'])
class CollectController {
//// render a file
// //render(file: new File(absolutePath), fileName: "book.pdf")

    private invalidToken(message) {
        def response = [:]
        String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)
        response = [error: 'Invalid_Token', newToken: newToken]
        if (message)
            response += message
        render response as JSON
    }

    private successToken(message) {
        def response = [:]
        String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)
        response = [success: 'sucesso', newToken: newToken]
        if (message)
            response += message
        render response as JSON
    }

    private verifyErrors(InstanceClass) {
        if (InstanceClass.hasErrors()) {
            def listErrors = []

            InstanceClass.errors.allErrors.each { error ->
                listErrors += g.message(code: error.defaultMessage, error: error)
            }

            def message = [error: listErrors]
            render message as JSON
        }
    }

    def create() {
        List materialTypeList = MaterialType.list()
        render(view: "create", model: [materialTypes: materialTypeList])
    }

    @Transactional
    //Todo: mudar a view , remover o form e inserir as tags do grails, usar o plugin de upload
    def save() {
        withForm {
            Collect collect = new Collect()
            //ID COLLABORATOR LOGGED IN
            Collaborator collaborator = Collaborator.get(1)

            if (!collaborator) {
//                def message = [error: 'Não existem colaboradores cadastrados.<br>Por favor cadastre um colaborador']
//            render message as JSON
//                return render(view: 'create', message: message, model: [materialTypes: MaterialType.list()])

                invalidToken([error: 'Não existem colaboradores cadastrados.<br>Por favor cadastre um colaborador'])

            }
            collect.collaborator = collaborator

            collect.orderDate = new Date()
            collect.isCollected = false
            collect.materialTypes = []
            params.materialTypes?.each { materialTypeId ->
                MaterialType m = MaterialType.findById(materialTypeId)
                collect.addToMaterialTypes(m)
            }
            collect.imageUpload = null

            // File Upload
            if (params.imageUpload) {
                if (params.imageUpload instanceof org.springframework.web.multipart.commons.CommonsMultipartFile) {
                    def fileName = java.util.UUID.randomUUID().toString()
                    new FileOutputStream('C:/Trashpoints/Uploads/' + fileName).leftShift(params.imageUpload.getInputStream())
                    collect.imageUpload = fileName
                } else {
                    log.error("wrong attachment type [${params.imageUpload.getClass()}]")
                }
            }

            collect.validate()

            def errors = verifyErrors(collect)

            if (!errors) {
                collect.save(flush: true)
//            def message = [success: "Dados para coleta salvos com sucesso!"]
//            message as JSON
//            render(view: 'create', message: message, model: [materialTypes: MaterialType.list()])

                successToken([success: "Dados para coleta salvos com sucesso!"])
            }
        }.invalidToken {
            invalidToken("")
        }


    }

    def myCollections() {
        //ID COLLABORATOR LOGGED IN
        def collaboratorId = 1
        def collaboratorCollections = Collaborator.findById(collaboratorId)?.collects?.sort { it.orderDate }

        if (collaboratorCollections == null) {
            render(view: "myCollections", model: ["collaboratorCollections": []])
        } else {
            render(view: "myCollections", model: ["collaboratorCollections": collaboratorCollections])
        }
    }

    def markWasCollected() {
        withForm {
            def collectId = params.id
            def response = [:]

            Collect collect = Collect.get(collectId)
            if (collect) {
                collect.isCollected = true
                collect.collectedDate = new Date()
                def collectedDateWithOutHour = collect.collectedDate.format("dd/MM/yyyy")
                collect.save(flush: true)

                successToken([collectedDate: collectedDateWithOutHour])
            }
        }.invalidToken {
            invalidToken("")
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
        def response = ["imagePath": imagePath]
        render response as JSON
    }

    /*def list() {
        //ID COLLABORATOR LOGGED IN
        def collaboratorId = 1
        def collaboratorCollections = Collaborator.get(collaboratorId)?.collects

        render collaboratorCollections as JSON
    }*/



}
