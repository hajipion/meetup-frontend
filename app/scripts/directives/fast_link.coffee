angular.module('meetupDirectives')
  .directive 'fastLink', ($parse, $location) ->
    restrict: 'A'
    link: ($scope, $elem, $attr) ->
      $elem.fastClick (e) =>
        console.log "foobar"
        href = $attr['href'].replace '#', ''
        $scope.$apply () -> $location.path href
