(function() {
  angular.module('examples').controller('BasicExampleCtrl', function($scope) {
    $scope.user = {};
    return $scope.login = function() {
      return alert("You entered " + $scope.user.email + "/" + $scope.user.password);
    };
  });

}).call(this);
