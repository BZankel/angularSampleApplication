###*
 *This service handles all the configuration for the application
 *Within that file the module for sampleApplication services gets defined
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
moduleName = 'sampleApplication.services'
serviceName = "sampleApplicationConfigurationService"
angular.module(moduleName, []).service serviceName, ->

  ###Object holding all pathes###
  pathes =
    views: 'views/'
    appPathToViews: "../views/"


  ###Base urls###
  _backendBaseUrl = 'http://localhost:8085/'
  ###Object holding all urls###
  urls =
    backend:
      baseUrl: _backendBaseUrl
      initialData: _backendBaseUrl + 'initialData'


  ###Mock for the userData###
  userData =
    username: 'domain\\username'
    password: 'test'



  ###Application configuration###
  appConfig =
    translation:
      folders: 'prefix': 'resources/i18n/','suffix': '.json'
      preferredLanguage: "de"
    routing:
      defaultRoute: "/sampleModule/jsonDragger"
    communication:
      resourceWhitelist: ['http://localhost:8085/**', 'self']


  ###The events that get send throughout the application###
  events =
    jsonDraggerStateChange: 'com:sampleApplication:$1:jsonDragger:stateChange'
    renderFieldChanged: 'com:sampleApplication:$1:renderFields:stateChange:'

  ###The varianles in the localStorage###
  localStorage =
    jsonDraggerActualSelection: "jsonDraggerActualSelection"

  ###Public interface###
  pathes: pathes
  urls: urls
  userData: userData
  events: events
  localStorage: localStorage
  appConfig: appConfig
