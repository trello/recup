expect = require 'expect.js'
{render, raw, script, escape, h1, input, text} = require '..'
React = require 'react'

describe 'Auto escaping', ->
  describe 'a script tag', ->
    it "adds HTML entities for sensitive characters", ->
      template = -> h1 -> text "<script>alert('\"owned\" by c&a &copy;')</script>"
      expect(React.renderToStaticMarkup render(template)).to.equal "<h1>&lt;script&gt;alert(&#x27;&quot;owned&quot; by c&amp;a &amp;copy;&#x27;)&lt;/script&gt;</h1>"

  it 'escapes tag attributes', ->
    template = -> input name: '"pwned'
    expect(React.renderToStaticMarkup render(template)).to.equal '<input name="&quot;pwned">'

describe 'raw filter', ->
  it 'prints sensitive characters verbatim', ->
    template = -> raw "<script>alert('on purpose')</script>"
    expect(React.renderToStaticMarkup render(template)).to.equal "<span><script>alert('on purpose')</script></span>"
