# Smood it example app

This is an example app built using the **[Smood it Ruby gem](https://github.com/potomak/smoodit)**.

## How to

### Configure app

Register a new client app here [http://smood.it/oauth_clients/new](http://smood.it/oauth_clients/new).

Set `CLIENT_TOKEN` and `CLIENT_SECRET` environment variables with your app consumer **token** and **secret**.

#### Local setup

    $ export CLIENT_TOKEN=my_token
    $ export CLIENT_SECRET=my_secret

#### Remote setup

    $ cd myapp
    $ heroku config:add CLIENT_TOKEN=my_token CLIENT_SECRET=my_secret

### Start server

    $ cd myapp
    $ rackup

Now go to [http://localhost:9292](http://localhost:9292).

### Deploy application

    $ cd myappp
    $ heroku create myapp
    $ git push heroku master

Now go to [http://myapp.heroku.com](http://myapp.heroku.com).