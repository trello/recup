should = require 'should'
t = require '..'
React = require 'react'

it 'returns a react thing', ->
  template = -> t.div()
  React.isValidElement(t.render(template)).should.be.true
