const {doSomethingWith} = require('./src/other')

const handler = (event, context, callback) => {
  callback(null, doSomethingWith('Javascript'))
}

module.exports = { handler }
