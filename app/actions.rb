
enable :sessions

# TODO: remove the thing that displays flashes, use popups instead or something

helpers do 
  def current_user
    if session[:user]
      User.find(session[:user])
    end
  end

  def logged_in
    current_user != nil
  end

  def username_by_id(id)
    user = User.find_by(id: id)
    if user
      user.username
    else
      "deleted"
    end
  end
end

get '/', '/index' do
  erb :'index'
end

get '/tracks', '/tracks/index' do
  @tracks = Track.all
  erb :'tracks/index'
end

get '/tracks/new' do
  @track = Track.new
  erb :'tracks/new'
end

post '/tracks' do
  @track = Track.new(
    title: params[:title],
    author: params[:author],
    picture_url: params[:picture_url],
    song_url: params[:song_url],
    user_id: session[:id]
    )
  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end

get '/tracks/:id' do
  @track = Track.find_by(id: params[:id])
  if @track #track id isnt bugged
    erb :'tracks/show'
  else #track id seems to be bugged, somehow
    #TODO: decide what functionality we want here
    erb :'tracks/show'
  end
end

get '/users/logout' do
  session[:flash] = "Logged out of #{username_by_id(session[:user])}"
  session[:user] = nil
  redirect '/tracks'
end

post '/users/login' do
  if params[:username].empty? || params[:password].empty?
    session[:flash] = "Empty login or password."
  else
    user = User.find_by(username: params[:username])
    if user # username exists in database
      if user.password == params[:password] # password valid
        session[:user] = user.id
        session[:flash] = "Logged in as #{params[:username]}"
      else #password invalid
        session[:flash] = "Invalid password"
      end
    else #username doesn't exist in database
      session[:flash] = "No user with username #{params[:username]}"
    end
  end
  redirect '/tracks'
end


post '/users/register' do

  @new_user = User.new(
    username: params[:username],
    email: params[:email]
    )
  @new_user.password = params[:password]
  if @new_user.save
    session[:flash] = "Account #{params[:username]} created!"
  else
    session[:flash] = "Errors for creation of account #{params[:username]}: "
    @new_user.errors.full_messages.each do |error_msg|
      session[:flash] = session[:flash] + error_msg + ", "
    end
    session[:flash] = session[:flash].chomp(", ")
  end
  redirect '/tracks'
end


get '/users/all' do
  erb :'users/all'
end

get '/users/:id' do
  @user = User.find params[:id]
  erb :'users/show'
end










