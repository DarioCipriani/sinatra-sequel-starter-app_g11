require './models/init.rb'

class App < Sinatra::Base
  get '/' do
    "Hello World"
  end

  get "/hello/:name" do
   @name = params[:name]
   erb :hello_template
  end

  post "/careers" do
    data = JSON.parse request.body.read
    career = Career.new(name: data['name'])

    if career.save
      [201, { 'location' => "careers/#{career.id}" }, 'CREATED']
    else
      [500, {}, 'Internal Server Error']
    end
  end

  post "/surveys" do
    data = JSON.parse request.body.read
    survey = Survey.new(username: data['username'])

    if survey.save
      [201, { 'location' => "surveys/#{survey.id}" }, 'CREATED']
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
    choise = Choise.new(text: data['text'])

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

