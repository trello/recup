expect = require 'expect.js'
{renderable, p, div} = require '..'
React = require 'react'

describe 'tag', ->
  it "renders undefined as ''", ->
    expect(React.renderToStaticMarkup renderable(p) undefined).to.equal "<p></p>"

  it 'renders empty tags', ->
    template = renderable ->
      p()
    expect(React.renderToStaticMarkup template()).to.equal('<p></p>')
