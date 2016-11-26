package core

import grails.plugin.springsecurity.annotation.Secured

@Secured(['IS_AUTHENTICATED_ANONYMOUSLY'])
class UserManagerController {

    def index() { }

    def login(){
        render (view: "/userManager/login")
    }

    def logout(){

        redirect (action: "login")
    }
}
