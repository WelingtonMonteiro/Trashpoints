package core



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
        def companyColRole = Role.findByAuthority('ROLE_COMPANY_COLLECT') ?: new Role('ROLE_COMPANY_COLLECT').save(flush: true)

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

}
