require 'sinatra/base'
require './lib/message'

class MessageBoard < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'

  get '/' do
    session.clear
    redirect '/log'
  end

  get '/log' do
    session[:messages] ||= []
    @messages = session[:messages]
    erb :index
  end

  post '/message' do
    session[:messages] << Message.new(params[:message])
    redirect '/log'
  end

  run! if app_file == $0
end
