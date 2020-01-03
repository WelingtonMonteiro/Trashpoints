(function () {
  'use strict'

  angular.module('home')
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

    route('/', {
      templateUrl: '/views/commons/home.html',
      controller: 'AuthCtrl',
      controllerAs: 'vm'
    })
    route('/not_found', {
      templateUrl: '/views/commons/404.html',
      controller: 'AuthCtrl',
      controllerAs: 'vm'
    })
    route('/not_authorized', {
      templateUrl: '/views/commons/403.html',
      controller: 'AuthCtrl',
      controllerAs: 'vm'
    })
  }
})()
