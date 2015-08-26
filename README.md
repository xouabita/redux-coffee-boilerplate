# Redux Coffee Boilerplate

A simple redux boilerplate/example written in coffeescript featuring:

- universal aka isomorphic aka "it runs both on server and client"
- hot reloading (w/ [react-hot-loader](https://github.com/gaearon/react-hot-loader))
- configurable webpack config
- [React](https://github.com/facebook/react)
- [react-router](https://github.com/rackt/react-router)
- and [redux](https://github.com/gaearon/redux) of course

If you wonder why coffeescript ? Read [this](http://noredinktech.tumblr.com/post/111583727108/dont-replace-coffeescript-with-es6-transpilers).

### Screenshot

![screenshot](http://g.recordit.co/gcZQkpM5JU.gif)

### Structure

~~~bash
.
├── App.coffee        # Routes and isomorphic helpers
├── README.md
├── actions           # Redux actions
│   └── todo.coffee   # actions for todo
├── api
│   ├── index.coffee
│   └── todo.coffee   # Simple API mock
├── client.coffee     # Entry point for client side
├── components
│   └── Page.coffee   # Page components (for menu)
├── constants
│   └── todos.coffee
├── gulpfile.coffee
├── package.json
├── reducers          # All the reducers
│   ├── index.coffee
│   └── todo.coffee
├── server.coffee     # Entry point for server side
├── services
│   └── Api.coffee    # Wrapper for superagent w/ Promise
├── views
│   ├── Index.coffee  # Simple index, no need for initialData
│   ├── Todo.coffee   # Todo view, need an initialData
│   └── base.html
├── webpack.client.coffee # Config for client
└── webpack.server.coffee # Config for server
~~~

### Annotated source

- [App.coffee](https://cdn.rawgit.com/xouabita/redux-coffee-boilerplate/fd611b9bf3c12df6053b24132173c421035d9940/docs/App.html)
- [Todo.coffee](https://cdn.rawgit.com/xouabita/redux-coffee-boilerplate/fd611b9bf3c12df6053b24132173c421035d9940/docs/Todo.html)
- [client.coffee](https://cdn.rawgit.com/xouabita/redux-coffee-boilerplate/fd611b9bf3c12df6053b24132173c421035d9940/docs/client.html)
- [server.coffee](https://cdn.rawgit.com/xouabita/redux-coffee-boilerplate/fd611b9bf3c12df6053b24132173c421035d9940/docs/server.html)

#### Inspiration

- [react-starter](https://github.com/webpack/react-starter) for the webpack configs
- [react-redux-universal-hot-example](https://github.com/erikras/react-redux-universal-hot-example) for the way to fetch the initial data
