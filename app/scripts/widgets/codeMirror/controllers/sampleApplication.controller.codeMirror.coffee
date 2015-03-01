###*
 *This controller is for the codeMirror module
 *In this file the module for the codeMirror module gets defined
 *Here we define the dependencies that are needed for this module
 *All the functions that are responsible for the communication
 *outwords get injected via scope data attributes
 *The codeMirror is so highly reuse and costumizeable
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


moduleName = 'sampleApplication.codeMirror'
controllerName = 'sampleApplicationCodeMirrorController'
elementType = 'wigdet'
angular.module(moduleName, [
  'sampleApplication.services' #The application services
  'ui.codemirror' #Codemirror module
]).controller(controllerName, ['$scope'
($scope)->

  @modelChange = ($event, modelContent)->
    $event.stopPropagation()
    $event.preventDefault()
    console.log modelContent
    eval(modelContent)
    return null




  null
])
