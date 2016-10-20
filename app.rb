require "sinatra"
require "sinatra/activerecord"
require 'sinatra/contrib'
require "./models"
require 'json'
require "sinatra/flash"
require "./directory"

enable :sessions
set :database, "sqlite3:userdb.sqlite3"

def current_user
    if session[:user_id]
        @current_user = User.find(session[:user_id])
    end
end

before do 
	@users = User.all
	@posts = Post.all
end

# POST STUFF
# SIGNUP
post '/register' do 
    @user = User.create(fname: params["fname"], lname: params["lname"], email: params["email"], bio: params["bio"], password: params["password"], dob: params["dob"], lastOn: params["lastOn"], admin: false, picture: params["picture"]);
end


post '/edit' do

	if params["email"] != nil
    	User.update(session[:id], email: params["email"]);
    end
    if params["fname"] != nil
    	User.update(session[:id], email: params["fname"]);
    end
    if params["lname"] != nil
    	User.update(session[:id], email: params["lname"]);
    end
    if params["bio"] != nil
    	User.update(session[:id], email: params["bio"]);
    end
    if params["password"] != nil
    	User.update(session[:id], email: params["password"]);
    end
    if params["dob"] != nil
    	User.update(session[:id], email: params["dob"]);
    end
    if params["picture"] != nil
    	User.update(session[:id], email: params["picture"]);
    end
    if params["email"] != nil
    	User.update(session[:id], email: params["email"]);
    end
#    @user = User.save(fname: params["fname"], lname: params["lname"], email: params["email"], bio: params["bio"], password: params["password"], dob: params["dob"], lastOn: params["lastOn"], admin: false, picture: params["picture"]);
end

post '/posts' do
	@post = Post.create(username: session[:id], post: params["posting"], timestamp: Time.now.to_s(:military))
end

# LOGIN
post '/signin' do
	if User.exists?(password: params[:password]) && User.exists?(email: params[:email])
		# pass and username exit
		@user = User.find_by(email: params["email"], password: params["password"])
		session[:id] = @user.id;
		return "good";
	else
		# Could not find username or password
		return nil;
	end
end

get '/posts' do
    @mainERB = :posts_test
    erb :layout
end

post '/posts' do
    @mainERB = :posts_test
end

post '/getuserinfo' do
    User.find(session[:id]).to_json
end