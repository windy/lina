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

  $scope.isRequired = function(params, name){
    return params.required.indexOf(name) != -1;
  }

  $scope.moreInfo = function(properties) {
    properties = _.clone(properties);
    ['type', 'description'].forEach(function(e){
      delete properties[e];
    })
    var info = '';
    _.keys(properties).forEach( function(k) {
      info = info + k + ": " + properties[k] + "\n";
    })
    return info;
  }
}])
