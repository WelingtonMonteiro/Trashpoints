package core

import grails.converters.JSON
import grails.plugin.mail.MailService
import grails.plugin.springsecurity.annotation.Secured
import org.codehaus.groovy.grails.web.servlet.mvc.SynchronizerTokensHolder

@Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
class UserManagerController {

    MailService mailService

    def index() {}

    private invalidToken() {
        def response = [:]
        String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)
        response = [error: 'Invalid_Token', newToken: newToken]
        render response as JSON
    }

    private successToken(message) {
        def response = [:]
        String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)
        response = [success: 'Salvo com sucesso', newToken: newToken]
        if (message)
            response += message
        render response as JSON
    }

    private verifyErrors(InstanceClass) {
        def isErrors = false
        if (InstanceClass.hasErrors()) {
            def listErrors = []

            InstanceClass.errors.allErrors.each { error ->
                listErrors += g.message(code: error.defaultMessage, error: error)
            }

            String newToken = SynchronizerTokensHolder.store(session).generateToken(params.SYNCHRONIZER_URI)
            def message = [error: listErrors, newToken: newToken]
            render message as JSON

            isErrors = true
        }
        isErrors
    }

    def login() {
        render(view: "/userManager/login", model: [error: params.login_error])
    }

    def logout() {
        redirect(action: "login")
    }

    def forgotPasswordView() {
        render(view: "/userManager/forgotPassword")
    }

    def resetPasswordView() {
        render(view: "/userManager/resetPassword", model: [token: params.key])
    }


    def forgotPassword() {
        withForm {

            User user = User.findByUsername(params.username)
            Long key = (new Date().time + Math.floor(Math.random() * 24 * 3600) )

            user.token = key.toString()

            if(!user) return invalidToken()

            def link = "http://localhost:8080/Trashpoints/userManager/resetPasswordView?key="+ key

            mailService.sendMail {
                to params.username
                from 'info.trahspoints@gmail.com'
                subject "Recuperação de Senha Sistema Trashpoints"
                text "Você está recebendo um link para recuperar a senha do Sistema Trashpoints. Por favor clique no link abaixo: <br>" + link
            }

            successToken([success: 'Link para recuperação de senha sendo enviado.'])

        }.invalidToken {
            invalidToken()
        }

    }

    def resetPassword() {
        withForm {

            User user = User.findByToken(params.id)

            user.password = params.j_password

            user.token = null

            user.validate()

            def errors = verifyErrors(user)

            if (!errors) {

                user.save(flush: true)

                mailService.sendMail {
                    to user.username
                    from 'info.trahspoints@gmail.com'
                    subject "Alteração de Senha do Sistema Trashpoints"
                    text "Você está recebendo esse email, pois sua senha do Sistema Trashpoints foi alterada."
                }

                successToken([success: 'Senha alterada com sucesso'])
            }

        }.invalidToken {
            invalidToken()
        }
    }
}
