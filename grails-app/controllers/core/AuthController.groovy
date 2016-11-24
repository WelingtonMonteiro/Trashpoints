package core

class AuthController {

    /**
     IS_AUTHENTICATED_ANONYMOUSLY – acesso liberado, sem necessidade de o usuário fazer login
     IS_AUTHENTICATED_REMEMBERED – apenas usuários conhecidos que têm logado ou se tenham uma sessão válida terá permitido o acesso
     IS_AUTHENTICATED_FULLY – os usuários devem fazer login para ter acesso, que usuário tenha uma sessão válida
     */

    def index() {
        render(view: '/login')
    }

    def login(){
        render (view: "login")
    }

//    def logout(){
//        render (view: "login")
//    }
}
