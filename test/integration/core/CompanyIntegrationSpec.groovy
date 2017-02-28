package core

import grails.plugin.springsecurity.SpringSecurityUtils
import spock.lang.Specification

/**
 *
 */
class CompanyIntegrationSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    void "Company Collections with data"() {
        when:
        CompanyController controller = new CompanyController()

        Collect collect1 = new Collect()
        collect1.orderDate = new Date()
        collect1.collectedDate = new Date()
        collect1.imageUpload = "teste.png"
        collect1.isCollected = false
        collect1.collaborator = Collaborator.findByName("welington monteiro")
        collect1.company = Company.findByIdentificationNumber("11.111.111/1111-11")

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
        collect2.company = Company.findByIdentificationNumber("11.111.111/1111-11")

        collect2.validate()
        if (!collect2.hasErrors())
            collect2 = collect2.save(flush: true)
        else {
            print collect2.errors.allErrors
            throw new Exception("error collect 2")
        }

        SpringSecurityUtils.doWithAuth("ccoleta@trashpoints.com.br") {
            controller.myCollections()
        }

        then:
        def view = controller.modelAndView.viewName
        view == "/test/myCollections"
        def model = controller.modelAndView.model.companyCollections
        model.size() == 2
    }
}
