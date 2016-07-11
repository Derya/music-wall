# Homepage (Root path)
get '/' do
  erb :'index'
end

get '/tracks' do
  @tracks = Track.all
  erb :'tracks/index'
end

get '/tracks/new' do
  erb :'tracks/new'
end

post '/tracks' do
  @track = Track.new(
    title: params[:title],
    author: params[:author],
    picture_url: params[:picture_url],
    song_url: params[:song_url]
    )
  @track.save
  redirect '/tracks'
end