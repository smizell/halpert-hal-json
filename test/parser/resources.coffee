{resource, embedded} = require('../../lib/parser')
chai = require('chai')
expect = chai.expect

halRep = {
  "_links": {
    "self": { "href": "/orders" },
    "curies": [{ "name": "ea", "href": "http://example.com/docs/rels/{rel}", "templated": true }],
    "next": { "href": "/orders?page=2" },
    "ea:find": {
      "href": "/orders{?id}",
      "templated": true
    },
    "ea:admin": [{
      "href": "/admins/2",
      "title": "Fred"
    }, {
      "href": "/admins/5",
      "title": "Kate"
    }]
  },
  "currentlyProcessing": 14,
  "shippedToday": 20,
  "_embedded": {
    "ea:order": [{
      "_links": {
        "self": { "href": "/orders/123" },
        "ea:basket": { "href": "/baskets/98712" },
        "ea:customer": { "href": "/customers/7809" }
      },
      "total": 30.00,
      "currency": "USD",
      "status": "shipped"
    }, {
      "_links": {
        "self": { "href": "/orders/124" },
        "ea:basket": { "href": "/baskets/97213" },
        "ea:customer": { "href": "/customers/12369" }
      },
      "total": 20.00,
      "currency": "USD",
      "status": "processing"
    }]
  }
}

describe "HAL Resource", ->

  describe "full", ->

    it "should return a full representer", ->
      rep = resource(halRep)
      expect(rep.properties.shippedToday).to.equal 20
      expect(rep.links.items.length).to.equal 4

  describe "embedded", ->

    it "should return a partial collection", ->
      rep = embedded(halRep)
      expect(rep.partials.items.length).to.equal 2

