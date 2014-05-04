var registrationPanel = angular.module('registrationPanel', [])

.controller('registrationController', ['$scope', '$http',
    function($scope, $http) {
        $scope.filter = {};

        $scope.findWithParams = function() {
            $http.get('/users/filters', {
                params: $scope.filter
            }).success(function(response) {
                $scope.userList = response;
                $('.content').popup();
                $scope.filter = {};
            });
        };

        $scope.addBarcode = function() {

        };

        $scope.sendBarcode = function() {

        };
    }
]);