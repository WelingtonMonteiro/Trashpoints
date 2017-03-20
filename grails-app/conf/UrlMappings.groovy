class UrlMappings {

	static mappings = {
        //Company
        "/empresa/cadastrar" {
            controller = "company"
            action = "create"
        }

        "/empresa/minhas-coletas-recolhidas" {
            controller = "company"
            action = "myCollectedCollections"
        }

        "/empresa/minhas-coletas-andamento" {
            controller = "company"
            action = "myCollectionsInProgress"
        }

        "/empresa/editar" {
            controller = "company"
            action = "editCompany"
        }

        //Collaborator
        "/colaborador/cadastrar" {
            controller = "collaborator"
            action = "create"
        }

        "/colaborador/minhas-coletas-recolhidas" {
            controller = "collaborator"
            action = "myCollectedCollections"
        }

        "/colaborador/minhas-coletas-andamento" {
            controller = "collaborator"
            action = "myCollectionsInProgress"
        }

        "/colaborador/editar" {
            controller = "collaborator"
            action = "editCollaborator"
        }

        "/colaborador/ranking" {
            controller = "collaborator"
            action = "ranking"
        }

        //Collect
        "/coleta/cadastrar" {
            controller = "collect"
            action = "create"
        }

        "/coleta/locais-para-coletar" {
            controller = "collect"
            action = "placesCollect"
        }

        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        //ContactUs
        "/fale-conosco" {
            controller = "contactUs"
            action = "index"
        }

        //Report
        "/relatorio/coletas-empresa" {
            controller = "report"
            action = "companyCollections"
        }

        //UserManager
        "/usuario/login" {
            controller = "userManager"
            action = "login"
        }

        "/usuario/esqueceu-senha" {
            controller = "userManager"
            action = "forgotPasswordView"
        }

        "/usuario/redefinir-senha" {
            controller = "userManager"
            action = "resetPasswordView"
        }

        "/usuario/cadastrar-usuario" {
            controller = "userManager"
            action = "createUser"
        }

        "/"(view:"/index")
        "500"(view:'/error')

//        "/$controller/$action?" (controller: "userManager", action: "login")
//        "/userManager/$action?"(controller: "userManager", action: "logout")

	}

}
