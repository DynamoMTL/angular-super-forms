angular.module('examples')
  .controller 'ColumnExampleCtrl', ($scope) ->
    $scope.address = {}

    $scope.save = ->
      alert "Saved"
