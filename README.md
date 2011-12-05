#eventbrite-client.rb#

##Description##
A tiny ruby-based http client for the Eventbrite API

For the latest information on this project, take a look at:

* [This project's source code repo](http://github.com/eventbrite/eventbrite-client.rb/)
* [The Eventbrite API documentation](http://developer.eventbrite.com/doc/)

##Usage Examples##

###Installation via rubygems ###

    gem install eventbrite-client

###Loading the Eventbrite API Client library code###

    require 'eventbrite-client'

###Initializing the client###
Your API / Application key is required to initialize the client - http://eventbrite.com/api/key

Set your user_key if you want to access private data - http://eventbrite.com/userkeyapi

    eb_auth_tokens = { app_key:  'YOUR_APP_KEY',
                       user_key: 'YOUR_USER_KEY'}
    eb_client = EventbriteClient.new(eb_auth_tokens)

###Initializing the client using an OAuth2.0 access_token###
You can also initialize our API client using an OAuth2.0 `access_token`, like this:

    eb_client = EventbriteClient.new({access_token: 'YOUR_USER_ACCESS_TOKEN'})

###Calling API methods###
See [Eventbrite's API method documentation](http://developer.eventbrite.com/doc/) for more information about the list of available client methods.

Here is an example using the API's [user_list_events](http://developer.eventbrite.com/doc/users/user_list_events/) method:

    response = eb_client.user_list_events()

The [event_get](http://developer.eventbrite.com/doc/events/event_get/) API call should look like this:

    response = eb_client.event_get({id: 1848891083})

### Widgets ###
Rendering an event in html as a [ticketWidget](http://www.eventbrite.com/t/how-to-use-ticket-widget) is easy:

    response = eb_client.event_get({id: 1848891083})
    widget_html = EventbriteWidgets::ticketWidget(response['event'])

##Resources##
* API Documentation - <http://developer.eventbrite.com/doc/>
* API QuickStart Guide - <http://developer.eventbrite.com/doc/getting-started/>
* Eventbrite Open Source - <http://eventbrite.github.com/>
* Eventbrite App Showcase - <http://eventbrite.appstores.com/>
* 0.3x source - <http://github.com/eventbrite/eventbrite-client-py/>
* 0.2x source - <http://github.com/mtai/eventbrite/>
