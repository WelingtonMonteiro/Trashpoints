package core

import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.SpringSecurityUtils
import org.codehaus.groovy.grails.web.servlet.mvc.SynchronizerTokensHolder
import org.springframework.web.context.request.RequestContextHolder
import spock.lang.*

/**
 *
 */
class CollectIntegrationSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "List Places to Collect"() {
        when:

        Address address = new Address()
        address.city = "Lorena"
        address.state = "SP"
        address.zipCode = "12602-010"
        address.latitude = -22.79F
        address.longitude = -45.22F
        address.neighborhood = "Cabelinha"
        address.street = "Rua Dr. Paulo Cardoso"
        address.number = "453"

        address.validate()
        if (!address.hasErrors())
            address = address.save(flush: true)
        else {
            print address.errors.allErrors
            throw new Exception("error address")
        }

        Collaborator collaborator = new Collaborator()
        collaborator.name = "João da Silva"
        collaborator.dateOfBirth = new Date()
        collaborator.isAddressEqual = true
        collaborator.phone = "(11) 1111-1111"
        collaborator.photo = ""
        collaborator.address = address

        collaborator.validate()
        if (!collaborator.hasErrors())
            collaborator = collaborator.save(flush: true)
        else {
            print collaborator.errors.allErrors
            throw new Exception("error collaborator")
        }

        Company company = new Company()
        company.identificationNumber = "99.999.999/9999-99"
        company.companyName = "Empresa Teste"
        company.tradingName = "Empresa Teste LTDA"
        company.segment = "Segmento Teste"
        company.typeOfCompany = "coleta" //coleta ou parceira
        company.phone = "(99) 9999-9999"
        company.site = "http://www.teste.com.br"
        company.address = address

        company.validate()
        if (!company.hasErrors())
            company = company.save(flush: true)
        else {
            print company.errors.allErrors
            throw new Exception("error company")
        }

        User user = new User()
        user.username = "empresa@trashpoints.com.br"
        user.password = "123456"
        user.company = company

        user.validate()
        if (!user.hasErrors())
            user = user.save(flush: true)
        else {
            print user.errors.allErrors
            throw new Exception("error user")
        }

        //company.user = user
        //company = company.save(flush: true)

        Collect collect = new Collect()
        collect.orderDate = new Date()
        collect.collectedDate = new Date()
        collect.imageUpload = "teste.png"
        collect.isCollected = false
        collect.collaborator = collaborator
        collect.company = company

        collect.validate()
        if (!collect.hasErrors())
            collect = collect.save(flush: true)
        else {
            print collect.errors.allErrors
            throw new Exception("error collect")
        }

        CollectController controller = new CollectController()

        controller.listPlacesCollect()
        then:
        controller.response.json.size() > 0
        println(controller.response.json)
    }

    void "List Places to Collect empty"() {
        when:
        CollectController controller = new CollectController()

        controller.listPlacesCollect()
        then:
        controller.response.json.size() == 0
    }

    void "List Information about collect"() {
        when:
        Address address = new Address()
        address.city = "Lorena"
        address.state = "SP"
        address.zipCode = "12602-010"
        address.latitude = -22.79F
        address.longitude = -45.22F
        address.neighborhood = "Cabelinha"
        address.street = "Rua Dr. Paulo Cardoso"
        address.number = "453"

        address.validate()
        if (!address.hasErrors())
            address = address.save(flush: true)
        else {
            print address.errors.allErrors
            throw new Exception("error address")
        }

        Collaborator collaborator = new Collaborator()
        collaborator.name = "João da Silva"
        collaborator.dateOfBirth = new Date()
        collaborator.isAddressEqual = true
        collaborator.phone = "(11) 1111-1111"
        collaborator.photo = ""
        collaborator.address = address

        collaborator.validate()
        if (!collaborator.hasErrors())
            collaborator = collaborator.save(flush: true)
        else {
            print collaborator.errors.allErrors
            throw new Exception("error collaborator")
        }

        Company company = new Company()
        company.identificationNumber = "99.999.999/9999-99"
        company.companyName = "Empresa Teste"
        company.tradingName = "Empresa Teste LTDA"
        company.segment = "Segmento Teste"
        company.typeOfCompany = "coleta" //coleta ou parceira
        company.phone = "(99) 9999-9999"
        company.site = "http://www.teste.com.br"
        company.address = address

        company.validate()
        if (!company.hasErrors())
            company = company.save(flush: true)
        else {
            print company.errors.allErrors
            throw new Exception("error company")
        }

        Collect collect = new Collect()
        collect.orderDate = new Date()
        collect.collectedDate = new Date()
        collect.imageUpload = "teste.png"
        collect.isCollected = false
        collect.collaborator = collaborator
        collect.company = company
        collect.materialTypes = []

        MaterialType materialType1 = new MaterialType()
        materialType1.name = 'material 1'

        materialType1.validate()
        if (!materialType1.hasErrors())
            materialType1 = materialType1.save(flush: true)
        else {
            print materialType1.errors.allErrors
            throw new Exception("error materialType1")
        }

        MaterialType materialType2 = new MaterialType()
        materialType2.name = 'material 2'

        materialType2.validate()
        if (!materialType2.hasErrors())
            materialType2 = materialType2.save(flush: true)
        else {
            print materialType2.errors.allErrors
            throw new Exception("error materialType2")
        }
        collect.addToMaterialTypes(materialType1)
        collect.addToMaterialTypes(materialType2)

        collect.validate()
        if (!collect.hasErrors())
            collect = collect.save(flush: true)
        else {
            print collect.errors.allErrors
            throw new Exception("error collect")
        }
        println(collect)
        CollectController controller = new CollectController()
        controller.params.id = collect.id

        controller.listInfoCollect()
        then:
        controller.response.json.materialTypes.size() == 2
        controller.response.json.infoCollect.nameColaborator == "João da Silva"
    }

    void "Mark that the company will collect one recycling"() {
        when:
        CollectController controller = new CollectController()

        Collect collect = new Collect()
        collect.orderDate = new Date()
        collect.collectedDate = new Date()
        collect.imageUpload = "teste.png"
        collect.isCollected = false
        collect.collaborator = Collaborator.findByName("welington monteiro")
        collect.company = null

        collect.validate()
        if (!collect.hasErrors())
            collect = collect.save(flush: true)
        else {
            print collect.errors.allErrors
            throw new Exception("error collect")
        }

        SpringSecurityUtils.doWithAuth("ccoleta@trashpoints.com.br") {
            def tokenHolder = SynchronizerTokensHolder.store(RequestContextHolder.currentRequestAttributes().session)
            controller.params[SynchronizerTokensHolder.TOKEN_URI] = '/collect/collectRecycling'
            controller.params[SynchronizerTokensHolder.TOKEN_KEY] = tokenHolder.generateToken(controller.params[SynchronizerTokensHolder.TOKEN_URI])

            controller.params.id = collect.id
            controller.params.scheduleDate = new Date().format('dd/MM/yyyy')
            controller.params.scheduleHour = '10:00'
            controller.collectRecycling()
        }

        then:
        controller.response.json.success == 'sucesso'
    }

    void "Mark that the company will collect two recycling"() {
        when:
        CollectController controller = new CollectController()

        Collect collect1 = new Collect()
        collect1.orderDate = new Date()
        collect1.collectedDate = new Date()
        collect1.imageUpload = "teste.png"
        collect1.isCollected = false
        collect1.collaborator = Collaborator.findByName("welington monteiro")
        collect1.company = null

        collect1.validate()
        if (!collect1.hasErrors())
            collect1 = collect1.save(flush: true)
        else {
            print collect1.errors.allErrors
            throw new Exception("error collect 1")
        }

        Collect collect2 = new Collect()
        collect2.orderDate = new Date()
        collect2.collectedDate = new Date()
        collect2.imageUpload = "teste.png"
        collect2.isCollected = false
        collect2.collaborator = Collaborator.findByName("welington monteiro")
        collect2.company = null

        collect2.validate()
        if (!collect2.hasErrors())
            collect2 = collect2.save(flush: true)
        else {
            print collect2.errors.allErrors
            throw new Exception("error collect 2")
        }

        SpringSecurityUtils.doWithAuth("ccoleta@trashpoints.com.br") {
            def tokenHolder = SynchronizerTokensHolder.store(RequestContextHolder.currentRequestAttributes().session)
            controller.params[SynchronizerTokensHolder.TOKEN_URI] = '/collect/collectRecycling'
            controller.params[SynchronizerTokensHolder.TOKEN_KEY] = tokenHolder.generateToken(controller.params[SynchronizerTokensHolder.TOKEN_URI])

            controller.params.id = collect1.id + "," + collect2.id
            controller.params.scheduleDate = new Date().format('dd/MM/yyyy')
            controller.params.scheduleHour = '10:00'
            controller.collectRecycling()
        }

        then:
        controller.response.json.success == 'sucesso'
    }

}
