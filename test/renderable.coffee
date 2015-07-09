expect = require 'expect.js'
{renderable, div, span, text} = require '..'
React = require 'react'

describe 'renderable decorator', ->
  it 'makes a template directly callable', ->
    template = renderable (letters) ->
      div ->
        for letter in letters
          div -> text letter

    expect(React.renderToStaticMarkup template ['a', 'b', 'c'])
      .to.equal '<div><div>a</div><div>b</div><div>c</div></div>'

  it 'supports composition with renderable and non-renderable helpers', ->

    renderableHelper = renderable (user) ->
      span -> text user.first

    vanillaHelper = (user) ->
      span -> text user.last

    template = renderable (user) ->
      div ->
        renderableHelper(user)
        vanillaHelper(user)

    expect(React.renderToStaticMarkup template first:'Huevo', last:'Bueno')
      .to.equal '<div><span>Huevo</span><span>Bueno</span></div>'
