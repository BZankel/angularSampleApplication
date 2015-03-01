###*
 *This is the controller for a outputChooser element
 *@author Sebastian Zankel (mail@greenlight-solutions.net)
 *
 *Copyright 2015 Greenlight-Solutions
 *NOTICE:  All information contained herein is, and remains
 *the property of Greenlight-Solutions and its suppliers,
 *if any.  The intellectual and technical concepts contained
 *herein are proprietary to Greenlight-Solutions
 *and its suppliers and may be covered by German and Foreign Patents,
 *patents in process, and are protected by trade secret or copyright law.
 *Dissemination of this information or reproduction of this material
 *is strictly forbidden unless prior written permission is obtained
 *from Greenlight-Solutions.
###

moduleName = 'sampleApplication.outputChooser'
controllerName = 'sampleApplicationOutputChooserElementController'
angular.module(moduleName).controller(controllerName, ['$scope', "$filter", ($scope, $filter)->

  ###
   *@function
   *@description This function gets triggered when a output chooser element gets clicked
   *@param {object} $event The jQuery event that gets fired
   *@param {integer} id The id of the element
   *@author Sebastian Zankel (mail@greenlight-solutions.net)
  ###
  $scope.click = ($event, name)->
    ###Stoping the event from further propagation###
    $event.preventDefault()
    $event.stopPropagation()
    ###Manual trigger the edit in place form###
    ###Calling the parent filterBar, would be also possible with
    $scope.$parent, but this is shorter since the function is always
    on the parent which is jsonDragger###
    $scope.clickCallback()($event, name)
    null

  null
])
