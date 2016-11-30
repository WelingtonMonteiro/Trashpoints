package core

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import org.codehaus.groovy.grails.web.servlet.mvc.SynchronizerTokensHolder
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(CollectController)
@Mock([Company, Address, Collect, Collaborator, Role, User, UserRole, MaterialType])
class CollectControllerSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "Render Action Create"() {
        given:
        def userRole = Role.findByAuthority('ROLE_COLLABORATOR') ?: new Role('ROLE_COLLABORATOR').save(flush: true)
        MaterialType.findByName('PLÁSTICO') ?: new MaterialType(name: 'PLÁSTICO').save(flush: true)
        when:
        controller.create()
        then:
        model.materialTypes != null
        view == "/collect/create"
    }

    void "Load Collect Image"() {
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

        Collect collect = new Collect(id: 1, orderDate: new Date(), collectedDate: new Date(), imageUpload: "teste.png",
                isCollected: true, collaborator: collaborator, company: company)

        when:
        params.id = "1"

        controller.loadCollectImage()
        then:
        response.json.imagePath != null
    }

}
