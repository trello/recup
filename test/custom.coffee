expect = require 'expect.js'
{render, tag, input, normalizeArgs} = require '..'
React = require 'react'

describe 'custom tag', ->
  it 'should render', ->
    template = -> tag 'custom'
    expect(React.renderToStaticMarkup render(template)).to.equal '<custom></custom>'
  it 'should render empty given null content', ->
    template = -> tag 'custom', null
    expect(React.renderToStaticMarkup render(template)).to.equal '<custom></custom>'

describe 'custom tag-like', ->
  textInput = ->
    {attrs, contents} = normalizeArgs arguments
    attrs.type = 'text'
    input attrs, contents

  it 'should render', ->
    template = -> textInput()
    expect(React.renderToStaticMarkup render(template)).to.equal '<input type="text">'

  it 'should accept a selector and attributes', ->
    template = -> textInput '.form-control', placeholder: 'Beep'
    expect(React.renderToStaticMarkup render(template)).to.equal '<input placeholder="Beep" class="form-control" type="text">'
