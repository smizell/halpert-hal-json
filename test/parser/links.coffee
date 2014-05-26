{parseLinks} = require('../../lib/parser')
{basicLinks, linksWithArrays, complexExample} = require('../fixtures/linkExamples')
chai = require('chai')
expect = chai.expect

describe "HAL Links", ->

  describe "objects", ->

    it "should return all the links", ->
      rep = parseLinks(basicLinks)
      expect(rep.links.items.length).to.equal 2

    it "should return a LinkCollection", ->
      rep = parseLinks(basicLinks)
      items = rep.links.filterByRel("item")
      expect(items.length).to.equal 1

  describe "arrays", ->

    it "should return all the links", ->
      rep = parseLinks(linksWithArrays)
      expect(rep.links.items.length).to.equal 4

  describe "templated links", ->

    it "should regular and templated links", ->
      rep = parseLinks(complexExample)
      expect(rep.links.items.length).to.equal 3
      expect(rep.templatedLinks.items.length).to.equal 2




