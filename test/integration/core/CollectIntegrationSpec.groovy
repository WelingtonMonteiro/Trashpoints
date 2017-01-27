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
        Address address = new Address()
        address.city = "Lorena"
        address.state = "SP"
        address.zipCode = "12602-010"
        address.latitude = 0f
        address.longitude = 0f
        address.neighborhood = "Cabelinha"
        address.street = "Rua Dr. Paulo Cardoso"
        address.number = "453"
        address = address.save(flush: true)

        Collaborator collaborator = new Collaborator()
        collaborator.name = "João"
        collaborator.dateOfBirth = new Date()
        collaborator.isAddressEqual = true
        collaborator.phone = "(11) 1111-1111"
        collaborator.photo = ""
        collaborator.address = address
        collaborator = collaborator.save(flush: true)

        Company company = new Company()
        company.identificationNumber = "99.999.999/9999-99"
        company.tradingName = "Empresa Teste"
        company.segment = "Segmento Teste"
        company.typeOfCompany = "coleta" //coleta ou parceira
        company.phone = "(99) 9999-9999"
        company.site = "http://www.teste.com.br"
        company.address = address
        company = company.save(flush: true)

        Collect collect = new Collect()
        collect.orderDate = new Date()
        collect.collectedDate = new Date()
        collect.imageUpload = "teste.png"
        collect.isCollected = false
        collect.collaborator = collaborator
        collect.company = company
        collect = collect.save(flush: true)
        println(collect)

        CollectController controller = new CollectController()

        controller.listPlacesCollect()
        then:
        controller.response.json.collects != null
        controller.response.json != null
        println(controller.response.json.collects)
        println(controller.response.json)

    }

    void "List Places to Collect empty"() {
        when:
        CollectController controller = new CollectController()

        controller.listPlacesCollect()
        then:
        controller.response.json.collects == null
    }

}
