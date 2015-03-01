###*
 *This is the mock for the servers
 *@author Sebastian Zankel (mail@greenlight-solutions.net)
 *
 *Copyright 2015 Adidas AG
 *NOTICE:  All information contained herein is, and remains
 *the property of Adidas AG and its suppliers,
 *if any.  The intellectual and technical concepts contained
 *herein are proprietary to Adidas AG
 *and its suppliers and may be covered by German and Foreign Patents,
 *patents in process, and are protected by trade secret or copyright law.
 *Dissemination of this information or reproduction of this material
 *is strictly forbidden unless prior written permission is obtained
 *from Adidas AG.
###

app = require('express.io')()
bodyParser = require 'body-parser'
winston = require 'winston'
jf = require 'jsonfile'
compression = require 'compression'
moment = require 'moment'

env = process.env.NODE_ENV = process.env.NODE_ENV or 'development'

app.use compression()
app.use(bodyParser.json())       #to support JSON-encoded bodies
app.use(bodyParser.urlencoded(   #to support URL-encoded bodies
  extended: true
))

###Basic config###
app.http().io()


###Instantiating the logger###
currentTime = -> moment().format('DD.MM.YYYY hh.mm.ss')


nodeFileName = "server.coffee"
#instantiating the logger
logger = new (winston.Logger)
  transports: [
    new (winston.transports.Console)(
      timestamp : currentTime
      label: nodeFileName
    ),
    new (winston.transports.File)(
      filename: 'logs/server.log'
      timestamp : currentTime
      label: nodeFileName
    )
  ]


###This needs to be done via rest--> get the hostname###
#Add headers
app.use (req, res, next)->

  # Website you wish to allow to connect
  res.setHeader('Access-Control-Allow-Origin', '*')

  # Request methods you wish to allow
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE')

  # Request headers you wish to allow
  res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type')

  # Set to true if you need the website to include cookies in the requests sent
  # to the API (e.g. in case you use sessions)
  res.setHeader('Access-Control-Allow-Credentials', true)

  # Pass to next layer of middleware
  next()



###This is to check the login TODO: Move to header###
checkLogin = (req, res, next) ->
  logger.info "Check login:"
  ###Get the username and password via request parameter###
  username = if req.method is 'GET' then req.query.username else req.body.username
  password = if req.method is 'GET' then req.query.password else req.body.password

  ###If login is correct then process can go on###
  if username is 'domain/username' and password is "test"
    logger.info "Login successful, loginData was username = " + username + " password = " + password
    next()
  else
    ###Else respond with 401 and return errorcode###
    logger.info "Login rejected, loginData was username = " + username + " password = " + password
    res.status 401
    res.send 'Error with the login information'



###Get the initial data it must be a parentId and a id in the members###
app.get "/initialData", checkLogin, (req, res)->
  filePath = 'json/initialData.json'
  logger.info "Initial data requested"
  res.json(jf.readFileSync(filePath))

###Download file from client###
app.post '/download', checkLogin, (req, res)->
  file = '/json/tempfile.json'
  jf.writeFileSync(file, res.body.fileContent)
  res.download(file)



app.listen 8085
