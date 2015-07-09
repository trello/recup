expect = require 'expect.js'
{render, div, img} = require '..'
React = require 'react'

describe 'CSS Selectors', ->
  describe 'id selector', ->
    it 'sets the id attribute', ->
      template = -> div '#myid'
      expect(React.renderToStaticMarkup render(template)).to.equal '<div id="myid"></div>'

    it 'must be greater than length 1', ->
      template = -> div '#'
      expect(-> React.renderToStaticMarkup render(template)).to.throwError /Only pass strings that are selectors/

  describe 'one class selector', ->
    it 'adds an html class', ->
      template = -> div '.myclass'
      expect(React.renderToStaticMarkup render(template)).to.equal '<div class="myclass"></div>'

    describe 'and a class attribute', ->
      it 'prepends the selector class', ->
        template = -> div '.myclass', 'class': 'myattrclass'
        expect(React.renderToStaticMarkup render(template)).to.equal '<div class="myclass myattrclass"></div>'

  describe 'multi-class selector', ->
    it 'adds all the classes', ->
      template = -> div '.myclass.myclass2.myclass3'
      expect(React.renderToStaticMarkup render(template)).to.equal '<div class="myclass myclass2 myclass3"></div>'

  describe 'with an id and classes, separated by spaces', ->
    it 'adds ids and classes with minimal whitespace', ->
      template = -> div '#myid .myclass1 .myclass2 '
      expect(React.renderToStaticMarkup render(template)).to.equal '<div id="myid" class="myclass1 myclass2"></div>'

  describe 'without contents', ->
    it 'still adds attributes', ->
      template = -> img '#myid.myclass', src: '/pic.png'
      expect(React.renderToStaticMarkup render(template)).to.equal '<img src="/pic.png" id="myid" class="myclass">'

