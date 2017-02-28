package core

import grails.plugin.springsecurity.SpringSecurityService
import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import org.codehaus.groovy.grails.web.servlet.mvc.SynchronizerTokensHolder
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(CompanyController)
@Mock([Company, Address, Collect, Collaborator, Role, User, UserRole])
class CompanyControllerSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "Render Action Create"(){
        when:
        controller.create()
        then:
        view == "/company/create"
    }

    void "Save new Company"() {
        given:
        def companyColRole = Role.findByAuthority('ROLE_COMPANY_COLLECT') ?: new Role('ROLE_COMPANY_COLLECT').save(flush: true)

        when:
        def tokenHolder = SynchronizerTokensHolder.store(session)

        params[SynchronizerTokensHolder.TOKEN_URI] = '/company/save'
        params[SynchronizerTokensHolder.TOKEN_KEY] = tokenHolder.generateToken(params[SynchronizerTokensHolder.TOKEN_URI])

        params.j_username = "empresa@trashpoints.com.br"
        params.j_password = "123456"
        params.companyName = "Empresa Teste"
        params.identificationNumber = "99.999.999/9999-99"
        params.tradingName = "Empresa Teste"
        params.segment = "Segmento Teste"
        params.typeOfCompany = "coleta" //coleta ou parceira
        params.phone = "(99) 9999-9999"
        params.site = "http://www.teste.com.br"

        params.zipCode = "12509-330"
        params.street = "Rua Teste"
        params.number = "100"
        params.neighborhood = "Bairro Teste"
        params.city = "Cidade teste"
        params.states = "SP"

        controller.save()
        then:
        response.json.success != null
    }

    void "Save new Company with error"() {
        given:
        def companyColRole = Role.findByAuthority('ROLE_COMPANY_COLLECT') ?: new Role('ROLE_COMPANY_COLLECT').save(flush: true)

        when:
        def tokenHolder = SynchronizerTokensHolder.store(session)

        params[SynchronizerTokensHolder.TOKEN_URI] = '/company/save'
        params[SynchronizerTokensHolder.TOKEN_KEY] = tokenHolder.generateToken(params[SynchronizerTokensHolder.TOKEN_URI])

        params.j_username = "empresa@trashpoints.com.br"
        params.j_password = "123456"
        params.companyName = "Empresa Teste"
        params.identificationNumber = "99.999.999/9999-99"
        params.tradingName = "Empresa Teste"
        params.segment = "Segmento Teste"
        params.typeOfCompany = "coleta" //coleta ou parceira
        params.phone = "(99) 9999-9999"
        params.site = "http://www.teste.com.br"

        params.zipCode = "aaaaa"
        params.street = "Rua Teste"
        params.number = "100"
        params.neighborhood = "Bairro Teste"
        params.city = "Cidade teste"
        params.states = "SP"

        controller.save()
        then:
        response.json.error != null
    }

    void "Company mark that was collected one reclycling"() {
        given:
        def companyRole = Role.findByAuthority('ROLE_COMPANY_COLLECT') ?: new Role('ROLE_COMPANY_COLLECT').save(flush: true)

        def collectMock = mockFor(Collect)

        Company company = new Company(id: 1, companyName: "Empresa Coletora", identificationNumber: "11.111.111/1111-11",
                tradingName: "Coletora", segment: "reciclagem de lixo", typeOfCompany: "coleta",
                phone: "(11) 1111-1111", site: "http://www.dsdsds.com.br",
                address: new Address(city: "Lorena", state: "SP", zipCode: "12602-010", latitude: 0f, longitude: 0f,
                        neighborhood: "Cabelinha", street: "Rua Dr. Paulo Cardoso", number: "123"
                ))

        Collaborator collaborator = new Collaborator(id: 1, name: "João", dateOfBirth: new Date(), isAddressEqual: true,
                phone: "(11) 1111-1111", photo: "foto.png",
                address: new Address(city: "Lorena", state: "SP", zipCode: "12602-010", latitude: 0f, longitude: 0f,
                        neighborhood: "Cabelinha", street: "Rua Dr. Paulo Cardoso", number: "123"
                ))

        Collect collect = new Collect(id: 1, orderDate: new Date(), collectedDate: new Date(), imageUpload: "teste.png",
                isCollected: false, collaborator: collaborator, company: company)

        User loggedInUser = new User(id: 1, username: "empresa@trashpoints.com.br", password: "123456", company: company)
        def springSecurityService = mockFor(SpringSecurityService, true)
        springSecurityService.demand.getCurrentUser() { -> loggedInUser }
        controller.springSecurityService = springSecurityService.createMock()

        collectMock.demand.static.get() {Long id -> collect }

        when:
        def tokenHolder = SynchronizerTokensHolder.store(session)
        params[SynchronizerTokensHolder.TOKEN_URI] = '/company/markWasCollected'
        params[SynchronizerTokensHolder.TOKEN_KEY] = tokenHolder.generateToken(params[SynchronizerTokensHolder.TOKEN_URI])
        params.collectId = "1"

        controller.markWasCollected()
        then:
        response.json.success == 'Salvo com sucesso'
    }

    void "Load Collaborator Details"() {
        given:
        def companyRole = Role.findByAuthority('ROLE_COMPANY_COLLECT') ?: new Role('ROLE_COMPANY_COLLECT').save(flush: true)

        def collaboratorMock = mockFor(Collaborator)
        Address address = new Address(id: 1, city: "Lorena", state: "SP", zipCode: "12602-010", latitude: 0f, longitude: 0f,
                neighborhood: "Cabelinha", street: "Rua Dr. Paulo Cardoso", number: "123")

        Collaborator collaborator = new Collaborator(id: 1, name: "João", dateOfBirth: new Date(), isAddressEqual: true,
                phone: "(11) 1111-1111", photo: "foto.png", address: address)

        collaboratorMock.demand.static.findById() {Long id -> collaborator }
        when:
        params.id = "1"

        controller.loadCollaboratorDetails()
        then:
        response.json.collaborator.name == "João"
        response.json.address.city == "Lorena"
    }

    /*void "Company Collections empty"() {
        when:
        controller.myCollections()
        then:
        view == "/company/myCollections"
        model.companyCollections == []
    }*/

    /*void "Company Collections with data"() {
        given:
        def companyColRole = Role.findByAuthority('ROLE_COMPANY_COLLECT') ?: new Role('ROLE_COMPANY_COLLECT').save(flush: true)

        Company company = new Company(id: 1, companyName: "Empresa Coletora", identificationNumber: "11.111.111/1111-11",
                tradingName: "Coletora", segment: "reciclagem de lixo", typeOfCompany: "coleta",
                phone: "(11) 1111-1111", site: "http://www.dsdsds.com.br",
                address: new Address(city: "Lorena", state: "SP", zipCode: "12602-010", latitude: 0f, longitude: 0f,
                        neighborhood: "Cabelinha", street: "Rua Dr. Paulo Cardoso", number: "123"
                ))

        User user = new User('empresa@trashpoints.com.br', '123456')

        Collaborator collaborator = new Collaborator(id: 1, name: "João", dateOfBirth: new Date(), isAddressEqual: true,
                phone: "(11) 1111-1111", photo: "",
                address: new Address(city: "Lorena", state: "SP", zipCode: "12602-010", latitude: 0f, longitude: 0f,
                        neighborhood: "Cabelinha", street: "Rua Dr. Paulo Cardoso", number: "123"
                ))

        Collect collect = new Collect(id: 1, orderDate: new Date(), collectedDate: new Date(), imageUpload: "teste.png",
                isCollected: true, collaborator: collaborator, company: company)

        when:
        controller.myCollections()
        then:
        view == "/company/myCollections"
        model.companyCollections.isCollected == true
    }*/
}
