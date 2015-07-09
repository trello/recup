expect = require 'expect.js'
{render, a, br, div} = require '..'
React = require 'react'

describe 'Attributes', ->

  describe 'with a hash', ->
    it 'renders the corresponding HTML attributes', ->
      template = -> a href: '/', title: 'Home'
      expect(React.renderToStaticMarkup render(template)).to.equal '<a href="/" title="Home"></a>'

  describe 'unknown attributes', ->
    it 'drops them', ->
      template = -> br foo: yes, bar: true
      expect(React.renderToStaticMarkup render(template)).to.equal '<br>'

  describe 'Boolean true value', ->
    it 'is replaced with the attribute name.  Useful for attributes like disabled', ->
      template = -> br disabled: true
      expect(React.renderToStaticMarkup render(template)).to.equal '<br disabled>'

  describe 'Boolean false value', ->
    it 'is omitted', ->
      template = -> br disabled: false
      expect(React.renderToStaticMarkup render(template)).to.equal '<br>'

  describe 'data attribute', ->
    it 'expands attributes', ->
      template = -> br data: { name: 'Name', value: 'Value' }
      expect(React.renderToStaticMarkup render(template)).to.equal '<br data-name="Name" data-value="Value">'
