

enable :sessions

helpers do 
  def current_user
    if session[:user]
      User.find(session[:user])
    end
  end
end

# Homepage (Root path)
get '/', '/index' do
  erb :'index'
end

get '/tracks' do
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
  @track = Track.find params[:id]
  erb :'tracks/show'
end

get '/users/logout' do
  session[:user] = nil
  redirect '/tracks'
end

post '/users/login' do
  @user = User.where(username: params[:username], password: params[:password])
  unless @user.empty?
    session[:user] = @user.first.id
  else

  end
  redirect '/tracks'
end

post '/users/register' do
  @new_user = User.new(
    username: params[:username],
    email: params[:email],
    password: params[:password],
    )
  if @new_user.save

  else

  end
  redirect '/tracks'
end

get '/users/:id' do
  @user = User.find params[:id]
  erb :'users/show'
end










