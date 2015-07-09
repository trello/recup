expect = require 'expect.js'
{render, raw, cede, div, p, strong, a, text} = require '..'
React = require 'react'

describe 'render', ->
  describe 'nested in a template', ->
    it 'returns the nested template without clobbering the parent result', ->
      template = ->
        p ->
          raw "This text could use #{React.renderToStaticMarkup render -> strong -> a href: '/', -> text 'a link'}."
      expect(React.renderToStaticMarkup render(template)).to.equal '<p><span>This text could use <strong><a href="/">a link</a></strong>.</span></p>'

    it 'is aliased as cede', ->
      template = ->
        p ->
          raw "This text could use #{React.renderToStaticMarkup cede -> strong -> a href: '/', -> text 'a link'}."
      expect(React.renderToStaticMarkup render(template)).to.equal '<p><span>This text could use <strong><a href="/">a link</a></strong>.</span></p>'

  it 'doesn\'t modify the attributes object', ->
    d = { id: 'foobar', class: 'myclass', href: 'http://example.com', }
    template = ->
      p ->
        a d, -> text "link 1"
        a d, -> text "link 2"
    expect(React.renderToStaticMarkup render(template)).to.equal '<p><a id="foobar" href="http://example.com" class="myclass">link 1</a><a id="foobar" href="http://example.com" class="myclass">link 2</a></p>'
