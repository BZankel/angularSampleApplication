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

###Settings###
moduleName = 'sampleApplication.providers'
providerName = "sampleApplicationConfiguration"

###Module definition###
angular.module(moduleName, ["sampleApplication.services"]).provider providerName, class sampleApplicationConfigurationProvider
  @$get =  ['$injector', ($injector)->
      @configService = $injector.get('sampleApplicationConfigurationService')
  ]
  new sampleApplicationConfigurationProvider().$get

