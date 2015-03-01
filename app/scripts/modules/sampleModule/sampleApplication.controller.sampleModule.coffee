###*
 *This controller is for the sampleModule
 *In this file the module for the range plan visualization gets defined
 *Here we define the dependencies that are needed for this module
 *This module passes functions for example to the filterBar
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

moduleName = 'sampleApplication.sampleModule'
controllerName = 'sampleApplicationSampleModuleController'
correspondingState = "sampleModule"
angular.module(moduleName, [
  "sampleApplication.services"
  #Widgets
  'sampleApplication.jsonDragger' #The json dragger widget
  'sampleApplication.outputChooser' #The output chooser widget
  'sampleApplication.codeMirror' #The codemirror widget
]).controller controllerName,
[ '$rootScope'
  '$scope'
  '$log'
  '$filter'
  'sampleApplicationCommunicationService'
  'sampleApplicationConfigurationService'
  ($rootScope, $scope, $log, $filter, communicationService, configService) ->

    ###Setting namespace to empty object on load###
    @jsonDragger = {}
    @outputChooser = {}
    @correspondingState = correspondingState

    @codeMirror =
      configuration:
        lineWrapping : true
        lineNumbers: true
        mode: 'javascript'
        theme: "eclipse"
      modelBinding: $filter('translate')('_codeMirror.pleaseEnterYourCode_')
      modelChange: ->
        console.log @codeMirror.dataModel

    ###*
      *@function
      *@description This finds the renderfield in a json response
      *@param {object} data The returned data
      *@author Sebastian Zankel (mail@greenlight-solutionsnet)
    ###
    _findFieldsOfRequest = (data)=>
      i = 0
      for key of data[0]
        if i is 0
          @jsonDragger.renderField = key
        i++
        @outputChooser.dataModel.push(key)


    ###*
      *@function
      *@description This is the facet request it gets written on the scope to be able to trigger from outside
      *@author Sebastian Zankel (mail@greenlight-solutions.net)
    ###
    @jsonDragger.initialDataRequest = =>
      _url = configService.urls.backend.initialData
      ###Requesting the data for the columnFilterBar###
      communicationService.requestServerData(_url, 'get', controllerName, "controller").then (response)=>
        @jsonDragger.dataModel = response.data
        if !!response.data and response.data.length > 0
          _findFieldsOfRequest(response.data)
      , (reject)->
        $log.error("The request to the node backend for initial data went wrong. The reject was:")
        $log.debug(reject)
        null



    ###*
      *@function
      *@description This is the function to initializes the range plan vizualization
      *@author Sebastian Zankel (mail@greenlight-solutions.net)
    ###
    @initialization = =>
      ###The initial data request###
      @jsonDragger.initialDataRequest()
      @outputChooser =
        dataModel: []
        click: ($event, name)=>
          $scope.$broadcast(configService.events.renderFieldChanged.replace('$1', correspondingState), renderField: name)
          null

      ###The json Dragger configuration###
      @jsonDragger =
        uiSortableOptions:
          update: (e, ui) ->
            if angular.element(ui.item).prev().length > 0
              prevId = angular.element(ui.item).prev().scope().value["id"]
            else
              prevId = -1
            angular.element(ui.item).scope().value["parentId"] = prevId
            return
        id: "jsonDraggerSampleModule"
        doubleClick: ($event, id)->
          $log.info("The click event is also available in the sample Module controller")
          $log.info("Do something here with it")
          $log.debug("The id of the clicked element was: " + id)


    ###initially initialize on load###
    @initialization()



    ###Events###
    $rootScope.$on('$stateChangeSuccess', (event, toState, toParams, fromState, fromParams)->
      if toState is correspondingState then _initialization()
    )

    null
]
