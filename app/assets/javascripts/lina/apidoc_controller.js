app.controller('ApidocController', [ '$scope', '$http', function($scope, $http){
  $scope.my_data = [];

  $scope.showApi = function(branch){
    $scope.currentApi = branch.values;
  }

  $scope.setData = function(url){
    $scope.dataURL = url;
    $http.get($scope.dataURL).then( function(res){
      $scope.my_data = res.data;
    });
  }

}])
