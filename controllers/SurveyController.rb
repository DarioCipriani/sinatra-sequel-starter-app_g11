require 'sinatra/base'
require './services/SurveyService'

class SurveyController < Sinatra::Base

  configure :development, :production do
  	set :views, './views'
  	set :public_dir, "public"
  end

    # este es el get para mostrar las surveys
  get '/surveys' do
    @questions = Question.all
    erb :surveys_index
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
      old_response.each do |o|
        o.destroy
      end
      s.destroy
    end
    # creo la encuesta con el usuario
    @survey = Survey.new(username: @username)
    @survey.save
    # guardo las respuestas del usuario
    SurveyService.create_responses(data['choices'], @survey.id)
    response = Response.where(survey_id: @survey.id)
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
      if(o && o.career_id)
        result[o.career_id] = result[o.career_id] + 1
      end
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


end
