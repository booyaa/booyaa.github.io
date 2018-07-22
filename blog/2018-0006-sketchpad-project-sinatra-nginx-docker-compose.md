permalink: "/2018/sketchpad-project-sinatra-nginx-docker-compose"
title: "A sketchpad project based on Sinatra, Nginx using docker-compose"
categories:
  - "sinatra,nginx,docker-compose"
published_date: "2018-07-22 18:00:01 +0000"
layout: post.liquid
is_draft: false
data:
  route: blog
  tags: "sinatra,nginx,docker-compose"
---
I recently came across a monolithic application at work that used various frameworks which in turn made extending existing routes very difficult to implement.

The general consensus amongst my peers was to stick a proxy in front of the app. The only decision left, was to determine if we could do this using the existing reverse proxy ([Nginx][link_nginx]) or write a bespoke proxy (between Nginx and the existing monolith).

The problem, was to take a value in the URL and pass it on as a request parameter to the monolith.

An example incoming URL might look like this `/api/parp/foo`, we want this to be rewritten to the monolith as `/api/foo` and `parp` to be appended as `fart_noise=parp`. The only liberty I've taken, is that the value of `fart_noise` will always be `parp` in this scenario.

You can do this easily enough in nginx using [`proxy_set_body`][link_nginx_proxy_set].

In addition to this requirement, I needed to leave incoming URLs without `parp` as-is, because we expect the client to provide an alternative value for `fart_noise` i.e. `toot`.

To test this, I created a test server to simulate the monolith. [Sinatra][link_sinatra] is great for creating REST based APIs, I think it actually edges in over [Flask][link_flask] for simplicity. 

I used the [`namespace`][link_sinatra_namespace] directive to add prefix the end points with `/api`. I only needed to prove the rewrites would work for `GET` and `POST` methods, so I inspected the `params` variable as a way to echo back any form data I was sending.

```ruby
class MyWay < Sinatra::Base
  register Sinatra::Namespace
  namespace '/api' do
    get '/foo' do
      logger.info "api/foo parameters: #{params}"
      params.inspect
    end

    post '/bar' do
      logger.info "api/bar parameters: #{params}"
      params.inspect
    end
  end
end
```

The nginx config is a fairly standard reverse proxy setup. I made one modification creating two [location][link_nginx_location] blocks: one to handle the rewrite and appending a parameter to the request and the other are URLs that do not need modification.

```nginx
server {
    listen 80;
    location /api/parp { # fix parps
        rewrite (.*)/parp/(.*) /$1/$2 break;
        proxy_set_body $request_body&fart_noise=parp;
        # other proxy directives...
    }

    location /api { # leave as-is
        # other proxy directives...
    }
}
```

Obviously I didn't come up with this conclusion immediately, I needed some kind of sketchpad / scratch space to try out the various ideas for rewriting the requests. Enter `docker-compose`, a handy way to join a bunch of containers together without having brain meltdown from remembering the various incantations that are the individual docker commands.

Here's the `docker-compose.yml` I used:

```yaml
version: '3'
services:
  app:
    build: ./app
    command: ["bundle","exec","rackup","--host","0.0.0.0","--port","4567"]
    volumes:
      - ./app/:/app
  proxy:
    image: nginx
    command: ["nginx-debug", "-g", "daemon off;"]
    volumes:
      - ./proxy/nginx.conf:/etc/nginx/nginx.conf
    ports:
      - 8080:80
    depends_on:
      - app
```

The items you may find useful are:

- the `proxy` (Nginx) is dependant on `app` (Sinatra) starting up first 
- we're using `volumes` to get the nginx container to read our `nginx.conf`, removing the need for a pointless `Dockerfile` that copies this file.

You can see the whole project on [GitHub][link_github].

[link_nginx]: https://www.nginx.com/
[link_nginx_proxy_set]: http://nginx.org/en/docs/http/ngx_http_proxy_module.html#proxy_set_body
[link_nginx_location]: http://nginx.org/en/docs/http/ngx_http_core_module.html#location
[link_sinatra]: http://sinatrarb.com/
[link_sinatra_namespace]: http://sinatrarb.com/contrib/namespace.html
[link_flask]: http://flask.pocoo.org/
[link_github]: https://github.com/booyaa/singinx
