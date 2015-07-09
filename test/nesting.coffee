expect = require 'expect.js'
{render, div, p, text} = require '..'
React = require 'react'

describe 'nesting templates', ->
  it 'renders nested template in the same output', ->
    user =
      first: 'Huevo'
      last: 'Bueno'

    nameHelper = (user) ->
      p -> text "#{user.first} #{user.last}"

    template = (user) ->
      div ->
        nameHelper user

    expect(React.renderToStaticMarkup render(template, user)).to.equal '<div><p>Huevo Bueno</p></div>'
