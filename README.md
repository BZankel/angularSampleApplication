# angularSampleApplication
This is a working sample of Greenlight-Solutions

#Requirements
- The snippet should display a dynamic tree loaded from JSON.
- Each node can be edited in-line (or in-place) by double-clicking on it. The label should change to an edit box.
- Some nodes can accept only numerical values (specified in JSON as a type property).
- Some examples of nodes: {id: 123, label: 'root', parentId: -1}, {id:1234, label: 'child', parentId: 123}, {id: 12345, label: 'numbers only', parentId: 1234, type: N}
- The nodes should accept updates from outside (values, parent/position) and the tree should update accordingly: getNodeWithId(1234).setParentId(123)
- The modified tree can be saved back to a JSON. TODO!!!

Bonus points for:

- drag&drop
- implementing a 'disabled' feature that disallows editing nodes
- making a type of node that has a dropdown box when edited TODO!!!
- CSS styling of the nodes

#Installation
1. Install node.js
2. Open the node command prompt
3. Run npm install bower -g
4. Run npm install grunt -g
5. Run npm install grunt-cli -g
6. Run npm install nodemon -g
7. Install ruby and add to your path
8. install ruby scss gem
9. Run npm install from the root directory
10. Run bower install from the root directory (Use angular 1.3+ to make one way databinding work)
11. Run npm install in the server directory
12. Create logs directory under server directory
13. Run nodemon server.coffee from the server directory
14. Run grunt serve from the root directory

#TODO
1. Write unit tests
2. Make the communication-service working with Restangular
3. Filedownload json and filedrop
4. Username and Password to header
5. Make build task working properly
6. Making a type of node that has a dropdown box when edited
