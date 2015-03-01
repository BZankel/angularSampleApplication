###*
 *This controller is for the jsonDragger module
 *In this file the module for the jsonDragger module gets defined
 *Here we define the dependencies that are needed for this module
 *All the functions that are responsible for the communication
 *outwords get injected via scope data attributes
 *The jsonDragger is so highly reuse and costumizeable
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


moduleName = 'sampleApplication.jsonDragger'
controllerName = 'sampleApplicationJsonDraggerController'
elementType = 'wigdet'
angular.module(moduleName, [
  'sampleApplication.services' #The application services
  'xeditable' #Edit in place plugin
]).controller(controllerName, ['$scope', "sampleApplicationConfigurationService", "$timeout", "$window"
($scope, configService, $timeout, $window)->

  ###Initalize controller variables###

  ###*
    *@function
    *@private
    *@description This reloads the filterBar in case visibility changed or initially load
    *the filter bar
    *@author Sebastian Zankel (mail@greenlight-solutions.net
  ###
  _reloadJsonDragger = =>
    ###Add additional information here###

  ###*
    *@function
    *@description This functions checks how many steps to go upwards then executes the function on the
    *other controller for a checkbox click
    *@author Sebastian Zankel (mail@greenlight-solutions.net)
  ###
  #@checkboxClick = (category, checkboxName)->
  #  a = $scope.checkboxClick(category, checkboxName)
  #  while a.toString().indexOf('locals') > -1
  #    a = $scope.checkboxClick(category, checkboxName)
  #  ###Execute reference to the function###
  #  a(category, checkboxName)


  ###Watchers###
  ###Extending the categoriesData with additional attributes###
  $scope.$watchCollection("dataModel", (newVal, oldVal)=>
    if oldVal isnt newVal
      _reloadJsonDragger()
  )

  ###This gets fired for example from the editPanel###
  $scope.$on(configService.events.jsonDraggerStateChange.replace('$1', $scope.jsonDraggerId), (event, message)=>
    _reloadJsonDragger()
    null
  )

  null
])
