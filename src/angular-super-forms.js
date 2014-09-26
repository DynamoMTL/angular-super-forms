(function () {
  angular.module('SuperForms').directive('superForm', function () {
    return {
      restrict: 'E',
      transclude: true,
      require: '^form',
      replace: true,
      template: '<form novalidate role="form" ng-submit="submit()" ng-transclude />',
      scope: {
        name: '=',
        parentSubmit: '&submit',
        parentInvalid: '&invalid'
      },
      controller: [
        '$scope',
        function ($scope) {
          return $scope.submit = function () {
            if ($scope.form.$valid) {
              if ($scope.parentSubmit) {
                return $scope.parentSubmit();
              }
            } else {
              angular.forEach($scope.form, function (control) {
                if (control.$pristine) {
                  return control.$setViewValue('');
                }
              });
              if ($scope.parentInvalid) {
                return $scope.parentInvalid();
              }
            }
          };
        }
      ],
      compile: function (element, attrs) {
        element.attr({ name: attrs.name });
        return function (scope, tElement, tAttrs, form) {
          scope.form = form;
          return scope.$parent[attrs.name] = form;
        };
      }
    };
  }).directive('field', function () {
    return {
      restrict: 'E',
      template: '<div ng-class="{checkbox: type == \'checkbox\', \'has-success\': isValid(), \'has-error\': !isValid() && isDirty()}" class="form-group has-feedback">\n  <label for="{{name}}" class="control-label">\n    <input type="checkbox" ng-model="model" ng-show="type == \'checkbox\'"/>\n\n    {{label}}\n  </label>\n  <input type="{{type || \'text\'}}" ng-model="model" ng-show="isInput()" ng-required="required" ng-minlength="minLength" ng-maxlength="maxLength" class="form-control"/>\n  <textarea ng-model="model" ng-show="type == \'textarea\'" ng-required="required" class="form-control"></textarea>\n  <select ng-model="model" ng-show="type == \'select\'" ng-required="required" class="form-control">\n    <ng-transclude/>\n  </select>\n  <span ng-hide="type == \'checkbox\'" class="glyphicon glyphicon-ok form-control-feedback"></span>\n  <span ng-hide="type == \'checkbox\'" class="glyphicon glyphicon-remove form-control-feedback"></span>\n</div>',
      transclude: true,
      replace: true,
      require: '^form',
      scope: {
        label: '@',
        name: '@',
        type: '@',
        model: '=',
        options: '@',
        required: '@',
        autofocus: '@',
        minLength: '@',
        maxLength: '@'
      },
      controller: [
        '$scope',
        function ($scope) {
          $scope.findControl = function () {
            return $scope.form[$scope.name];
          };
          $scope.isValid = function () {
            return $scope.findControl().$valid;
          };
          $scope.isInvalid = function () {
            return $scope.findControl().$invalid;
          };
          $scope.isPristine = function () {
            return $scope.findControl().$pristine;
          };
          $scope.isDirty = function () {
            return $scope.findControl().$dirty;
          };
          return $scope.isInput = function () {
            var type;
            type = $scope.type;
            return type !== 'select' && type !== 'textarea' && type !== 'checkbox';
          };
        }
      ],
      compile: function (element, attrs) {
        var $input, $select, listName;
        if (!attrs.name) {
          attrs.name = _.last(attrs.model.split('.'));
        }
        if (!attrs.label) {
          attrs.label = attrs.name[0].toUpperCase() + _.rest(attrs.name).join('');
        }
        if (attrs.options) {
          $select = element.find('select');
          $select.attr('ng-options', attrs.options);
          listName = attrs.options.split(' in ')[1];
        }
        switch (attrs.type) {
        case 'select':
          element.find('input, textarea').remove();
          break;
        case 'textarea':
          element.find('input, select').remove();
          break;
        default:
          element.find('textarea, select').remove();
        }
        $input = element.find('input, select, textarea');
        $input.attr({ name: attrs.name });
        return function (scope, element, attr, form) {
          scope.form = form;
          $input = element.find('input, textarea, select');
          if (listName) {
            scope[listName] = scope.$parent[listName];
          }
          if (scope.autofocus) {
            return $input.attr('autofocus', true);
          }
        };
      }
    };
  }).directive('submit', function () {
    return {
      restrict: 'E',
      template: '<button type="submit" ng-class="{invalid: !form.$valid}" class="btn btn-primary btn-lg btn-block">{{label}}\n&nbsp;<span class="glyphicon glyphicon-chevron-right"></span></button>',
      replace: true,
      require: '^form',
      scope: { label: '@' },
      compile: function (element, attrs) {
        if (!attrs.label) {
          attrs.label = 'Submit';
        }
        return function (scope, element, attr, form) {
          return scope.form = form;
        };
      }
    };
  });
}.call(this));