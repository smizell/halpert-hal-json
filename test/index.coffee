hal = require('../src/index')
halRep = require('./fixtures/fullExample')
chai = require('chai')
expect = chai.expect

formats = {}

describe "Index", ->

  it "should be HAL's media type", ->
    expect(hal.formatName).to.equal 'application/hal+json'

  describe "parser", ->

    it "should parse a HAL document", ->
      rep = hal.parser(formats, halRep)
      expect(rep.properties.shippedToday).to.equal 20