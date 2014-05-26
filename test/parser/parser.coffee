{parseHal} = require('../../lib/parser')
halRep = require('../fixtures/fullExample')
chai = require('chai')
expect = chai.expect

formats = {}

describe "Parser", ->

  it "should parse a HAL document", ->
    rep = parseHal(formats, halRep)
    expect(rep.properties.shippedToday).to.equal 20