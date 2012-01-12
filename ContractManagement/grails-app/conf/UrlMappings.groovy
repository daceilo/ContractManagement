class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/" {
			controller = "vendor"
			action = "list"
		}
		//(view:"/index")		
		"500"(view:'/error')
	}
}
