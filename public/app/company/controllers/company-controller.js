(function () {
   'use strict';

   angular.module('trashpoints')
      .controller('CompanyCtrl', CompanyCtrl);

   CompanyCtrl.$inject = ['$scope', '$rootScope'];

   function CompanyCtrl($scope, $rootScope) {
      $rootScope.user = {
         id: '123456',
         role: 'COMPANHIA'
      };

      let vm = $scope;
      
      vm.collects = [{
         id: '123',
         photo: 'assets/images/logos/trashPoints-logotipo-miniatura-alpha.png',
         types: 'Vidro, Papel',
         orderDate: new Date(2017, 4, 29),
         scheduleDate: new Date(2017, 5, 17),
         collectedDate: new Date(2017, 5, 18)
      }, {
         id: '321',
         photo: 'assets/images/logos/trashPoints-logotipo-miniatura-alpha.png',
         types: 'Papel',
         orderDate: new Date(2017, 4, 29),
         scheduleDate: new Date(2017, 5, 17),
         collectedDate: new Date(2017, 5, 18)
      }];



   }

})();