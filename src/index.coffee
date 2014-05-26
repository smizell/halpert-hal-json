{parseHal} = require('./parser')

module.exports =
  formatName: "application/hal+json"
  parser: parseHal
  builder: (formats, data) -> data