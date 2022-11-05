class ApplicationController < Sinatra::Base
  set :default_content_type, "application/json"

  get '/' do
    { message: "Hello world" }.to_json
  end
  get "/games" do
    #get all games
    #return a json array of games as response
    Game.all.order(:title).to_json
  end

  get "/games/:id" do 
    #look up the game with :id in the db
    # return json response of game data
    game_id = params[:id]
    game = Game.find(game_id)
    game.to_json(only: [:id, :title, :genre, :price], include: {reviews:{only:[:comment, :score], include: {user:{only:[:name]}}}})
  end
end
