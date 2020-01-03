(function () {
  'use strict'

  angular.module('company')
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

    route('company/:id', {
      templateUrl: '/views/company/company.html',
      controller: 'CompanyCtrl',
      controllerAs: 'vm'
    })
    route('company/:id/details', {
      templateUrl: '/views/company/company-details.html',
      controller: 'CompanyDetailsCtrl',
      controllerAs: 'vm'
    })
  }
})()
