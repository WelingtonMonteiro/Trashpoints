(function () {
    'use strict';

    angular.module('company')
      .controller('CompanyCtrl', CompanyCtrl);

    CompanyCtrl.$inject = ['$scope', '$rootScope'];

    function CompanyCtrl($scope, $rootScope) {
        $rootScope.user = { id: '123456', role: 'COMPANHIA'};
        //var vm = this;
        console.log('HomeEmpresaCtrl');
        //$scope.termoPesquisa = "Teste";
        //vm.relatorios = [];
    }
})();
