package core

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
        /*Collaborator collaborator = new Collaborator( id: 1,
                name: "João", phone: "(11) 1111-1111", photo: "", isAddressEqual: true, dateOfBirth: new Date(),
                address: new Address(city: "Lorena", state: "SP", zipCode: "12602-010", latitude: 0f, longitude: 0f,
                        neighborhood: "Cabelinha", street: "Rua Dr. Paulo Cardoso", number: "123"
                )).save(flush: true)*/
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

    /*void "Company mark that was collected one reclycling"() {
        given:
        Company company = new Company(identificationNumber: "99.999.999/9999-99", companyName: "Empresa Teste",
                tradingName: "Empresa Teste", segment: "Segmento Teste", typeOfCompany: "coleta", phone: "(99) 9999-9999")

        Collaborator collaborator = new Collaborator(name: "joão", dateOfBirth: "10/09/2000", phone: "(99) 9999-9999")

        Collect collect = new Collect(id: 1, orderDate: new Date(), collectedDate: new Date(),
                imageUpload: "teste.png", isCollected: true, collaborator: collaborator)
        when:
        def tokenHolder = SynchronizerTokensHolder.store(session)

        params[SynchronizerTokensHolder.TOKEN_URI] = '/company/markWasCollected'
        params[SynchronizerTokensHolder.TOKEN_KEY] = tokenHolder.generateToken(params[SynchronizerTokensHolder.TOKEN_URI])
        params.collectId = "1"

        controller.markWasCollected()
        then:
        response.json.success != null
    }*/

    void "Load Collaborator Details"() {
        given:
        /*params.name = "João"
        params.photo = "teste.png"
        params.dateOfBith = "10/09/2000"
        params.isAddressEqual = "true"
        params.zipCode = "12509-330"
        params.street = "Rua Teste"
        params.number = "100"
        params.neighborhood = "Bairro Teste"
        params.city = "Cidade Teste"
        params.state = "SP"*/

        Company company = new Company(id: 1, companyName: "Empresa Coletora", identificationNumber: "11.111.111/1111-11",
                tradingName: "Coletora", segment: "reciclagem de lixo", typeOfCompany: "coleta",
                phone: "(11) 1111-1111", site: "http://www.dsdsds.com.br",
                address: new Address(city: "Lorena", state: "SP", zipCode: "12602-010", latitude: 0f, longitude: 0f,
                        neighborhood: "Cabelinha", street: "Rua Dr. Paulo Cardoso", number: "123"
                )).save(flush: true)

        when:
        params.id = "1"

        controller.loadCollaboratorDetails()
        then:
        response.json.collaborator != null
        response.json.address != null
    }

    void "Load Collaborator Details with error"() {
        given:

        Company company = new Company(id: 1, companyName: "Empresa Coletora", identificationNumber: "11.111.111/1111-11",
                tradingName: "Coletora", segment: "reciclagem de lixo", typeOfCompany: "coleta",
                phone: "(11) 1111-1111", site: "http://www.dsdsds.com.br",
                address: new Address(city: "Lorena", state: "SP", zipCode: "12602-010", latitude: 0f, longitude: 0f,
                        neighborhood: "Cabelinha", street: "Rua Dr. Paulo Cardoso", number: "123"
                )).save(flush: true)

        when:
        params.id = "2"

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

    /*void "Company Collections with datas"() {
        when:
        controller.myCollections()
        then:
        view == "/company/myCollections"
        model.companyCollections != null
    }*/
}
