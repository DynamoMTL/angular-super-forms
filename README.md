# Super Forms

Angular.js forms made easy. (inspired by [formtastic](https://github.com/justinfrench/formtastic))

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
bower install ng-super-form --save
```

## License

MIT
