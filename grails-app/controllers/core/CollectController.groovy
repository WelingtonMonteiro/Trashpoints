package core

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.context.ServletContextHolder
import org.codehaus.groovy.grails.web.servlet.mvc.SynchronizerTokensHolder
import org.hibernate.criterion.CriteriaSpecification
import static java.util.UUID.randomUUID

@Transactional(readOnly = true)
@Secured(['ROLE_COLLABORATOR'])
class CollectController {
    //render(file: new File(absolutePath), fileName: "book.pdf")
    transient springSecurityService
    private static final acceptImages = ['image/png', 'image/jpeg', 'image/gif']
    private static final int MAX_DATE_SCHEDULE = 3
    //private static final int MAX_POINTS_SELECTED = 20

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
        def listErrors = []

        if (instanceCollect.materialTypes.size() == 0) {
            String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)

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
        if (instanceCollect.company) {
            String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)

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
        try {
            def nameUpload = randomUUID() as String

            def file = params.imageUpload

            // List of  mime-types
            if (!acceptImages.contains(file.getContentType())) {
                render(view: "/collect/create")
            }

            if (!file.empty) {
                /**
                 * upload files S3:
                 * https://github.com/kevinostoll/kevins3/blob/master/grails-app/controllers/kevins3/BucketObjectController.groovy
                 * http://www.tothenew.com/blog/integrating-amazon-s3-in-grails-application/
                 */

                nameUpload = nameUpload + "." + file.contentType.replace("image/", "")

                def serveletContext = ServletContextHolder.servletContext
                def storagePath = serveletContext.getRealPath("images/uploads/")

                def storagePathDirectory = new File(storagePath)

                if (!storagePathDirectory.exists()) {
                    println("Criando diretório ${storagePath}")
                    if (storagePathDirectory.mkdirs()) {
                        println "Diretorio criado"
                    } else {
                        println "Erro ao criar diretório"
                    }
                }

//            print ('DIRETORIO LOCAL: '+ serveletContext)
                print('URL LOCAL: ' + storagePath)


                collectInstance.imageUpload = nameUpload

                file.transferTo(new File("${storagePath}/${nameUpload}"))

            } else {
                print "não foi possível transferir o arquivo"
                render(view: "/collect/create")
            }
        } catch (e) {
            println ("Erro ao salvar arquivo: ${e}")
            invalidToken(["Erro ao salvar arquivo: ${e}"])
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
            def fileName = null
            if (fileUpload != null) {
                fileName = fileUpload.getOriginalFilename()
            }

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
            String ids = params.id
            def collectIds = ids.split(',').collect { it as int }
            collectIds.unique()
            User currentUser = springSecurityService.getCurrentUser()
            Company currentCompany = currentUser.company
            Date collectDate = new Date().parse("dd/MM/yyyy", params.scheduleDate.toString())
            //String[] splittedHours = params.scheduleHour.toString().split(':')
            //collectDate.setHours(splittedHours[0].toInteger())
            //collectDate.setMinutes(splittedHours[1].toInteger())

            for (collectId in collectIds) {
                Collect collect = Collect.findById(collectId)
                if (collect && isCollectSelected(collect) == false && isValidDate(collectDate)) {
                    collect.company = currentCompany
                    collect.setScheduleDateCollect(collectDate)
                    collect.save(flush: true)
                    Notification notification = new Notification()
                    notification.header = "Uma coleta foi registrada para você"
                    notification.body = "A empresa ${currentCompany.companyName} irá realizar sua coleta no dia ${collect.scheduleDateCollect.format("dd/MM/yyyy")}"
                    notification.username = collect.collaborator.user.username
                    notification.wasRead = 0
                    notification.save()
                }
            }
            successToken("")

        }.invalidToken {
            invalidToken("")
        }
    }

    /*@Secured(['ROLE_COMPANY_COLLECT'])
    @Transactional
    def updateDateTimeCollect() {
        Integer collectId = params.id.toInteger()
        Date collectDate = new Date().parse("dd/MM/yyyy", params.scheduleDate.toString())
        String[] splittedHours = params.scheduleHour.toString().split(':')
        collectDate.setHours(splittedHours[0].toInteger())
        collectDate.setMinutes(splittedHours[1].toInteger())
        Collect collect = Collect.findById(collectId)
        collect.setScheduleDateCollect(collectDate)
        if(isValidDate(collect.scheduleDateCollect)) {
            collect.save(flush: true)
            collect.save(flush: true)
			User currentUser = springSecurityService.getCurrentUser()
			Company currentCompany = currentUser.company
			Notification notification = new Notification()
			notification.header = "Alteração da data e hora da coleta"
			notification.body = "A empresa ${currentCompany.companyName} alterou uma de suas coletas para o dia ${collect.scheduleDateCollect.format("dd/MM/yyyy")} às ${collect.scheduleDateCollect.format("HH:mm:ss")}"
			notification.username = collect.collaborator.user.username
			notification.wasRead = 0
			notification.save(flush: true)
			successToken("")
        }
    }*/

    private isValidDate(scheduleDateCollect) {
        if (scheduleDateCollect >= new Date().clearTime() && scheduleDateCollect <= new Date() + MAX_DATE_SCHEDULE)
            return true
        else {
            String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)

            def error = "Data inválida"
            def response = [error: error, newToken: newToken]
            render response as JSON
        }
    }

    /*@Secured(['ROLE_COMPANY_COLLECT'])
    def leastOneCollectHasCompanyToCollect() {
        String ids = params.ids
        def collectIds = ids.split(',').collect{it as int}
        collectIds.unique()

        def infoCollections = Collect.createCriteria().list {
            resultTransformer(CriteriaSpecification.ALIAS_TO_ENTITY_MAP)
            createAlias("company", "comp", CriteriaSpecification.LEFT_JOIN)

            projections {
                property("comp.companyName", "companyName")
            }
            'in'("id", collectIds)
        }

        boolean leastOneCollectHasCompanyToCollect = false

        for(infoCollect in infoCollections){
            if(infoCollect.companyName){
                leastOneCollectHasCompanyToCollect = true
                break;
            }
        }

        def response = ["leastOneCollectHasCompanyToCollect": leastOneCollectHasCompanyToCollect]

        render response as JSON
    }*/
}
