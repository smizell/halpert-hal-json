_ = require('lodash')
{Representer} = require('halpert-representer').representer
{LinkItem} = require('halpert-representer').links

parseLinkItem = (link) ->
  linkItem = new LinkItem
  linkItem.rels = [ link.rel ]
  linkItem.href = link.href
  linkItem

addRel = (link, rel) ->
  _.extend link, { rel: rel }

module.exports = class Hal
  links: (links) ->
    rep = new Representer

    linkArray = _.reduce links, (memo, link, rel) ->
      if not _.isArray(link)
        memo.concat [_.extend(link, { rel: rel })]
      else
        memo.concat _.reduce link, (memo2, link) ->
          memo2.concat [_.extend(link, { rel: rel })]
        , []
    , []

    basicLinks = linkArray.filter (link) -> not link.templated? or not link.templated
    templatedLinks = linkArray.filter (link) -> link.templated

    rep.links.items = basicLinks.map (link) -> parseLinkItem(link)
    rep.templatedLinks.items = templatedLinks.map (link) -> parseLinkItem(link)
    rep

