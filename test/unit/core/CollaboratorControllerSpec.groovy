package core

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import org.codehaus.groovy.grails.web.servlet.mvc.SynchronizerTokensHolder
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
        def companyRole = Role.findByAuthority('ROLE_COMPANY_COLLECT') ?: new Role('ROLE_COMPANY_COLLECT').save(flush: true)
        def userRole = Role.findByAuthority('ROLE_COLLABORATOR') ?: new Role('ROLE_COLLABORATOR').save(flush: true)

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

        controller.loadCompanyDetails()
        then:
        response.json.company != null
        response.json.address != null
    }

}
