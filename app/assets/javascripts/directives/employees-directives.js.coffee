###
A generic confirmation for risky actions.
Usage: Add attributes: ng-really-message="Are you sure"? ng-really-click="takeAction()" function
###
@app.directive "ngReallyClick", [->
  restrict: "A"
  link: (scope, element, attrs) ->
    element.bind "click", ->
      message = attrs.ngReallyMessage
      scope.$apply attrs.ngReallyClick  if message and confirm(message)

]