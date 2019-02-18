(function (angular) {
    var module = angular.module('app.collaboratorService');

    module.service('serviceUser', serviceUser);

    serviceUser.$inject = ['serviceApi'];

    function serviceUser(serviceApi) {
        "use strict";

        return {
            getById: id => serviceApi.getApi('/users/organization/' + id),

            get: () => serviceApi.getApi('/user/roles/all'),

            put: (id, obj) => serviceApi.putApi('/user/' + id, obj),

            post: obj => serviceApi.postApi('/user/', obj),

            delete: id => serviceApi.deleteApi('/user/' + id)
        }
    }
})(window.angular);