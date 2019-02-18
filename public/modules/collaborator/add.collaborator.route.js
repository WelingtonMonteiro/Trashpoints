(function (angular) {

    var module = angular.module('app.collaborator');

    module.run(AppRun);

    AppRun.$inject = ['$stateProvider'];

    function AppRun($stateProvider) {
        $stateProvider.state('collaborator', {
            url: '/settings/user',
            views: {
                'list': {
                    templateUrl: "modules/user-control/user-control.tmp.html"
                },

                'add@collaborator':{
                    templateUrl: "modules/topbar/topbar.tmp.html",
                    controller: 'TopbarController',
                    controllerAs: 'vm'
                },

                'edit@collaborator':{
                    templateUrl: "modules/user-control/user-control.list.html",
                    controller: 'UserController',
                    controllerAs: 'vm'
                }
            }
        });
    }

})(window.angular);