
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
  @tracks = Track.all_ordered_by_likes
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
    user_id: session[:user]
    )
  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end

get '/tracks/upvote/:id' do
  if logged_in && current_user.upvotes.where(track_id: params[:id]).empty?
    @upvote = Upvote.new
    @upvote.user = current_user
    @upvote.track = Track.find(params[:id])
    @upvote.save!
  end
end

get '/tracks/downvote/:id' do
  if logged_in
    upvote = Upvote.find_by(track_id: params[:id], user_id: session[:user])
    upvote.destroy if upvote
  end
end

get '/tracks/:id' do
  @track = Track.find_by(id: params[:id])
  if @track
    @reviews = @track.reviews
    @review = Review.new
    erb :'tracks/show'
  else
    redirect '/tracks'
  end
end

post '/tracks/reviews/:id' do
  @review = Review.new(
    content: params[:content],
    user_id: session[:user],
    track_id: params[:id],
    rating: params[:rating]
    )
  if @review.save
    redirect '/tracks/' + params[:id]
  else
    @track = Track.find_by(id: params[:id])
    if @track
      @reviews = @track.reviews
      erb :'tracks/show'
    else
      redirect '/tracks'
    end
  end
end

get '/reviews/delete/:id' do
  review = Review.find_by(user_id: session[:user], track_id: params[:id])
  if review.destroy
    session[:flash] = "Review deleted!"
  else
    session[:flash] = "Couldn't delete your review, sorry."
  end
  redirect '/tracks/' + params[:id]
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
      # must evaluate in this order for password hash
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








