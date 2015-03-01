###*
 *This is the controller for a jsonDragger element
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
controllerName = 'sampleApplicationJsonDraggerElementController'
angular.module(moduleName).controller(controllerName, ['$scope', "$filter", "sampleApplicationConfigurationService",
($scope, $filter, configService)->

  ###
   *@function
   *@description This function gets triggered when a jsonDragger element gets double clicked
   *@param {object} $event The jQuery event that gets fired
   *@param {integer} id The id of the element
   *@author Sebastian Zankel (mail@greenlight-solutions.net)
  ###
  $scope.doubleClick = ($event, id)->
    ###Stoping the event from further propagation###
    $event.preventDefault()
    $event.stopPropagation()
    if !$scope.elementData.enabled then return false
    ###Manual trigger the edit in place form###
    $scope.textBtnForm.$show()
    ###Calling the parent filterBar, would be also possible with
    $scope.$parent, but this is shorter since the function is always
    on the parent which is jsonDragger###
    $scope.doubleClickCallback()($event, id)
    null

  ###*
    *@function
    *@description This checks the validness of the edit in place input
    *@param {string} $data The entered data
    *@returns true --> valid || "false" --> invalid (editbox stays open)
  ###
  $scope.checkJsonValidness = ($data)->
    ret = true
    try
      jsonData = JSON.parse($data)
      if $scope.elementData.type is "A"
        return ret
      else
        for key, val of jsonData
          if key isnt "type" and !/^\d+$/.test(val)
            ret = $filter('translate')('_errorMessages.someValueIsNoNumber_')
        return ret
    catch e
      return $filter('translate')('_errorMessages.noValidJson_')

  ###Watchers###
  $scope.$watch 'elementData', (newValue, oldValue)->
    if newValue isnt oldValue or $scope.elementDataJson is undefined
      obj = angular.copy(newValue)
      delete obj.id
      delete obj.parentId
      delete obj.$hashKey
      delete obj.type
      delete obj.enabled
      $scope.elementDataJson = JSON.stringify(obj)

  $scope.$watch 'elementDataJson', (newValue, oldValue)->
    if newValue isnt oldValue
      for key, val of JSON.parse(newValue)
        $scope.elementData[key] = val

  ###Events###
  $scope.$on(configService.events.renderFieldChanged.replace('$1', $scope.moduleName), (e, m)->
    $scope.renderField = m.renderField
  )

  null
])
