require 'httparty'
class EventbriteClient
  include HTTParty
  base_uri 'https://www.eventbrite.com'

  def initialize( auth_tokens )
    @auth = {}
    @data_type = (auth_tokens.is_a?(Hash) and auth_tokens.include? :data_type) ? auth_tokens[:data_type] : 'json'
    if auth_tokens.is_a? Hash
      if auth_tokens.include? :access_token
        # use oauth2 authentication tokens
        self.class.headers 'Authorization' => "Bearer #{auth_tokens[:access_token]}"
      elsif auth_tokens.include? :app_key
        #use api_key OR api_key + user_key OR api_key+email+pass
        if auth_tokens.include? :user_key
          # read/write access on the user account associated with :user_key
          @auth = {:app_key => auth_tokens[:app_key], :user_key => auth_tokens[:user_key]}
        elsif auth_tokens.include?(:user) && auth_tokens.include?(:password)
          # read/write access on the user account matching this login info 
          @auth = {:app_key => auth_tokens[:app_key], :user => auth_tokens[:user], :password => auth_tokens[:password]}
        else
          # read-only access to public data
          @auth = {:app_key => auth_tokens[:app_key]}
        end
      end 
    end
  end

  # available API request methods are documented at:
  # http://developer.eventbrite.com/doc
  def method_request( method, params )
    #merge auth params into our request querystring
    querystring = @auth.merge( params.is_a?(Hash) ? params : {} )
    resp = self.class.get("/#{@data_type}/#{method.to_s}",{:query => querystring})
    if resp['error'] 
      raise RuntimeError, resp['error']['error_message'], caller[1..-1]
    end
    return resp
  end

  def method_missing(method, *args, &block)
    self.method_request(method, args[0])
  end
end

class EventbriteWidgets
  def self.ticketWidget(evnt)
    "<div style='width:100%; text-align:left;' ><iframe src='http://www.eventbrite.com/tickets-external?eid=#{ evnt["id"]}&ref=etckt' frameborder='0' height='192' width='100%' vspace='0' hspace='0' marginheight='5' marginwidth='5' scrolling='auto' allowtransparency='true'></iframe><div style='font-family:Helvetica, Arial; font-size:10px; padding:5px 0 5px; margin:2px; width:100%; text-align:left;'><a style='color:#ddd; text-decoration:none;' target='_blank' href='http://www.eventbrite.com/r/etckt'>Online Ticketing</a><span style='color:#ddd;'> for </span><a style='color:#ddd; text-decoration:none;' target='_blank' href='http://www.eventbrite.com/event/#{evnt["id"]}?ref=etckt'>#{evnt["title"]}</a><span style='color:#ddd;'> powered by </span><a style='color:#ddd; text-decoration:none;' target='_blank' href='http://www.eventbrite.com?ref=etckt'>Eventbrite</a></div></div>"
  end

  def self.registrationWidget(evnt)
    "<div style='width:100%; text-align:left;'><iframe src='http://www.eventbrite.com/event/#{evnt['id']}?ref=eweb' frameborder='0' height='1000' width='100%' vspace='0' hspace='0' marginheight='5' marginwidth='5' scrolling='auto' allowtransparency='true'></iframe><div style='font-family:Helvetica, Arial; font-size:10px; padding:5px 0 5px; margin:2px; width:100%; text-align:left;'><a style='color:#ddd; text-decoration:none;' target='_blank' href='http://www.eventbrite.com/r/eweb'>Online Ticketing</a><span style='color:#ddd;'> for </span><a style='color:#ddd; text-decoration:none;' target='_blank' href='http://www.eventbrite.com/event/#{evnt['id']}?ref=eweb'>#{evnt['title']}</a><span style='color:#ddd;'> powered by </span><a style='color:#ddd; text-decoration:none;' target='_blank' href='http://www.eventbrite.com?ref=eweb'>Eventbrite</a></div></div>"
  end

  def self.calendarWidget(evnt)
    "<div style='width:195px; text-align:center;'><iframe src='http://www.eventbrite.com/calendar-widget?eid=#{evnt['id']}' frameborder='0' height='382' width='195' marginheight='0' marginwidth='0' scrolling='no' allowtransparency='true'></iframe><div style='font-family:Helvetica, Arial; font-size:10px; padding:5px 0 5px; margin:2px; width:195px; text-align:center;'><a style='color:#ddd; text-decoration:none;' target='_blank' href='http://www.eventbrite.com/r/ecal'>Online event registration</a><span style='color:#ddd;'> powered by </span><a style='color:#ddd; text-decoration:none;' target='_blank' href='http://www.eventbrite.com?ref=ecal'>Eventbrite</a></div></div>"
  end

  def self.countdownWidget(evnt)
    "<div style='width:195px; text-align:center;'><iframe src='http://www.eventbrite.com/countdown-widget?eid=#{evnt['id']}' frameborder='0' height='479' width='195' marginheight='0' marginwidth='0' scrolling='no' allowtransparency='true'></iframe><div style='font-family:Helvetica, Arial; font-size:10px; padding:5px 0 5px; margin:2px; width:195px; text-align:center;'><a style='color:#ddd; text-decoration:none;' target='_blank' href='http://www.eventbrite.com/r/ecount'>Online event registration</a><span style='color:#ddd;'> for </span><a style='color:#ddd; text-decoration:none;' target='_blank' href='http://www.eventbrite.com/event/#{evnt['id']}?ref=ecount'>#{evnt['title']}</a></div></div>"
  end

  def self.buttonWidget(evnt)
    "<a href='http://www.eventbrite.com/event/#{evnt['id']}?ref=ebtn' target='_blank'><img border='0' src='http://www.eventbrite.com/custombutton?eid=#{evnt['id']}' alt='Register for #{evnt['title']} on Eventbrite' /></a>"
  end

  def self.linkWidget(evnt, text=nil, color='#000000')
    "<a href='http://www.eventbrite.com/event/#{evnt["id"]}?ref=elink' target='_blank' style='color:#{color};'>#{text || evnt['title']}</a>"
  end
end
