var parseHal;

parseHal = require('./parser').parseHal;

module.exports = {
  formatName: "application/hal+json",
  parser: parseHal,
  builder: function(formats, data) {
    return data;
  }
};
