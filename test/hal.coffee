Hal = require('../lib/hal')
chai = require('chai')
expect = chai.expect

basicLinks =
  item:
    href: "/item/1"
  order:
    href: "/order/1"

linksWithArrays = 
  item: [
    { href: "/item/1" }
    { href: "/item/2" }
    { href: "/item/3" }
  ]
  order:
    href: "/order/1"

complexExample = 
  item: [
    { href: "/item/1" }
    { href: "/item/2" }
    { href: "/item/3", templated: true }
  ]
  order:
    href: "/order/1"
    templated: true
  customer:
    href: "/customers/2"
    templated: false

describe "HAL Representer", ->
  hal = {}

  beforeEach ->
    hal = new Hal

  describe "objects", ->

    it "should return all the links", ->
      rep = hal.links(basicLinks)
      expect(rep.links.items.length).to.equal 2

    it "should return a LinkCollection", ->
      rep = hal.links(basicLinks)
      items = rep.links.filterByRel("item")
      expect(items.length).to.equal 1

  describe "arrays", ->

    it "should return all the links", ->
      rep = hal.links(linksWithArrays)
      expect(rep.links.items.length).to.equal 4

  describe "templated links", ->

    it "should regular and templated links", ->
      rep = hal.links(complexExample)
      expect(rep.links.items.length).to.equal 3
      expect(rep.templatedLinks.items.length).to.equal 2




