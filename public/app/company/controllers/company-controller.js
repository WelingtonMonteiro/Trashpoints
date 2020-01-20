(function () {
    'use strict';

    angular.module('trashpoints')
      .controller('CompanyCtrl', CompanyCtrl);

    CompanyCtrl.$inject = ['$scope', '$rootScope'];

    function CompanyCtrl($scope, $rootScope) {
        $rootScope.user = { id: '123456', role: 'COMPANHIA'};
        //var vm = this;
        //vm.relatorios = [];
        console.log('HomeEmpresaCtrl');
        //$scope.termoPesquisa = "Teste";
    }
})();
