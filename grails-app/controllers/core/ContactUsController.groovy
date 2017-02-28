package core

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.transaction.Transactional
import org.codehaus.groovy.grails.web.servlet.mvc.SynchronizerTokensHolder

@Secured(["ROLE_COLLABORATOR", "ROLE_COMPANY_COLLECT"])
class ContactUsController {

    transient springSecurityService

    private invalidToken(message) {
        def response = [:]
        String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)
        response = [error: 'Invalid_Token', newToken: newToken]
        if (message)
            response += message
        render response as JSON
    }

    private successToken(message) {
        def response = [:]
        String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)
        response = [success: 'sucesso', newToken: newToken]
        if (message)
            response += message
        render response as JSON
    }

    private verifyErrors(InstanceClass) {
        if (InstanceClass.hasErrors()) {
            def listErrors = []

            InstanceClass.errors.allErrors.each { error ->
                listErrors += g.message(code: error.defaultMessage, error: error)
            }

            String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)
            def message = [error: listErrors, newToken: newToken]
            render message as JSON
        }
    }

    def index() {
        render(view: "index")
    }

    @Transactional
    def save() {
        withForm {
            User currentUser = springSecurityService.loadCurrentUser()
            ContactUs contactUs = new ContactUs()
            contactUs.contactType = params.contactType.toString().toInteger()
            contactUs.contactText = params.contactText
            contactUs.userId = currentUser.id
            if (contactUs.contactType == -1 || contactUs.contactText.isEmpty()){
                def listErrors = []
                if (contactUs.contactType == -1){
                    listErrors.add("O tipo do contato não foi selecionado")
                }
                if (contactUs.contactText.isEmpty()){
                    listErrors.add("O texto do contato é obrigatório")
                }
                String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)
                def message = [error: listErrors, newToken: newToken]
                render message as JSON
            }
            def errors = verifyErrors(contactUs)
            if (!errors){
                contactUs.save(flush: true)
                successToken([success: "Contato enviado com sucesso!"])
            }
        }.invalidToken {
            invalidToken("")
        }
    }
}