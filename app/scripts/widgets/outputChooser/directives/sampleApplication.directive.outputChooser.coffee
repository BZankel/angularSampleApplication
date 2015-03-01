###*
 *This is the jsonDragger directive that gets used throughout the sample applications
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


moduleName = 'sampleApplication.outputChooser'
directiveName = 'sampleApplicationOutputChooser'
elementCategory = "widgets"
widgetName = "outputChooser"
filePositionRelation = "../../../../"
angular.module(moduleName).directive(directiveName, ['sampleApplicationConfigurationService',  (configService)->
  templateUrl: (element, attributes)->
    attributes.templateUrl or filePositionRelation + configService.pathes.views + elementCategory + "/" + widgetName + "/" + directiveName + ".html"
  scope:
    dataModel: "="
    elementClick: "&"
    outputChooserId: "="
  restrict: 'AE'
  controller: 'sampleApplicationoutputChooserController as outputChooserCtrl'
])
