package core

import grails.test.mixin.Mock
import grails.test.mixin.TestFor
import org.codehaus.groovy.grails.web.servlet.mvc.SynchronizerTokensHolder
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.web.ControllerUnitTestMixin} for usage instructions
 */
@TestFor(CompanyController)
@Mock([Company, Address, Collect])

class CompanyControllerSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "Save new Company"() {
        when:
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
        when:
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
        when:
        params.id = "1"

        controller.loadCollaboratorDetails()
        then:
        response.json.collaborator != null
        response.json.address != null

    }
}
