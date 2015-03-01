###*
 *This is a small sample app for the sampleApplication
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

moduleName = "sampleApplication"
angular.module(moduleName, [
  #'ngAnimate' #Angular animation
  'ngResource' #REST support $resource-service
  'toastr' #Message library
  'ui.router' #Angular UI router
  'ui.sortable' #jQuery ui sortable wrapper
  'pascalprecht.translate' #Translation library of pascal precht
  #Services
  'sampleApplication.services' #The module with the services
  #Application modules
  'sampleApplication.sampleModule' #Our sample module
])
#HTTP interceptor
.factory('httpInterceptor', ['sampleApplicationConfigurationService', (configService)->
    request: (config)->
      if config.url.indexOf(configService.urls.backend.baseUrl) > -1
        config.url = config.url +
          (if config.url.indexOf('?') > -1 then '&' else '?') +
          'username=' + configService.userData.username + "&password=" + configService.userData.password
      return config
])
.config(['$stateProvider'
'$urlRouterProvider'
'$httpProvider'
'$translateProvider'
'$sceDelegateProvider'
'sampleApplicationConfigurationServiceProvider'
($stateProvider, $urlRouterProvider, $httpProvider,$translateProvider, $sceDelegateProvider, configProvider) ->

  ###A bit hacky but okay Provider wasn't working in coffeescript TODO: Replace that###
  configProvider = configProvider.$get()

  ###Adding an interceptor to backend requests###
  $httpProvider.interceptors.push('httpInterceptor')

  ###Setting whitelist for CORS###
  $sceDelegateProvider.resourceUrlWhitelist(configProvider.appConfig.communication.resourceWhitelist)

  ###Translation configuration###
  $translateProvider.useStaticFilesLoader(configProvider.appConfig.translation.folders)

  $translateProvider.preferredLanguage configProvider.appConfig.translation.preferredLanguage

  ###Routing configuration###
  $urlRouterProvider.otherwise(configProvider.appConfig.routing.defaultRoute)
  $stateProvider
  .state 'sampleModule',
    templateUrl: configProvider.pathes.appPathToViews + 'modules/sampleModule/sampleModule.html'
    url: "/sampleModule"
    controller: 'sampleApplicationSampleModuleController as sampleModuleCtrl'
  .state 'sampleModule.jsonDragger',
    url: "/jsonDragger"
    views:
      "left":
        templateUrl: configProvider.pathes.appPathToViews + "modules/sampleModule/wrapper/jsonDraggerWrapper.html"
      "rightBottom":
        templateUrl: configProvider.pathes.appPathToViews + "modules/sampleModule/wrapper/outputChooserWrapper.html"
      "rightTop":
        templateUrl: configProvider.pathes.appPathToViews + "modules/sampleModule/wrapper/codeMirrorWrapper.html"
])
