package core

import grails.plugin.springsecurity.SpringSecurityUtils
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

        Company company = new Company(id: 1, companyName: "Empresa Coletora", identificationNumber: "11.111.111/1111-11",
                tradingName: "Coletora", segment: "reciclagem de lixo", typeOfCompany: "coleta",
                phone: "(11) 1111-1111", site: "http://www.dsdsds.com.br",
                address: new Address(city: "Lorena", state: "SP", zipCode: "12602-010", latitude: 0f, longitude: 0f,
                        neighborhood: "Cabelinha", street: "Rua Dr. Paulo Cardoso", number: "123"
                )).save(flush: true)

        User user = new User('empresa@trashpoints.com.br', '123456')
        user.company = company
        user.save(flush: true)

        UserRole.create(user, companyRole)

        UserRole.withSession {
            it.flush()
            it.clear()
        }

        Collaborator collaborator = new Collaborator(id: 1, name: "João", dateOfBirth: new Date(), isAddressEqual: true,
                phone: "(11) 1111-1111", photo: "",
                address: new Address(city: "Lorena", state: "SP", zipCode: "12602-010", latitude: 0f, longitude: 0f,
                        neighborhood: "Cabelinha", street: "Rua Dr. Paulo Cardoso", number: "123"
                )).save(flush: true)

        Collect collect = new Collect(id: 1, orderDate: new Date(), collectedDate: new Date(), imageUpload: "teste.png",
                isCollected: false, collaborator: collaborator, company: company)

        SpringSecurityUtils.reauthenticate(user.username, "123456")
        when:
        def tokenHolder = SynchronizerTokensHolder.store(session)

        params[SynchronizerTokensHolder.TOKEN_URI] = '/company/markWasCollected'
        params[SynchronizerTokensHolder.TOKEN_KEY] = tokenHolder.generateToken(params[SynchronizerTokensHolder.TOKEN_URI])
        params.collectId = "1"

        controller.markWasCollected()
        then:
        response.json.success != null
    }

    void "Load Collaborator Details"() {
        given:
        def companyRole = Role.findByAuthority('ROLE_COMPANY_COLLECT') ?: new Role('ROLE_COMPANY_COLLECT').save(flush: true)
        def userRole = Role.findByAuthority('ROLE_COLLABORATOR') ?: new Role('ROLE_COLLABORATOR').save(flush: true)

        Collaborator collaborator = new Collaborator(id: 1, name: "João", dateOfBirth: new Date(), isAddressEqual: true,
                phone: "(11) 1111-1111", photo: "",
                address: new Address(city: "Lorena", state: "SP", zipCode: "12602-010", latitude: 0f, longitude: 0f,
                        neighborhood: "Cabelinha", street: "Rua Dr. Paulo Cardoso", number: "123"
                )).save(flush: true)

        User user = new User('colaborador@trashpoints.com.br', 'colaborador')
        user.collaborator = collaborator
        user.save(flush: true)

        UserRole.create(user, userRole)

        Company company = new Company(id: 1, companyName: "Empresa Coletora", identificationNumber: "11.111.111/1111-11",
                tradingName: "Coletora", segment: "reciclagem de lixo", typeOfCompany: "coleta",
                phone: "(11) 1111-1111", site: "http://www.dsdsds.com.br",
                address: new Address(city: "Lorena", state: "SP", zipCode: "12602-010", latitude: 0f, longitude: 0f,
                        neighborhood: "Cabelinha", street: "Rua Dr. Paulo Cardoso", number: "123"
                )).save(flush: true)

        User userCompany = new User('ccoleta@trashpoints.com.br', 'coleta')
        userCompany.company = company
        userCompany.save(flush: true)

        UserRole.create(userCompany, companyRole)

        UserRole.withSession {
            it.flush()
            it.clear()
        }

        when:
        params.id = "1"

        controller.loadCollaboratorDetails()
        then:
        response.json.collaborator != null
        response.json.address != null
    }

    void "Load Collaborator Details with error"() {
        given:
        def companyRole = Role.findByAuthority('ROLE_COMPANY_COLLECT') ?: new Role('ROLE_COMPANY_COLLECT').save(flush: true)
        def userRole = Role.findByAuthority('ROLE_COLLABORATOR') ?: new Role('ROLE_COLLABORATOR').save(flush: true)

        Collaborator collaborator = new Collaborator(id: 1, name: "João", dateOfBirth: new Date(), isAddressEqual: true,
                phone: "(11) 1111-1111", photo: "",
                address: new Address(city: "Lorena", state: "SP", zipCode: "12602-010", latitude: 0f, longitude: 0f,
                        neighborhood: "Cabelinha", street: "Rua Dr. Paulo Cardoso", number: "123"
                )).save(flush: true)

        when:
        params.id = "3"

        controller.loadCollaboratorDetails()
        then:
        response.json.collaborator == null
        response.json.address == null
    }

    void "Company Collections empty"() {
        when:
        controller.myCollections()
        then:
        view == "/company/myCollections"
        model.companyCollections == []
    }

    void "Company Collections with data"() {
        given:
        def companyColRole = Role.findByAuthority('ROLE_COMPANY_COLLECT') ?: new Role('ROLE_COMPANY_COLLECT').save(flush: true)

        Company company = new Company(id: 1, companyName: "Empresa Coletora", identificationNumber: "11.111.111/1111-11",
                tradingName: "Coletora", segment: "reciclagem de lixo", typeOfCompany: "coleta",
                phone: "(11) 1111-1111", site: "http://www.dsdsds.com.br",
                address: new Address(city: "Lorena", state: "SP", zipCode: "12602-010", latitude: 0f, longitude: 0f,
                        neighborhood: "Cabelinha", street: "Rua Dr. Paulo Cardoso", number: "123"
                )).save(flush: true)

        User user = new User('empresa@trashpoints.com.br', '123456')
        user.company = company
        user.save(flush: true)

        UserRole.create(user, companyColRole)

        UserRole.withSession {
            it.flush()
            it.clear()
        }

        Collaborator collaborator = new Collaborator(id: 1, name: "João", dateOfBirth: new Date(), isAddressEqual: true,
                phone: "(11) 1111-1111", photo: "",
                address: new Address(city: "Lorena", state: "SP", zipCode: "12602-010", latitude: 0f, longitude: 0f,
                        neighborhood: "Cabelinha", street: "Rua Dr. Paulo Cardoso", number: "123"
                )).save(flush: true)

        Collect collect = new Collect(id: 1, orderDate: new Date(), collectedDate: new Date(), imageUpload: "teste.png",
                isCollected: true, collaborator: collaborator, company: company)

        when:
        controller.myCollections()
        then:
        view == "/company/myCollections"
        model.companyCollections != null
    }
}
