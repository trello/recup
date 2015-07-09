expect = require 'expect.js'
{render, renderable, text, h1, p} = require '..'
React = require 'react'

describe 'text', ->
  it 'renders text verbatim', ->
    expect(React.renderToStaticMarkup renderable(-> p -> text 'foobar')()).to.equal '<p>foobar</p>'

  it 'renders numbers', ->
    expect(React.renderToStaticMarkup renderable(-> p -> text 1)()).to.equal '<p>1</p>'
    expect(React.renderToStaticMarkup renderable(-> p -> text 0)()).to.equal '<p>0</p>'
