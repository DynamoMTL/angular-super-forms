angular.module('examples')
  .controller 'BasicExampleCtrl', ($scope) ->
    $scope.user = {}

    $scope.login = ->
      alert "You entered #{$scope.user.email}/#{$scope.user.password}"
