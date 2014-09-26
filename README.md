# Super Forms

Angular.js forms made **super** easy. (inspired by [formtastic](https://github.com/justinfrench/formtastic))

## Example

```jade
  // example in jade
  super-form(submit='doStuff()' style='bootstrap')
    field(model='user.email' type='email' label='Email Address' required)
    field(model='user.name' type='text')
    field(model='user.phone' type='phone')
    field(model='user.subscribed' type='checkbox' label='Newsletter')

    submit(label='Save Profile')
```

# Installation

```
bower install angular-super-forms --save
```

# Development

[Grunt](http://gruntjs.com) is installed to convert `.coffee` into `.js` and to run tests. Run `grunt watch` to monitor `.coffee` files. Run `grunt test` to test script in browser.

## License

MIT
