###*
 *This is the jsonDraggerElement directive that handles the logic for a dragger element
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

moduleName = 'sampleApplication.jsonDragger'
directiveName = 'sampleApplicationJsonDraggerElement'
elementCategory = "widgets"
subType = "elements"
widgetName = "jsonDragger"
filePositionRelation = "../../../../../../"
angular.module(moduleName).directive(directiveName, ['sampleApplicationConfigurationService', (configService)->
  templateUrl: (element, attributes)->
    attributes.templateUrl or filePositionRelation + configService.pathes.views + elementCategory + "/" + widgetName + "/" + subType + "/" + directiveName + ".html"
  scope:
    elementData: "="
    doubleClickCallback: "&"
    renderField: "="
    updateRenderField: "="
    moduleName: "="
  restrict: 'AE'
  require: "^editableText"
  controller: 'sampleApplicationJsonDraggerElementController'
  #controllerAs: 'jsonDraggerElementCtrl'
])
