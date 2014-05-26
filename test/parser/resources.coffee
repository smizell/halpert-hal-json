{parseResource, parseEmbedded} = require('../../src/parser')
halRep = require('../fixtures/fullExample')
chai = require('chai')
expect = chai.expect

describe "HAL Resource", ->

  describe "full", ->

    it "should return a full representer", ->
      rep = parseResource(halRep)
      expect(rep.properties.shippedToday).to.equal 20
      expect(rep.links.items.length).to.equal 4

  describe "embedded", ->

    it "should return a partial collection", ->
      rep = parseEmbedded(halRep)
      expect(rep.partials.items.length).to.equal 2

