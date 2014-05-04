var registrationPanel = angular.module('registrationPanel', [])

.controller('registrationController', ['$scope', '$http',
    function($scope, $http) {
        $scope.filter = {};
        $scope.barcode = {};

        $scope.findWithParams = function() {
            $http.get('/users/filters', {
                params: $scope.filter
            }).success(function(response) {
                $scope.userList = response;
                $('.content').popup();
                $scope.filter = {};
            });
        };

        $scope.sendBarcode = function(user_id) {
            console.log($scope.barcode);
            console.log(user_id);
            var barcodeRequest = {
                user_id: user_id,
                barcode: $scope.barcode.code
            }

            $http.get('/users/addbarcode', {
                params: barcodeRequest
            }).success(function(response) {
                if (response.success == true) {
                    $('#barcode-open-' + user_id).hide();
                    $('#' + user_id).modal('hide');

                }
                console.log(response);
            })

            $scope.barcode = {};

        };
    }
])

.directive('ngEnter', function() {
    return function(scope, element, attrs) {
        element.bind("keydown keypress", function(event) {
            if (event.which === 13) {
                scope.$apply(function() {
                    scope.$eval(attrs.ngEnter);
                });

                event.preventDefault();
            }
        });
    };
});