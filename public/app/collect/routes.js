(function () {
  'use strict'

  angular.module('collect')
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

    route('collect/:id', {
      templateUrl: '/views/collect/collect.html',
      controller: 'CollectCtrl',
      controllerAs: 'vm'
    })
    route('collect/:id/details', {
      templateUrl: '/views/collect/collect-details.html',
      controller: 'CollectDetailsCtrl',
      controllerAs: 'vm'
    })
  }
})()
