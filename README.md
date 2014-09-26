# Super Forms

Angular.js forms made **super** easy. (inspired by [formtastic](https://github.com/justinfrench/formtastic))

## Features

- generates `label`, error message `p`
- supports attribute validation (i.e. `required`) and custom validation
- easy to customize field layouts and buttons
- supports [bootstrap](http://getbootstrap.com) out of the box
- allows different layouts for different form types (i.e. inline style, placeholder style)

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

## Supported Field Types

- text
- email
- tel
- url
- number
- checkbox
- textarea
- date
- datetime
- time
- range
- file
- select

# Installation

```
bower install angular-super-forms --save
```

# Development

[Grunt](http://gruntjs.com) is installed to convert `.coffee` into `.js` and to run tests. Run `grunt watch` to monitor `.coffee` files. Run `grunt test` to test script in browser.

## License

MIT
