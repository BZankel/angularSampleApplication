###*
 *This filter converts a boolean to a string
 *Here we define the filters module
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

moduleName = 'sampleApplication.filters'
filterName = 'boolean2string'
angular.module(moduleName, []).filter filterName,[->
  return (input)->
    if typeof input is "boolean"
      return input.toString()
    else
      return input
]
