package core

import grails.plugin.springsecurity.SpringSecurityService
import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(CollaboratorController)
@Mock([Company, Address, Collect, Collaborator, Role, User, UserRole, MaterialType])
class CollaboratorControllerSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "Render Action Create"() {
        when:
        controller.create()
        then:
        view == "/collaborator/create"
    }

    void "Load Company Details"() {
        given:
        def userRole = Role.findByAuthority('ROLE_COLLABORATOR') ?: new Role('ROLE_COLLABORATOR').save(flush: true)

        def companyMock = mockFor(Company)

        Company company = new Company(id: 1, companyName: "Empresa Coletora", identificationNumber: "11.111.111/1111-11",
                tradingName: "Coletora", segment: "reciclagem de lixo", typeOfCompany: "coleta", phone: "(11) 1111-1111", site: "http://www.dsdsds.com.br",
                address: new Address(city: "Lorena", state: "SP", zipCode: "12602-010", latitude: 0f, longitude: 0f,
                        neighborhood: "Cabelinha", street: "Rua Dr. Paulo Cardoso", number: "123"))

        companyMock.demand.static.findById() {Long id -> company }
        when:
        params.id = "1"

        controller.loadCompanyDetails()
        then:
        response.json.company.companyName == "Empresa Coletora"
        response.json.address.city == "Lorena"
    }

    void "Load Company Details with error"() {
        given:
        def userRole = Role.findByAuthority('ROLE_COLLABORATOR') ?: new Role('ROLE_COLLABORATOR').save(flush: true)

        def companyMock = mockFor(Company)

        Company company = null

        companyMock.demand.static.findById() {Long id -> company }
        when:
        params.id = "1"

        controller.loadCompanyDetails()
        then:
        response.json.company == []
        response.json.address == []
    }

    void "Go to edit page of collaborator"() {
        given:
            // Setup Collaborator get for controller action
            def collaboratorMock = mockFor(Collaborator)
            // Setup SpringSecurityService mock
            Collaborator collaborator = new Collaborator(id: 1, name: "User test")
            User loggedInUser = new User(id: 1, username: "Test Collaborator", collaborator: collaborator)
            loggedInUser.collaborator = collaborator
            def springSecurityService = mockFor(SpringSecurityService, true)
            springSecurityService.demand.getCurrentUser(3..3) { -> loggedInUser }
            controller.springSecurityService = springSecurityService.createMock()
            collaboratorMock.demand.static.get(2..2) {Long id -> new Collaborator(id: 1, name: "User test") }
        when:
            controller.editCollaborator()
        then:
            view == "/collaborator/edit"
            ((model.currentCollaborator == null) || (model.currentCollaborator.name == "User test"))

    }


}
