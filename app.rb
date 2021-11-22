require './controllers/AdminController.rb'
require './controllers/SurveyController.rb'

# programa principal
class App < Sinatra::Base

  configure do
  	set :views, "./views"
  	set :public_dir, "public"
  end

  use AdminController
  use SurveyController
  
  get '/' do
    erb :landing
  end

end
