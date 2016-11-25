class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(view:"/index")
        "500"(view:'/error')


        "/userManager/$action?" (controller: "userManager")
//        "/userManager/$action?"(controller: "userManager", action: "logout")



	}
}
