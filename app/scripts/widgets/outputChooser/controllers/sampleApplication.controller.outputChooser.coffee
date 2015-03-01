###*
 *This controller is for the outputChooser module
 *In this file the module for the outputChooser gets defined
 *Here we define the dependencies that are needed for this module
 *All the functions that are responsible for the communication
 *outwords get injected via scope data attributes
 *The outputChooser is so highly reuse and costumizeable
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
controllerName = 'sampleApplicationoutputChooserController'
elementType = 'wigdet'
angular.module(moduleName, [
  'sampleApplication.services'
]).controller(controllerName, ['$scope', "sampleApplicationConfigurationService", "$timeout"
($scope, configService, $timeout)->

  ###*
   *@function
   *@description Callback that iterates over the scopes until it finds the place where the
   *passed function should be excecuted
   *@param {object} $event The jQuery event object
   *@param {string} name The name of the clicked button
   *@author Sebastian Zankel (mail@greenlight-solutions.net)
  ###
  $scope.clickCallback = ($event, name)->
    a = $scope.elementClick($event, name)
    while a.toString().indexOf('locals') > -1
      a = $scope.elementClick($event, name)
    ###Execute reference to the function###
    a($event, name)


  null
])
