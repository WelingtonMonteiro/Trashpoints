package core

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.SynchronizerTokensHolder
import org.hibernate.criterion.CriteriaSpecification
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

    private isCollectSelected(instanceCollect) {
        String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)
        if (instanceCollect.company) {
            def error = "Coleta já selecionada por outra empresa"
            def response = [error: error, newToken: newToken]
            render response as JSON
        } else
            return false
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

    @Secured(['ROLE_COMPANY_COLLECT'])
    def placesCollect() {
        render(view: "placesCollect")
    }

    @Secured(['ROLE_COMPANY_COLLECT'])
    def listPlacesCollect() {
        def collects = Collect.createCriteria().list {
            resultTransformer(CriteriaSpecification.ALIAS_TO_ENTITY_MAP)
            createAlias("collaborator", "c")
            createAlias("c.address", "adr")
            projections {
                property("id", "collectId")
                property("adr.latitude", "lat")
                property("adr.longitude", "lng")
            }
            eq("isCollected", false)
        }
        render collects as JSON
    }

    @Secured(['ROLE_COMPANY_COLLECT'])
    def listInfoCollect() {
        Integer collectId = params.id.toInteger()

        def infoCollect = Collect.createCriteria().get {
            resultTransformer(CriteriaSpecification.ALIAS_TO_ENTITY_MAP)
            createAlias("collaborator", "c")
            createAlias("c.address", "adr")
            createAlias("company", "comp", CriteriaSpecification.LEFT_JOIN)

            projections {
                property("orderDate", "orderDate")
                property("imageUpload", "imageCollect")
                property("c.name", "nameColaborator")
                property("adr.street", "street")
                property("adr.number", "number")
                property("adr.neighborhood", "neighborhood")
                property("adr.city", "city")
                property("adr.state", "state")
                property("comp.companyName", "companyName")
            }
            idEq(collectId)
        }
        infoCollect.orderDate = infoCollect.orderDate.format("dd/MM/yyyy")

        def materialTypes = Collect.createCriteria().list {
            resultTransformer(CriteriaSpecification.DISTINCT_ROOT_ENTITY)
            createAlias("materialTypes", "material")

            projections {
                property("material.name", "materialTypes")
            }
            idEq(collectId)
        }

        def response = ["infoCollect": infoCollect, "materialTypes": materialTypes]

        render response as JSON
    }

    @Secured(['ROLE_COMPANY_COLLECT'])
    @Transactional
    def collectRecycling() {
        withForm {
            Integer collectId = params.id.toInteger()
            User currentUser = springSecurityService.getCurrentUser()
            Company currentCompany = currentUser.company
            Date collectDate = new Date().parse("dd/MM/yyyy", params.scheduleDate.toString())
            String[] splittedHours = params.scheduleHour.toString().split(':')
            collectDate.setHours(splittedHours[0].toInteger())
            collectDate.setMinutes(splittedHours[1].toInteger())

            Collect collect = Collect.findById(collectId)
            if (collect && isCollectSelected(collect) == false) {
                collect.company = currentCompany
                collect.setScheduleDateCollect(collectDate)
                collect.save(flush: true)
                successToken("")
            }
        }.invalidToken {
            invalidToken("")
        }
    }

    @Secured(['ROLE_COMPANY_COLLECT'])
    @Transactional
    def updateDateTimeCollect() {
        Integer collectId = params.id.toInteger()
        Date collectDate = new Date().parse("dd/MM/yyyy", params.scheduleDate.toString())
        String[] splittedHours = params.scheduleHour.toString().split(':')
        collectDate.setHours(splittedHours[0].toInteger())
        collectDate.setMinutes(splittedHours[1].toInteger())

        Collect collect = Collect.findById(collectId)
        collect.setScheduleDateCollect(collectDate)
        collect.save(flush: true)
        successToken("")
    }


}
