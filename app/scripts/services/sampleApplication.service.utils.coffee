###*
 *This service holds utility functions
 *TODO: we could also extend lodash
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
serviceName = "sampleApplicationUtilsService"
moduleName = 'sampleApplication.services'
angular.module(moduleName).service serviceName, [->

  ###*
   *@function
   *@description This function orders the base json by parent
   *@param {object} data The payload of the response
   *@param {string} status The status of the response
   *@param {object} headers The headers of the response
   *@param {object} config The configuration of the response
   *@author Sebastian Zankel (mail@greenlight-solutions.net)
  ###
  orderJson = (input, output)->
    ###Find the hightes parent###
    oKey = null
    for key, value in input
      if parseInt(value.parentId,10) > parseInt(highestNode.parentId, 10)
        highestNode =  value
        oKey = key
    output.push(highestNode)
    input.splice(oKey, 1)
    while input.length > 0
      orderJson(input, output)
    return output

  ###Public interface###
  orderJson: orderJson
]
