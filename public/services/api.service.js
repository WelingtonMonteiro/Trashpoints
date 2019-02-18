(function (angular) {
    var module = angular.module('app.services');

    module.service('serviceApi', serviceApi);

    /** api de teste * */


    serviceApi.$inject = ['$http', '__env'];

    function serviceApi($http, __env) {
        var URL_SERVER_API = __env.apiUrl;

        var serviceApiVm = this;

        serviceApiVm.req = {
            _config: {
                url: URL_SERVER_API,
                get headers() {

                    return {
                        "Content-Type": "application/json",
                        "Authorization": "Bearer " + localStorage['_token']
                    };
                }
            }
        };

        serviceApiVm.req2 = {
            _config: {
                url: URL_SERVER_API,
                get headers() {
                    return {
                        "Content-Type": "application/json",
                        "Access-Control-Allow-Origin": "*"
                    };
                }
            }
        };


        serviceApiVm.isEmpty = isEmpty;
        serviceApiVm.transformDate = transformDate;
        serviceApiVm.getApiOUT = getApiOUT;
        serviceApiVm.getApi = getApi;
        serviceApiVm.getCep = getCep;
        serviceApiVm.getApiQuery = getApiQuery;
        serviceApiVm.postApi = postApi;
        serviceApiVm.postLogin = postLogin;
        serviceApiVm.putApi = putApi;
        serviceApiVm.deleteApi = deleteApi;
        serviceApiVm.getHostName = getHostName;
        serviceApiVm.onUpload = onUpload;
        serviceApiVm.csvToJSON = csvToJSON;
        serviceApiVm.putS3Api = putS3Api;
        serviceApiVm.object2Array = object2Array;
        serviceApiVm.putApiUploads = putApiUploads;
        serviceApiVm.postApiUploads = postApiUploads;
        serviceApiVm.getUrlApi = getUrlApi;
        serviceApiVm.getHeaders = getHeaders;
        serviceApiVm.safeApply = safeApply;

        function isEmpty(object) {
            "use strict";
            for (var field in object) {
                return false
            }
            return true;
        }

        function transformDate(inputDate, time) {
            var currentDate = inputDate,
                stringAway, newDate;


            stringAway = currentDate.split('/');
            newDate = stringAway[1] + '-' + stringAway[0] + '-' + stringAway[2];

            if (time) {
                newDate = newDate + ' ' + time + ':00';
            }

            return newDate
        }

        function onUpload(element, callback) {
            var f = element.files[0];

            if (f) {
                var r = new FileReader();
                r.onload = function (e) {
                    var contents = e.target.result;
                    callback(contents);
                }
                r.readAsText(f);
            } else {
                console.log("Failed to load file");
            }
        }

        function csvToJSON(fileContent) {
            var lines = fileContent.split('\n'),
                header = lines.splice(0, 1),
                objList = [];

            header = header[0].split(';');

            lines.forEach(function (line, lineIndex) {
                line = line.split(';');
                objList[lineIndex] = {};
                header.forEach(function (title, column) {
                    objList[lineIndex][title.trim()] = line[column].trim();
                })
            });

            return objList;
        }

        function object2Array(object) {
            "use strict";
            var array = [];
            if (typeof object === 'object' && !isEmpty(object)) {
                return array = Object.keys(object).map(function (key) {
                    return object[key];
                });
            } else {
                return array;
            }
        }

        function getHostName() {
            return URL_SERVER_API.replace("api/", "");
        }

        function getUrlApi() {
            return serviceApiVm.req._config.url;
        }

        function getHeaders() {
            return serviceApiVm.req._config.headers;
        }

        function getApiOUT(url) {
            return $http({
                url: url,
                method: 'GET',
                headers: serviceApiVm.req2._config.headers,
                responseType: 'json'
            });
        }

        function getApi(url) {
            return $http({
                url: serviceApiVm.req._config.url + url,
                method: 'GET',
                headers: serviceApiVm.req._config.headers,
                responseType: 'json'
            });
        }

        function getCep(cep) {
            return $http({
                url: 'https://viacep.com.br/ws/' + cep + '/json/',
                method: 'GET',
                headers: {
                    'Pragma': undefined,
                    'Cache-Control': undefined,
                    'X-Requested-With': undefined,
                    'If-Modified-Since': undefined
                },
                responseType: 'json'
            });
        }

        function getApiQuery(url, queryString) {
            return $http({
                url: serviceApiVm.req._config.url + url,
                method: 'GET',
                headers: serviceApiVm.req._config.headers,
                responseType: 'json',
                params: queryString
            });
        }

        function postApi(url, obj, timeout) {
            var params = {
                url: serviceApiVm.req._config.url + url,
                method: 'POST',
                data: JSON.stringify(obj),
                headers: serviceApiVm.req._config.headers,
                responseType: 'json'
            };
            if (timeout) {
                params.timeout = timeout;
            }
            return $http(params);
        }

        function putApiUploads(url, obj, timeout) {
            var params = {
                url: serviceApiVm.req._config.url + url,
                method: 'PUT',
                data: obj,
                transformRequest: angular.identity,
                headers: {
                    'Content-Type': undefined,
                    "Authorization": "Bearer " + localStorage['_token_econform']
                },
                //responseType: 'json',
            };
            if (timeout) {
                params.timeout = timeout;
            }
            return $http(params);
        }

        function postApiUploads(url, obj, timeout) {
            var params = {
                url: serviceApiVm.req._config.url + url,
                method: 'POST',
                data: obj,
                transformRequest: angular.identity,
                headers: {
                    'Content-Type': undefined,
                    "Authorization": "Bearer " + localStorage['_token_econform']
                },
                //responseType: 'json',
            };
            if (timeout) {
                params.timeout = timeout;
            }
            return $http(params);
        }

        function postLogin(url, obj, cb, err) {
            return $http({
                method: 'POST',
                url: '' + serviceApiVm.req._config.url + url,
                headers: {'Content-Type': 'application/x-www-form-urlencoded'},
                transformRequest: function transformRequest(obj) {
                    var str = [];
                    for (var p in obj) {
                        str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                    }
                    return str.join("&");
                },
                data: obj
            });
        }

        function putS3Api(url, obj) {
            return $http({
                url: url,
                method: 'PUT',
                data: JSON.stringify(obj),
                headers: {"x-amz-acl": "public-read"}
            });
        }

        function putApi(url, obj) {
            return $http({
                url: serviceApiVm.req._config.url + url,
                method: 'PUT',
                data: JSON.stringify(obj),
                headers: serviceApiVm.req._config.headers,
                responseType: 'json'
            });
        }

        function deleteApi(url) {
            return $http({
                url: serviceApiVm.req._config.url + url,
                method: 'DELETE',
                headers: serviceApiVm.req._config.headers,
                responseType: 'json'
            });
        }

        function safeApply(scope, fn) {
            if (!fn) {
                fn = function () {
                }
            }
            if (scope.$root && scope.$root.$$phase) {
                var phase = scope.$root.$$phase;
                if (phase == '$apply' || phase == '$digest') {
                    if (fn && (typeof (fn) === 'function')) {
                        fn();
                    }
                } else {
                    scope.$apply(fn);
                }
            } else {
                scope.$apply(fn);
            }
        }


        return serviceApiVm;
    }
})();