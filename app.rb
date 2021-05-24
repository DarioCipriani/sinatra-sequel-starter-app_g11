require './models/init.rb'

class App < Sinatra::Base
  get '/' do
    erb :landing
  end

  get "/hello/:name" do
   @name = params[:name]
   erb :hello_template
  end

  #este es el post para crear carrera
  post "/careers" do
    career = Career.new(name: params[:name])

    if career.save
      [201, { 'location' => "careers/#{career.id}" }, 'CREATED']
    else
      [500, {}, 'Internal Server Error']
    end
  end

  #este es el get para mostrar las carreras
  get "/careers" do
    @careers = Career.all

    erb :careers_index
  end

  #este es el get para mostrar las carreras con la descripciond de cada una
  get "/careers/:id" do
    career = Career.where(id: params['id']).last
    "<h1> Resumen de la carrera #{career.name}</h1>" +
    "<ul>" +
    "<li> id: #{career.id}" +
    "<li> name: #{career.name}" +
    "<li> surveys count: #{career.surveys.count}" +
    "</ul>"
  end

  post "/surveys" do
    data = JSON.parse request.body.read
    survey = Survey.new(username: data['username'], career_id: data['career_id'])

    if survey.save
      [201, { 'location' => "surveys/#{survey.id}" }, 'CREATED']
    else
      [500, {}, 'Internal Server Error']
    end
  end

  post "/responses" do
    data = JSON.parse request.body.read
    response = Response.new(question_id: data['question_id'], choise_id: data['choise_id'], survey_id: data['survey_id'])

    if response.save
      [201, { 'location' => "responses/#{response.id}" }, 'CREATED']
    else
      [500, {}, 'Internal Server Error']
    end
  end

  post "/outcomes" do
    data = JSON.parse request.body.read
    outcome = Outcome.new(career_id: data['career_id'], choise_id: data['choise_id'])

    if outcome.save
      [201, { 'location' => "outcomes/#{outcome.id}" }, 'CREATED']
    else
      [500, {}, 'Internal Server Error']
    end
  end

  post "/questions" do
    data = JSON.parse request.body.read
    question = Question.new(name: data['name'], description: data['description'], number: data['number'], type: date['type'])

    if question.save
      [201, { 'location' => "questions/#{question.id}" }, 'CREATED']
    else
      [500, {}, 'Internal Server Error']
    end
  end

  post "/choises" do
    data = JSON.parse request.body.read
    choise = Choise.new(text: data['text'], question_id: data['question_id'])

    if choise.save
      [201, { 'location' => "choises/#{choise.id}" }, 'CREATED']
    else
      [500, {}, 'Internal Server Error']
    end
  end

  post "/posts" do
    request.body.rewind  # in case someone already read it
    data = JSON.parse request.body.read
    post = Post.new(description: data['desc'])
    if post.save
      [201, { 'Location' => "posts/#{post.id}" }, 'CREATED']
    else
      [500, {}, 'Internal Server Error']
    end
  end

  get '/posts' do
    p = Post.where(id: 1).last
    p.description
  end
end

