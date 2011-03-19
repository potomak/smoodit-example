require 'rubygems'
require 'sinatra'
require 'haml'
require 'smoodit'
require 'oauth'

enable :sessions

CLIENT_TOKEN = ENV['CLIENT_TOKEN']
CLIENT_SECRET = ENV['CLIENT_SECRET']

def consumer
  OAuth::Consumer.new(CLIENT_TOKEN, CLIENT_SECRET, {:site => "http://smood.it"})
end

def setup_client
  Smoodit.configure do |config|
    config.consumer_key = CLIENT_TOKEN
    config.consumer_secret = CLIENT_SECRET
    config.oauth_token = session[:token]
    config.oauth_token_secret = session[:secret]
  end
end

get "/" do
  unless session[:token].nil?
    setup_client

    Smoodit.profile do |me|
      @user = me
    end
  end

  haml :index
end

get "/oauth/connect" do
  request_token = consumer.get_request_token
  session[request_token.token] = request_token.secret
  
  redirect request_token.authorize_url
end

get "/oauth/callback" do
  request_token = OAuth::RequestToken.new(consumer, params[:oauth_token], session[params[:oauth_token]])
  access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  session[:token] = access_token.token
  session[:secret] = access_token.secret

  redirect "/"
end

get "/current_smood" do
  setup_client
  
  Smoodit.profile.smoods do |data|
    @smood = data.smoods[0] if data.smoods.size > 0
  end
  
  haml :current_smood, :layout => false
end

get "/logout" do
  session.delete(:token)
  
  redirect "/"
end