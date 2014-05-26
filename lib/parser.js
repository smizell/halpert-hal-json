var LinkItem, Representer, parseEmbedded, parseHal, parseLinkItem, parseLinks, parseProperties, parseResource, _;

_ = require('lodash');

Representer = require('halpert-representer').representer.Representer;

LinkItem = require('halpert-representer').links.LinkItem;

parseLinkItem = function(link) {
  var linkItem;
  linkItem = new LinkItem;
  linkItem.rels = [link.rel];
  linkItem.href = link.href;
  if (link.title != null) {
    linkItem.label = link.title;
  }
  if (link.name != null) {
    linkItem.classes = [link.name];
  }
  return linkItem;
};

module.exports.parseLinks = parseLinks = function(halRep) {
  var basicLinks, linkArray, rep, templatedLinks;
  rep = new Representer;
  if (halRep._links == null) {
    return rep;
  }
  linkArray = _.reduce(halRep._links, function(memo, link, rel) {
    if (!_.isArray(link)) {
      return memo.concat([
        _.extend({}, link, {
          rel: rel
        })
      ]);
    } else {
      return memo.concat(_.reduce(link, function(memo2, item) {
        return memo2.concat([
          _.extend({}, item, {
            rel: rel
          })
        ]);
      }, []));
    }
  }, []);
  basicLinks = linkArray.filter(function(link) {
    return (link.templated == null) || !link.templated;
  });
  templatedLinks = linkArray.filter(function(link) {
    return link.templated;
  });
  rep.links.items = basicLinks.map(function(link) {
    return parseLinkItem(link);
  });
  rep.templatedLinks.items = templatedLinks.map(function(link) {
    return parseLinkItem(link);
  });
  return rep;
};

module.exports.parseProperties = parseProperties = function(halRep) {
  var rep;
  rep = new Representer;
  rep.properties = _.omit(halRep, "_links", "embedded");
  return rep;
};

module.exports.parseEmbedded = parseEmbedded = function(halRep) {
  var embeddedArray, rep;
  rep = new Representer;
  if (halRep._embedded == null) {
    return rep;
  }
  embeddedArray = _.reduce(halRep._embedded, function(memo, resource, rel) {
    if (!_.isArray(resource)) {
      return memo.concat([parseResource(resource, rel)]);
    } else {
      return memo.concat(_.reduce(resource, function(memo2, item) {
        return memo2.concat([parseResource(item, rel)]);
      }, []));
    }
  }, []);
  rep.partials.items = embeddedArray;
  return rep;
};

module.exports.parseResource = parseResource = function(halRep, rel) {
  var links, partials, properties, rep;
  rep = new Representer;
  if (rel) {
    rep.rels = [rel];
  }
  if (halRep._links != null) {
    links = parseLinks(halRep);
  }
  properties = parseProperties(halRep);
  partials = parseEmbedded(halRep);
  rep.links = links.links;
  rep.templatedLinks = links.templatedLinks;
  rep.properties = properties.properties;
  rep.partials = partials.partials;
  return rep;
};

module.exports.parseHal = parseHal = function(formats, halRep) {
  var rep;
  rep = parseResource(halRep);
  rep.formats = formats;
  return rep;
};
