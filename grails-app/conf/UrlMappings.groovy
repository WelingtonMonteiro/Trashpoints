class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/index")
        "500"(view:'/error')


//        "/$controller/$action?" (controller: "userManager", action: "login")
//        "/userManager/$action?"(controller: "userManager", action: "logout")



	}
}
