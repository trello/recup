expect = require 'expect.js'
{render, h1, text} = require '..'
React = require 'react'

describe 'Context data', ->
  it 'is an argument to the template function', ->
    template = ({foo}) -> h1 -> text foo
    expect(React.renderToStaticMarkup render template, foo: 'bar').to.equal '<h1>bar</h1>'

describe 'Local vars', ->
  it 'are in the template function closure', ->
    obj = {foo: 'bar'}
    template = -> h1 -> text "dynamic: #{obj.foo}"
    expect(React.renderToStaticMarkup render template).to.equal '<h1>dynamic: bar</h1>'
    obj.foo = 'baz'
    expect(React.renderToStaticMarkup render template).to.equal '<h1>dynamic: baz</h1>'
