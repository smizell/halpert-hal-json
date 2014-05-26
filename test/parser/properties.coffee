{parseProperties} = require('../../lib/parser')
{halRep} = require('../fixtures/propertiesExample')
chai = require('chai')
expect = chai.expect

describe "HAL Properties", ->

  it "should return only the properties", ->
    rep = parseProperties(halRep)
    expect(rep.properties.field1).to.equal 1

  it "should not return the links", ->
    rep = parseProperties(halRep)
    expect(rep.properties._links).to.be.an('undefined')
