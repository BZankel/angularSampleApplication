###*
 *This service handles all the communication to the backends
 *TODO: Might replace that by RESTangular https://github.com/mgonto/restangular#setrequestinterceptor
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
serviceName = "sampleApplicationCommunicationService"
moduleName = 'sampleApplication.services'
angular.module(moduleName).service serviceName, ['$http', '$resource', '$q', '$log', '$filter',
($http, $resource, $q, $log, $filter)->

  ###*
   *@function
   *@description This function maps an http response
   *@param {object} data The payload of the response
   *@param {string} status The status of the response
   *@param {object} headers The headers of the response
   *@param {object} config The configuration of the response
   *@author Sebastian Zankel (mail@greenlight-solutions.net)
  ###
  _mapHttpResponse = (data, status, headers, config)->
    data: data
    status: status
    headers: headers
    config: config


  ###*
    *@function
    *@description This function is currently a mock for the REST interface
    *@param {string} url The url where the server data should be requested
    *@param {string} method The method with which the server data should be requested
    *@param {string} instance The instance requesting the data
    *@param {string} instanceType Type of the instance requesting the data controller | service ...
    *@param {object} headers Header information that should be used
    *@param {object} data Json object payload for post requests
    *@author Sebastian Zankel (mail@greenlight-solutions.net)
  ###
  requestServerData = (url, method, instance, instanceType, headers, data)->
    deferred = $q.defer()
    ###Casting errors in the passed data###
    _url = if url.indexOf('http://') is -1 then 'http://' + url else url
    method = method.toUpperCase()
    switch instanceType
      when "controller" then $log.info(($filter('translate')("_logMessages.controller.requestServerData_")).replace("$1", instance).replace("$2", _url))

    ###Building the request###
    ###Mandatory fields###
    req =
      method: method
      url: _url
    ###Optional fields###
    req.headers = if headers isnt undefined then headers else {}

    if method is 'POST' then req.data = data
    ###Doing the http request###
    $http(req)
      .success (url, method, headers, data)->
        response = _mapHttpResponse(url, method, headers, data)
        switch instanceType
          when "controller"
            $log.info(($filter('translate')("_logMessages.controller.requestServerDataSuccess_"))
              .replace("$1", instance)
              .replace("$2", _url)
            )
            $log.debug($filter('translate')("_logMessages.responseWas_"), response)
        deferred.resolve(response)
      .error (url, method, headers, data)-> deferred.reject(_mapHttpResponse(url, method, headers, data))

    ###Returning a promise###
    return deferred.promise


  requestServerData: requestServerData
]
