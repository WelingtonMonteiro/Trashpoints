(function () {
    'use strict';

    angular.module('company')
      .controller('CompanyCtrl', HomeEmpresaCtrl);

    HomeEmpresaCtrl.$inject = ['$scope', '$rootScope'];

    function HomeEmpresaCtrl($scope, $rootScope) {
        $rootScope.user = { id: '123456', role: 'COMPANHIA'};
        //var vm = this;
        console.log('HomeEmpresaCtrl');
        //$scope.termoPesquisa = "Teste";
        //vm.relatorios = [];
    }
})();
