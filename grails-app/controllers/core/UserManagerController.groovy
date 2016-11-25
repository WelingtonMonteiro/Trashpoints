package core

import grails.plugin.springsecurity.annotation.Secured

@Secured(['permitAll'])
class UserManagerController {

    def index() { }

    def login(){
        render (view: "/userManager/login")
    }

    def logout(){

        redirect (action: "login")
    }
}
