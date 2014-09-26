angular.module('SuperForms', [])
  .directive 'superForm', ->
    restrict: 'E'
    transclude: true
    require: '^form'
    replace: true
    template: """
      <form novalidate role="form" ng-submit="submit()" ng-transclude />
    """
    scope: {
      name: '=',
      parentSubmit: '&submit'
      parentInvalid: '&invalid'
    }
    controller: ($scope) ->
      $scope.submit = ->
        if $scope.form.$valid
          $scope.parentSubmit() if $scope.parentSubmit
        else
          angular.forEach $scope.form, (control) ->
            control.$setViewValue('') if control.$pristine

          $scope.parentInvalid() if $scope.parentInvalid

    compile: (element, attrs) ->
      element.attr(name: attrs.name)

      return (scope, tElement, tAttrs, form) ->
        scope.form = form
        scope.$parent[attrs.name] = form

  .directive 'field', ->
    restrict: 'E'
    template: """
<div ng-class="{checkbox: type == 'checkbox', 'has-success': isValid(), 'has-error': !isValid() && isDirty()}" class="form-group has-feedback">
  <label for="{{name}}" class="control-label">
    <input type="checkbox" ng-model="model" ng-show="type == 'checkbox'"/>

    {{label}}
  </label>
  <input type="{{type || 'text'}}" ng-model="model" ng-show="isInput()" ng-required="required" ng-minlength="minLength" ng-maxlength="maxLength" class="form-control"/>
  <textarea ng-model="model" ng-show="type == 'textarea'" ng-required="required" class="form-control"></textarea>
  <select ng-model="model" ng-show="type == 'select'" ng-required="required" class="form-control">
    <ng-transclude/>
  </select>
</div>
    """
    transclude: true
    replace: true
    require: '^form'
    scope:
      label: '@'
      name: '@'
      type: '@'
      model: '='
      options: '@'
      required: '@'
      autofocus: '@'
      minLength: '@'
      maxLength: '@'

    controller: ($scope) ->
      $scope.findControl = ->
        $scope.form[$scope.name]

      $scope.isValid = ->
        $scope.findControl().$valid

      $scope.isInvalid = ->
        $scope.findControl().$invalid

      $scope.isPristine = ->
        $scope.findControl().$pristine

      $scope.isDirty = ->
        $scope.findControl().$dirty

      $scope.isInput = ->
        type = $scope.type
        type != 'select' && type != 'textarea' && type != 'checkbox'

    compile: (element, attrs) ->
      modelNameParts = attrs.model.split('.')
      attrs.name = modelNameParts[modelNameParts.length-1] unless attrs.name
      attrs.label = attrs.name[0].toUpperCase() + attrs.name.substr(1) unless attrs.label

      if attrs.options
        $select = element.find('select')
        $select.attr('ng-options', attrs.options)
        listName = attrs.options.split(' in ')[1]

      switch attrs.type
        when 'select'
          element.find('input, textarea').remove()
        when 'textarea'
          element.find('input, select').remove()
        else
          element.find('textarea, select').remove()

      $input = element.find('input, select, textarea')
      $input.attr(name: attrs.name)

      return (scope, element, attr, form) ->
        scope.form = form
        $input = element.find('input, textarea, select')

        scope[listName] = scope.$parent[listName] if listName
        $input.attr('autofocus', true) if scope.autofocus

  .directive 'submit', ->
    restrict: 'E'
    template: """
    <button type="submit" ng-class="{invalid: !form.$valid}" class="btn btn-primary btn-lg btn-block">{{label}}
&nbsp;<span class="glyphicon glyphicon-chevron-right"></span></button>
    """
    replace: true
    require: '^form'
    scope: {label: '@'}
    compile: (element, attrs) ->
      attrs.label = 'Submit' unless attrs.label

      return (scope, element, attr, form) ->
        scope.form = form
