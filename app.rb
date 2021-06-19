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

  #este es el get para mostrar las carreras con la descripcion de cada una
  get "/careers/:id" do
    career = Career.where(id: params['id']).last
    "<h1> Resumen de la carrera #{career.name}</h1>" +
    "<ul>" +
    "<li> id: #{career.id}" +
    "<li> name: #{career.name}" +
    "<li> surveys count: #{career.surveys.count}" +
    "</ul>"
  end

 post "/begin" do
    redirect '/surveys'
  end

  post "/finish_survey" do
    data = JSON.parse request.body.read
    # obtengo valor del usuario
    @username = data['username']
    # creo la encuesta con el usuario
    @survey = Survey.new(username: @username)
    @survey.save
    #guardo las respuestas del usuario
    createResponses(data['choices'],@survey.id)
    response = Response.all

    # creo el arreglo de carreras que contendra los pesos
    result = {}
    ## inicializando arreglo de carreras y pesos
    for career in Career.all
      result[career.id] = 0
    end
    # Por cada respuesta reviso en outcome con que carrera machea 
    # y al arreglo de carreras incremento el peso de esa carrera en 1
    response.each do |response|
      o = Outcome.where(choice_id: response.choice_id).last
      if(o && o.career_id)
        result[o.career_id] = result[o.career_id] + 1
      end
    end
    # Obtengo el maximo del arreglo de carreras
    resultCareer = result.key(result.values.max)
    #busco ese id de carreras en la tabla de carrera y se lo asigno a una variable
    @career = Career.find(id: resultCareer)
    # actualizo el valor del registro de la encuesta con la carrera que gano
    @survey.update(career_id: @career.id)
    #llamo a la pagina html que me muestra la carrera ganadora
     redirect to "/finish/#{@survey.id}"
  end

 get '/finish/:id' do
    @survey = Survey.find(id: params[:id])

   @career = Career.find(id: @survey.career_id)

   erb :finish
end

    def createResponses(data, survey_id)
      data.each do |data|
        Response.create(choice_id: data['choiceId'], question_id: data['questionId'], survey_id: survey_id)
      end
    end

      #este es el get para mostrar las surveys
  get "/surveys" do
    @questions = Question.all
    erb :surveys_index
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

   #este es el post para crear las questions
  post "/questions" do
    
    question = Question.new(params[:question])
    question.save
    redirect '/questions'
  end

    #este es el get para mostrar las questions
  get "/questions" do
    @questions = Question.all

    erb :questions_index
  end

  #este es el get para mostrar las questions con la descripciond de cada una
  get "/questions/:id" do
    question = Question.where(id: params['id']).last
    "<h1> Lista de Preguntas #{question.name}</h1>" +
    "<ul>" +
    "<li> number: #{question.number}" +
    "<li> name: #{question.name}" +
    "<li> description: #{question.description}" +
    "<li> type: #{question.type}" +
    "</ul>"
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

