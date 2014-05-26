_ = require('lodash')
{Representer} = require('halpert-representer').representer
{LinkItem} = require('halpert-representer').links

parseLinkItem = (link) ->
  linkItem = new LinkItem
  linkItem.rels = [ link.rel ]
  linkItem.href = link.href
  linkItem.label = link.title if link.title?
  linkItem.classes = [link.name] if link.name?
  linkItem

module.exports.parseLinks = parseLinks = (halRep) ->
    rep = new Representer

    unless halRep._links?
      return rep

    # HAL links are objects where the keys/indicies are link relations
    # and the values can be either a link object or an array of links.
    # Because of this, we have to handle these values differently.

    linkArray = _.reduce halRep._links, (memo, link, rel) ->
      if not _.isArray(link)
        memo.concat [_.extend({}, link, { rel: rel })]
      else
        memo.concat _.reduce link, (memo2, item) ->
          memo2.concat [_.extend({}, item, { rel: rel })]
        , []
    , []

    basicLinks = linkArray.filter (link) -> not link.templated? or not link.templated
    templatedLinks = linkArray.filter (link) -> link.templated

    rep.links.items = basicLinks.map (link) -> parseLinkItem(link)
    rep.templatedLinks.items = templatedLinks.map (link) -> parseLinkItem(link)
    rep

module.exports.parseProperties = parseProperties = (halRep) ->
    rep = new Representer
    rep.properties = _.omit(halRep, "_links", "embedded")
    rep

module.exports.parseEmbedded = parseEmbedded = (halRep) ->
    rep = new Representer

    unless halRep._embedded?
      return rep

    embeddedArray = _.reduce halRep._embedded, (memo, resource, rel) ->
      if not _.isArray(resource)
        memo.concat [parseResource(resource, rel)]
      else
        memo.concat _.reduce resource, (memo2, item) ->
          memo2.concat [parseResource(item, rel)]
        , []
    , []

    rep.partials.items = embeddedArray
    rep

module.exports.parseResource = parseResource = (halRep, rel) ->
    rep = new Representer
    rep.rels = [ rel ] if rel

    links = parseLinks(halRep) if halRep._links?
    properties = parseProperties(halRep)
    partials = parseEmbedded(halRep)

    rep.links = links.links
    rep.templatedLinks = links.templatedLinks
    rep.properties = properties.properties
    rep.partials = partials.partials

    rep

module.exports.parseHal = parseHal = (formats, halRep) ->
  rep = parseResource(halRep)
  rep.formats = formats
  rep


