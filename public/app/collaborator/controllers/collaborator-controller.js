(function () {
  'use strict'

  angular
    .module('collaborator')
    .controller('CollaboratorCtrl', CollaboratorCtrl);

  CollaboratorCtrl.$inject = ['$scope', '$rootScope'];

  /* @ngInject */
  function CollaboratorCtrl ($scope, $rootScope) {
    let vm = this;
    vm.OneFunctionSample = OneFunctionSample;

    function OneFunctionSample () {
      console.log('log ...')
    }
  }
})();
