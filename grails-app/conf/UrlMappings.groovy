class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/index")
        "500"(view:'/error')

        "/login?" (controller: "auth", action: 'login' )
//        "/logout/$action?"(controller: "logout")
	}
}
