module.exports.basicLinks =
  _links:
    item:
      href: "/item/1"
    order:
      href: "/order/1"

module.exports.linksWithArrays =
  _links:
    item: [
      { href: "/item/1" }
      { href: "/item/2" }
      { href: "/item/3" }
    ]
    order:
      href: "/order/1"

module.exports.complexExample =
  _links:
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