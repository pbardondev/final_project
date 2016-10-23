define('controllers/dogFormController', ['controllers/controllers', 'services/dogService'], function(controllers) {
    controllers.controller('DogFormCtrl', ['$scope', 'DogService', '$log', function($scope, dogService, $log){


        $scope.formData = {
            name: '',
            age: '',
            description: '',
            size: '',
            picture: {}
        };

        $scope.submit = function () {
            $log.info($scope.model);
            dogService.createDog($scope.formData).then(function(result) {
                $log.info(result)
            }, function(err) {
                $log.error(err);
            });
        }
    }]);
});