package core

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.SynchronizerTokensHolder
import org.springframework.web.multipart.MultipartFile
import org.springframework.web.multipart.MultipartHttpServletRequest

@Transactional(readOnly = true)
@Secured(['ROLE_COLLABORATOR'])
class CollectController {
//// render a file
// //render(file: new File(absolutePath), fileName: "book.pdf")
    transient springSecurityService

    private static final acceptImages = ['image/png', 'image/jpeg', 'image/gif']

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

    private successTokenRedirect(message) {
        def response = [:]
        String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)
        response = [success: 'sucesso', newToken: newToken]
        if (message)
            response += message
        response as JSON

//        redirect(action: 'create', message: response)
        render(view: "create", model: [materialTypes: MaterialType.list()], message: response)
    }

    private invalidTokenRedirect(message) {
        def response = [:]
        String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)
        response = [error: 'Invalid_Token', newToken: newToken]
        if (message)
            response += message
        response as JSON
        render(view: "create", model: [materialTypes: MaterialType.list()], message: response)
    }

    private verifyErrors(InstanceClass) {
        if (InstanceClass.hasErrors()) {
            def listErrors = []

            InstanceClass.errors.allErrors.each { error ->
                listErrors += g.message(code: error.defaultMessage, error: error)
            }

            String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)
            def message = [error: listErrors, newToken: newToken]
            render message as JSON
        }
    }

    def create() {
        List materialTypeList = MaterialType.list()
        render(view: "create", model: [materialTypes: materialTypeList])
    }

    def upload(imageInstance) {

        def nameUpload = java.util.UUID.randomUUID().toString()

        def file = params.imageUpload

        // List of  mime-types
        if (!acceptImages.contains(file.getContentType())) {

            redirect(action: 'create')
            return
        }

        if (!file.empty) {
            nameUpload = nameUpload + "." + file.contentType.replace("image/", "")
            imageInstance.imageUpload = nameUpload

            file.transferTo(new File("web-app/images/uploads/${nameUpload}"))

        } else {
            print "não foi possível transferir o arquivo"

            redirect(action: 'create')
            return
        }
    }

    @Transactional
    def save() {
        withForm {
            Collect collect = new Collect()
            User currentUser = springSecurityService.loadCurrentUser()
            Collaborator currentCollaborator = currentUser.collaborator

            if (!currentCollaborator) {
                invalidToken([error: 'Não existem colaboradores cadastrados.<br>Por favor cadastre um colaborador'])
            }
            collect.collaborator = currentCollaborator

            collect.orderDate = new Date()
            collect.isCollected = false
            collect.materialTypes = []
            params.materialTypes?.each { materialTypeId ->
                MaterialType m = MaterialType.findById(materialTypeId)
                collect.addToMaterialTypes(m)
            }
            println(params.imageUpload)
            if (params.imageUpload)
                upload(collect)

            collect.validate()

            def errors = verifyErrors(collect)

            if (!errors) {
                collect.save(flush: true)
//            def message = [success: "Dados para coleta salvos com sucesso!"]
//            message as JSON
//            render(view: 'create', message: message, model: [materialTypes: MaterialType.list()])

                successTokenRedirect([success: "Dados para coleta salvos com sucesso!"])
            }
        }.invalidToken {
            invalidToken("")
        }
    }

    @Secured(['ROLE_COLLABORATOR', 'ROLE_COMPANY_COLLECT'])
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
