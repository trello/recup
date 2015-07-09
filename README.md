# Recup

Recup is Teacup (templates in CoffeeScript) for React.

A beautiful DSL for building React elements.  JSX doesn't play nice with
CoffeeScript, and raw React is ugly - Recup is the answer.

See [Teacup](https://github.com/goodeggs/teacup) for docs, since this is meant
to mirror it very closely.

### Differences from Teacup

- The top-level render function must return _exactly one_ root element (and it can't be a text element).  Just wrap it in a `div` if this presents a problem.
- `t.raw` wraps its contents in a `span` tag.
- `style` attribute is expected to be an object instead of a string, in the style of React.  The camelCase to kebab-case conversion will be done for you, so use `backgroundColor`, not `background-color`.
- Contents can only be specified as a function.  None of this `h1 "contents"` stuff.
  - This is an intentional breakage - if the contents are a dynamic string, one day they will be interpreted as a selector because of a leading `.` or `#`, and then everything goes wrong.
- `class` is aliased to `className`.  Specifying both will result in an error.
- The functions `coffeescript`, `escape`, `script`, `ie`, `style`, and `use` are missing.  Also, probably others.
  - Yep, no plugins.  Sorry.
- Returning a string from a contents function doesn't work.  Use `t.text` instead.
- Self-closing tags don't error if you try to specify contents.  React will do whatever it does with the contents.
