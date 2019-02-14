(function () {
    angular
        .module('app')
        .config(AppRoute)
        .run(AppRun);

    AppRoute.$inject = ['$urlRouterProvider', '$httpProvider', '$qProvider', '$stateProvider'];

    function AppRoute($urlRouterProvider, $httpProvider, $qProvider, $stateProvider) {
        $qProvider.errorOnUnhandledRejections(false);


        $urlRouterProvider.otherwise("/login");
        //initialize get if not there
        if (!$httpProvider.defaults.headers.get) {
            $httpProvider.defaults.headers.get = {};
        }

        // Answer edited to include suggestions from comments
        // because previous version of code introduced browser-related errors

        //disable IE ajax request caching
        $httpProvider.defaults.headers.get['If-Modified-Since'] = 'Mon, 26 Jul 1997 05:00:00 GMT';
        // extra
        $httpProvider.defaults.headers.get['Cache-Control'] = 'no-cache';
        $httpProvider.defaults.headers.get['Pragma'] = 'no-cache';
    }


    AppRun.$inject = ['$rootScope', '$location', '$state', 'jwtHelper'];

    function AppRun($rootScope, $location, $state, jwtHelper) {

        // Redirect to login if route requires auth and you're not logged in
        $rootScope.$on('$locationChangeStart', function (event, toState, toParams) {
            var currentPage = $location.path();
            var permitAccess = ['/login', '/register/form', '/register/multiple/cnpj', '/register/single/cnpj', '/adm/login', '/waiting', '/forgot-password'];
            var restrictedPage = $.inArray(currentPage, permitAccess) === -1;
            // var tokenExpiration = localStorage['_tokenExpiration'];
            var userAuthenticated;

            if(currentPage.indexOf('/adm/') !== -1){
                userAuthenticated = localStorage['_token_econform_admin'];
            }else{
                userAuthenticated = localStorage['_token_econform'];
            }

            var expire = false;

            var currentTime = (new Date()).getTime();

            // if (tokenExpiration && (currentTime > tokenExpiration)) {
            //     expire = true;
            // }
            if (restrictedPage && !userAuthenticated || expire) {

                $rootScope.returnToState = toState.url;
                $rootScope.returnToStateParams = toParams.Id;
                // localStorage.clear();
                // sessionStorage.clear();
                // $location.path('/client');
                if (currentPage.indexOf('/adm/') !== -1) {
                    return $state.go('login-adm');
                } else {
                    return $state.go('login');
                }

            }


            // if (restrictedPage && userAuthenticated) {
            //     var userLogged = jwtHelper.decodeToken(userAuthenticated);
            //     var pageAdmin = currentPage.indexOf('/adm/') !== -1;
            //     var pageAdminLogin = currentPage === '/adm/login';
            //     var isUserAdmin = userLogged.roles[0] === 'admin';
            //
            //     if ((pageAdmin && !pageAdminLogin) && !isUserAdmin) {
            //         $rootScope.returnToState = toState.url;
            //         $rootScope.returnToStateParams = toParams.Id;
            //         localStorage.clear();
            //         sessionStorage.clear();
            //         // $location.path('/adm/login');
            //         return $state.go('login-adm');
            //     }
            //
            //     if (!userLogged.enabledAccess && !pageAdmin) {
            //
            //         $rootScope.returnToState = toState.url;
            //         $rootScope.returnToStateParams = toParams.Id;
            //         localStorage.clear();
            //         sessionStorage.clear();
            //         // $location.path('/wating');
            //         return $state.go('waiting');
            //     }
            //
            // }

        });
    }
})();