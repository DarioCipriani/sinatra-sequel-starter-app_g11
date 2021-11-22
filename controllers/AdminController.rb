#File: ./controllers/AdminController.rb
require 'sinatra/base'
require './services/AdminService.rb'
require 'sinatra/redirect_with_flash'

class AdminController < Sinatra::Base

  configure :development, :production do
  	set :views, './views'
  	set :public_dir, 'public'
  end
  
  post '/begin' do
    redirect '/surveys'
  end

 # este es el post para crear carrera
  post '/careers' do    
    AdminService.newCareer params[:name]
    redirect back        
  end

   # este es el post para crear carrera
  post '/careers/delete' do    
    AdminService.delete params[:name]
    redirect back        
  end
  
  # este es el get para mostrar las carreras
  get '/careers' do
    @careers = Career.all
    erb :careers_index
  end

  # este es el get para mostrar la Busqueda
  get '/search' do
    @careers = Career.all
    erb :search_index
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

  # este es el get para mostrar los resultados finales
  get '/finish_search/' do
    @fecha_d = params[:fecha_d]
    @fecha_h = params[:fecha_h]
    @career = params[:career]
    @salida = params[:salida]
    erb :searchP
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
