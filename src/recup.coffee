React = require('react')

els = require('./elements')

class TeacupReact
  constructor: ->
    @elementsOut = null

  resetBuffer: (elements=null) ->
    previous = @elementsOut
    @elementsOut = elements
    previous

  _render: (template, context, args...) ->
    previous = @resetBuffer([])
    try
      template.apply(context, args)
    finally
      result = @resetBuffer previous
    result

  _unwrap: (nodes) ->
    if nodes.length != 1
      throw Error("template must have exactly one top-level node")
    nodes[0]

  render: (template, args...) ->
    @_unwrap @_render(template, null, args...)

  renderable: (template) ->
    t = @
    (args...) ->
      if t.elementsOut == null
        t._unwrap t._render(template, @, args...)
      else
        template.apply @, args

  renderAttr: ->

  isSelector: (str) ->
    str.length > 1 && str.charAt(0) in ['#', '.']

  parseSelector: (sel) ->
    id = null
    classes = []
    for token in sel.split '.'
      token = token.trim()
      if id
        classes.push token
      else
        [klass, id] = token.split '#'
        if klass
          classes.push klass

    { id, classes }

  normalizeArgs: (args) ->
    attrs = {}
    selector = null
    contents = null

    for arg, index in args when arg?
      switch typeof arg
        when 'string'
          if index == 0 && @isSelector(arg)
            selector = arg
          else
            throw Error('Only pass strings that are selectors', { arg })
        when 'object'
          if arg.constructor == Object
            attrs = arg
          else
            throw Error('Only pass simple objects', { arg })
        when 'function'
          contents = arg
        else
          throw Error('Unrecognized argument type', { arg })

    if attrs.class?
      if attrs.className?
        throw Error("Can't specify both class and className")
      attrs.className = attrs.class
      delete attrs.class

    if selector?
      { id, classes } = @parseSelector(selector)
      attrs.id = id if id?
      if classes.length
        if attrs.className
          classes.push attrs.className
        attrs.className = classes.join(' ')

    { attrs, contents }

  renderChildren: (contents) ->
    if !contents?
      return []
    else if typeof contents is 'function'
      @_render(contents)
    else
      throw Error('Unrecognized contents type', { contents })

  createElement: (args...) ->
    @elementsOut.push React.createElement(args...)

  # I know, this is implemented identically to text.  We want to maintain
  # mostly-compatibility with teacup, and calling text on a react element makes
  # no sense, so here we are.
  addElement: (el) ->
    @elementsOut.push el

  # tagName, [selector,] [props,] [contents]
  tag: (tagName, args...) ->
    { attrs, contents } = @normalizeArgs args
    children = @renderChildren contents
    @elementsOut.push React.createElement(tagName, attrs, children...)

  text: (str) ->
    @elementsOut.push str

  raw: (str) ->
    # If we use dangerouslySetInnerHTML, we can't also pass children.  To not
    # break everything, we implicitly throw the text in a span.
    @span dangerouslySetInnerHTML: __html: str

for tagName in els.regular.concat(els.void, els.obsolete, els.obsolete_void)
  do (tagName) ->
    TeacupReact::[tagName] = (args...) -> @tag tagName, args...

module.exports = new TeacupReact()
