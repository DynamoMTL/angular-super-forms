angular.module('basic', ['SuperForms'])
  .controller 'ExampleCtrl', ($scope) ->
    $scope.user = {}

    $scope.login = ->
      alert "You entered #{$scope.user.email}/#{$scope.user.password}"
