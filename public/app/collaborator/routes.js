(function () {
  'use strict'

  angular.module('collaborator')
    .config(Config)

  Config.$inject = ['$locationProvider', '$routeProvider'];

  /* @ngInject */
  function Config ($locationProvider, $routeProvider) {
    routes($locationProvider, $routeProvider)
  }

  function routes ($locationProvider, $routeProvider) {
    var route = function (url, opts) {
      $routeProvider.when(url, opts)
    }
    $routeProvider.otherwise({
      redirectTo: '/not-found'
    })

    route('collaborator/:id', {
      templateUrl: '/views/collaborator/collaborator.html',
      controller: 'CollaboratorCtrl',
      controllerAs: 'vm'
    })
    route('collaborator/:id/details', {
      templateUrl: '/views/collaborator/collaborator-details.html',
      controller: 'CollaboratorDetailsCtrl',
      controllerAs: 'vm'
    })
  }
})()
