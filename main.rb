require 'sinatra'
require 'shotgun'
require 'slim'
require 'sass'
require './song'
require 'v8'
require 'coffee-script'

configure do 
	enable :sessions
	set :username, 'frank'
	set :password, 'sinatra'
end

helpers do
  def css(*stylesheets)
    stylesheets.map do |stylesheet|
    "<link href=\"/#{stylesheet}.css\" media=\"screen, projection\" rel=\"stylesheet\" />"
    end.join
  end

  def set_title
  	@title ||= "Songs by Sinatra"
  end
end

before do
    set_title
end

get('/styles.css'){ scss :styles }
get('/javascripts/application.js'){ coffee :application }


get '/login' do 
	slim :login
end


post 'login' do 
	if params[:username] == settings.username && params[:password] == settings.password
		session[:admin] = true
		redirect to('/songs')
	else
		slim :login
	end
end


get '/logout' do 
	session.clear
	redirect to('/login')
end


get '/' do
    slim :home
end


get '/about' do
	@title = "All About This Website"
    slim :about
end


get '/contact' do
    slim :contact
end


not_found do 
	slim :not_found
end


