{properties} = require('../../lib/parser')
chai = require('chai')
expect = chai.expect

halRep =
  field1: 1
  field2: 2
  _links:
    item:
      href: "/item/1"
    order:
      href: "/order/1"
  _embedded:
    customer:
      _links:
        next:
          href: "/customers1"

describe "HAL Properties", ->

  it "should return only the properties", ->
    rep = properties(halRep)
    expect(rep.properties.field1).to.equal 1

  it "should not return the links", ->
    rep = properties(halRep)
    expect(rep.properties._links).to.be.an('undefined')

