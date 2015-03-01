###*
 *This are the extensions to jQuery to get nodes from outside
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


###*
  *@function
  *@description This function extends jquery to allow selection of a nodekey
  *@namespace jQuery
  *@param {integer} id The id of which the element should be returned
  *@returns {object} A jquery element
  *@author Sebastian Zankel (mail@greenlight-solutions.net)
###
jQuery.fn.getNodeWithId = (id)->
  element = $(@[0])
  if element.hasClass('jsonDragger')
    oElement = null
    $(element).find('.jsonDraggerElement').each( ->
      if $(@).scope().elementData["id"] is id
        oElement = @
        return false
    )
    return $(oElement)
  else
    return $(@)

###*
  *@function
  *@description This function extends jquery to allow to set a parentId
  *@namespace jQuery
  *@param {integer} parentId The parentId that should be applied
  *@returns {object} A jquery element
  *@author Sebastian Zankel (mail@greenlight-solutions.net)
###
that = null
jQuery.fn.setParentId = (parentId)->
  if $(@).hasClass('jsonDraggerElement')
    that = @
    ###Setting the elements parentId###
    $(@).scope().elementData["parentId"] = parentId
    ###Splicing the element from the right position###
    object = $(@).closest(".jsonDragger").closest('ul').scope().dataModel.splice(
      _findObjectInArray($(@).scope().elementData["id"], $(@).closest(".jsonDragger").closest('ul').scope().dataModel), 1
    )
    ###Find the right position###
    if parentId isnt -1
      for val, key in $(@).closest(".jsonDragger").closest('ul').scope().dataModel
        if val.id is parentId
          $(@).closest(".jsonDragger").closest('ul').scope().dataModel.splice(key+1, 0, object[0])
          break;
    else
      $(@).closest(".jsonDragger").closest('ul').scope().dataModel.splice(0, 0, object[0])

    ###Get the rootScope###
    $injector = angular.injector(['ng'])
    $timeout = $injector.get('$timeout')
    $timeout ->
      $(that).closest(".jsonDragger").closest('ul').scope().$apply()
    ,100
    $timeout ->
      if $(that).closest('li').next().length > 0
        $(that).closest('li').next().find('.jsonDraggerElement').scope().elementData["parentId"] = $(that).scope().elementData["id"]
        ###Set back -1 to the first node###
      $(that).closest(".jsonDragger").find('li').first().find('.jsonDraggerElement').scope().elementData["parentId"] = -1
      that = null
      object = null
    ,200

  return $(@)


###*
  *@function
  *@private
  *@decription This is a helper function for the jQuery extend above
  *@param {integer} id The id of the element that should be searched
  *@param {object} array The array that should be searched in
  *@returns {integer} key The key of the retrieved element
  *@author Sebastian Zankel (mail@greenlight-solutions.net)
###
_findObjectInArray = (id, array)->
  for val, key in array
    if val.id is id
      return key
