require './models/init'

# programa principal
class App < Sinatra::Base
  get '/' do
    erb :landing
  end

  # este es el post para crear carrera
  post '/careers' do
    career = Career.new(name: params[:name])
    if career.save
      [201, { 'location' => "careers/#{career.id}" }, 'CREATED']
    else
      [500, {}, 'Internal Server Error']
    end
  end

  # este es el get para mostrar las carreras
  get '/careers' do
    @careers = Career.all
    erb :careers_index
  end

  # este es el get para mostrar las carreras con la descripcion de cada una
  get '/careers/:id' do
    career = Career.where(id: params['id']).last
    "<h1> Resumen de la carrera #{career.name}</h1>" \
      '<ul>' \
      "<li> id: #{career.id}" \
      "<li> name: #{career.name}" \
      "<li> surveys count: #{career.surveys.count}" \
      '</ul>'
  end

  post '/begin' do
    redirect '/surveys'
  end

  # cuando las preguntas fueron todas respondidas, el html
  # llama a este post para calcular el resultado final de la encuesta
  post '/finish_survey' do
    data = JSON.parse request.body.read
    # obtengo valor del usuario
    @username = data['username']
    # si existe alguna encuesta asociada a ese usuario la borramos
    old_survey = Survey.where(username: @username)
    old_survey.each do |s|
      old_response = Response.where(survey_id: s.id)
      old_response.destroy
      s.destroy
    end
    # creo la encuesta con el usuario
    @survey = Survey.new(username: @username)
    @survey.save
    # guardo las respuestas del usuario
    create_responses(data['choices'], @survey.id)
    response = Response.all
    # creo el arreglo de carreras que contendra los pesos
    result = {}
    ## inicializando arreglo de carreras y pesos
    arreglo = Career.all
    arreglo.each do |s|
      result[s.id] = 0
    end
    # Por cada respuesta reviso en outcome con que carrera machea
    # y al arreglo de carreras incremento el peso de esa carrera en 1
    response.each do |r|
      o = Outcome.where(choice_id: r.choice_id).last
      result[o.career_id] = result[o.career_id] + 1 if o && o.career_id
    end
    # Obtengo el maximo del arreglo de carreras
    result_career = result.key(result.values.max)
    # busco ese id de carreras en la tabla de carrera y se lo asigno a una variable
    @career = Career.find(id: result_career)
    # actualizo el valor del registro de la encuesta con la carrera que gano
    @survey.update(career_id: @career.id)
    # llamo a la pagina html que me muestra la carrera ganadora
    redirect to "/finish/#{@survey.id}"
  end

  # con el id del survey ganador, obtenemos la carrera y con estos datos
  # llamamos a la ultima pagina con los datos ganadores
  get '/finish/:id' do
    @survey = Survey.find(id: params[:id])
    @career = Career.find(id: @survey.career_id)
    erb :finish
  end

  def create_responses(data, survey_id)
    data.each do |d|
      Response.create(choice_id: d['choiceId'], question_id: d['questionId'], survey_id: survey_id)
    end
  end

  # este es el get para mostrar las surveys
  get '/surveys' do
    @questions = Question.all
    erb :surveys_index
  end

  # este es el get para mostrar la Busqueda
  get '/search' do
    @careers = Career.all
    erb :search_index
  end

  # este es el get para mostrar los resultados finales
  get '/finish_search/' do
    @fecha_d = params[:fecha_d]
    @fecha_h = params[:fecha_h]
    @career = params[:career]
    @salida = params[:salida]
    erb :searchP
  end

  # este es el post para buscar
  post '/search' do
    result = 0
    data = JSON.parse request.body.read
    @fecha_d = data['fecha_d']
    @fecha_h = data['fecha_h']
    carrera = data['carrera']
    @career = Career.find(name: carrera)
    survey = Survey.where(career_id: @career.id)
    survey.each do |p|
      val = Date.parse(String(p.updated_at))
      # aqui debo comparar la fecha de actualizacion del registro con la fecha pasada como parametro
      if (val > DateTime.parse(@fecha_d) && val <= DateTime.parse(@fecha_h)) || (val >= DateTime.parse(@fecha_d) && val < DateTime.parse(@fecha_h)) || (val == Date.parse(@fecha_d) || val == Date.parse(@fecha_h))
        result += 1
      end
    end
    @salida = ' fue elegida ' + result.to_s + '  veces.'
    # redirige los resultados a una nueva pagina
    redirect to "/finish_search/?fecha_d=#{@fecha_d}&fecha_h=#{@fecha_h}&salida=#{@salida}&career=#{@career.name}"
  end

  # este es el post para crear las questions
  post '/questions' do
    question = Question.new(params[:question])
    question.save
    redirect '/questions'
  end

  # este es el get para mostrar las questions
  get '/questions' do
    @questions = Question.all
    erb :questions_index
  end

  # este es el get para mostrar las questions con la descripciond de cada una
  get '/questions/:id' do
    question = Question.where(id: params['id']).last
    "<h1> Lista de Preguntas #{question.name}</h1>" \
      '<ul>' \
      "<li> number: #{question.number}" \
      "<li> name: #{question.name}" \
      "<li> description: #{question.description}" \
      "<li> type: #{question.type}" \
      '</ul>'
  end
end
