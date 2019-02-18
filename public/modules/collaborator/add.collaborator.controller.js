(function (angular) {

    var module = angular.module('app.collaborator');
    module.controller('collaboratorController', collaboratorController);

    collaboratorController.$inject = ['viewService'];

    function collaboratorController(viewService) {
        var collaboratorVm = this;

        viewService.onReady(onReady);

        function onReady() {

        }
    }

})(window.angular);