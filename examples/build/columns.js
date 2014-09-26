(function() {
  angular.module('examples').controller('ColumnExampleCtrl', function($scope) {
    $scope.address = {};
    return $scope.save = function() {
      return alert("Saved");
    };
  });

}).call(this);
