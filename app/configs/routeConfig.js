(function () {
	'use strict';

	angular.module('trashpoints').run(function ($rootScope, $location) {
		$rootScope.user = null;

		// $rootScope.$on("$routeChangeStart", function (event, next, current) {
		//     if ($rootScope.user == null) {
		//         $location.path("/login");
		//     }
		// });
	});

	angular.module("trashpoints").config(function ($routeProvider) {

		$routeProvider
			.when("/", {
				templateUrl: "views/home.html",
				controller: "HomeCtrl"
			})
			.when("/home", {
				templateUrl: "views/home.html",
				controller: "HomeCtrl"
			})
			.when("/login", {
				templateUrl: "views/login.html",
				controller: "LoginCtrl"
			})
			.when("/companhia", {
				templateUrl: "views/companhia/home.html",
				controller: "HomeEmpresaCtrl"
			})
			.when("/companhia/minhas-coletas/coletadas", {
				templateUrl: "views/companhia/coletadas.html",
				controller: "HomeEmpresaCtrl"
			})
			.when("/not-found", {
				templateUrl: "views/not-found.html",
			})
			.otherwise({ redirectTo: "/not-found" });

		/* $routeProvider.when("/contatos", {
			templateUrl: "view/contatos.html",
			controller: "listaTelefonicaCtrl",
			resolve: {
				contatos: function (contatosAPI) {
					return contatosAPI.getContatos();
				},
				operadoras: function (operadorasAPI) {
					return operadorasAPI.getOperadoras();
				}
			}
		});
	
		$routeProvider.when("/detalhesContato/:id", {
			templateUrl: "view/detalhesContato.html",
			controller: "detalhesContatoCtrl",
			resolve: {
				contato: function (contatosAPI, $route) {
					return contatosAPI.getContato($route.current.params.id);
				}
			}
		});
	
		$routeProvider.when("/error", {
			templateUrl: "view/error.html"
		});
		 */
	});

})();