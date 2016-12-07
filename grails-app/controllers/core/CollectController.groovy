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

    private hasMaterialTypes(instanceCollect) {
        String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)
        println("Count " + instanceCollect.materialTypes.size())
        def listErrors = []

        if (instanceCollect.materialTypes.size() == 0) {
            listErrors += "Selecione pelo menos uma opção"
            def response = [error: listErrors, newToken: newToken]
            render response as JSON
        }
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
        hasMaterialTypes(InstanceClass)
    }

    def create() {
        List materialTypeList = MaterialType.list()
        render(view: "create", model: [materialTypes: materialTypeList])
    }

    def upload(collectInstance) {

        def nameUpload = java.util.UUID.randomUUID().toString()

        def file = params.imageUpload

        // List of  mime-types
        if (!acceptImages.contains(file.getContentType())) {
            render(view: "/collect/create")
        }

        if (!file.empty) {
            nameUpload = nameUpload + "." + file.contentType.replace("image/", "")
            collectInstance.imageUpload = nameUpload

            file.transferTo(new File("web-app/images/uploads/${nameUpload}"))

        } else {
            print "não foi possível transferir o arquivo"
            render(view: "/collect/create")
        }
    }

    @Transactional
    def save() {
        withForm {
            Collect collect = new Collect()
            User currentUser = springSecurityService.loadCurrentUser()
            Collaborator currentCollaborator = currentUser.collaborator

            collect.collaborator = currentCollaborator
            collect.orderDate = new Date()
            collect.isCollected = false
            collect.materialTypes = []
            params.materialTypes?.each { materialTypeId ->
                MaterialType materialType = MaterialType.findById(materialTypeId)
                if (materialType)
                    collect.addToMaterialTypes(materialType)
            }

            def fileUpload = request.getFile("imageUpload")
            def fileName = fileUpload.getOriginalFilename()

            if (fileName)
                upload(collect)

            collect.validate()

            def errors = verifyErrors(collect)

            if (!errors) {
                collect.save(flush: true)
                successToken([success: "Dados para coleta salvos com sucesso!"])
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
