#Limpiar base de datos
Survey.all.map { |s| s.destroy }
Career.all.map { |c| c.destroy }
Choice.all.map { |ch| ch.destroy }
Question.all.map { |q| q.destroy }
Response.all.map { |r| r.destroy }
Outcome.all.map { |o| o.destroy }


# crear carreras
c1 = Career.create(name:'Agronomia', full_description:'')
c2 = Career.create(name:'Arquitectura', full_description:'')
c3 = Career.create(name:'Arte', full_description:'')
c4 = Career.create(name:'Computación', full_description:'')
c5 = Career.create(name:'Economía', full_description:'')
c6 = Career.create(name:'Educación física', full_description:'')
c7 = Career.create(name:'Filosofía', full_description:'')
c8 = Career.create(name:'Física', full_description:'')
c9 = Career.create(name:'Geología', full_description:'')
c10 = Career.create(name:'Historia', full_description:'')
c11 = Career.create(name:'Literaruta', full_description:'')
c12 = Career.create(name:'Matemáticas', full_description:'')
c13 = Career.create(name:'Medicina', full_description:'')
c14 = Career.create(name:'Periodismo', full_description:'')
c15 = Career.create(name:'Química', full_description:'')
c16 = Career.create(name:'Sociología', full_description:'')
c17 = Career.create(name:'Veterinaria', full_description:'')


# crear surveys
Survey.create(username:'Pepito', career_id:c1.id)

# crear preguntas
q1 = Question.create(name:'Me trasladaría a una zona agrícola - ganadera para ejercer mi profesión.', number:1, type:'SI/NO', description:'1')
q2 = Question.create(name:'Tengo buena memoria y no me cuesta estudiar y retener fórmulas y palabras técnicas.', number:2, type:'SI/NO', description:'2')
q3 = Question.create(name:'Me gusta escribir. En general mis trabajos son largos y están bien organizados.', number:3, type:'SI/NO', description:'3')
q4 = Question.create(name:'Sé quien es Steven Hawking: Conozco y me atraen sus descubrimientos.', number:4, type:'SI/NO', description:'4')
q5 = Question.create(name:'Me actualizo respecto de los avances tecnológicos y me intereso por investigar y conocer', number:5, type:'SI/NO', description:'5')
q6 = Question.create(name:'Sé quien es Andy Warhol y a qué movimiento artístico pertenece. Me apasiona conocer acerca del arte y sus exponentes.', number:6, type:'SI/NO', description:'6')
q7 = Question.create(name:'En general me intereso por las dificultades que ha tenido que atravesar la humanidad y cómo lo ha superado.', number:7, type:'SI/NO', description:'7')
q8 = Question.create(name:'Me apasiona leer y no me importa si el libro que elijo tiene muchas páginas, para mí es un gran entretenimiento.', number:8, type:'SI/NO', description:'8')
q9 = Question.create(name:'Me atrae conocer los procesos y las áreas que hacen funcionar a las empresas.', number:9, type:'SI/NO', description:'9')
q10 = Question.create(name:'Me siento identificado con el pensamiento de algunos filósofos y escritores.', number:10, type:'SI/NO', description:'10')
q11 = Question.create(name:'Me encanta estudiar el cuerpo humano y conocer cómo funciona. Además, no me impresiona la sangre.', number:11, type:'SI/NO', description:'11')
q12 = Question.create(name:'Si pudiera elegir, pasaría mucho tiempo diseñando novedosos objetos o edificios en mi computadora.', number:12, type:'SI/NO', description:'12')
q13 = Question.create(name:'Si mi blog fuera temático, trataría acerca de: <br>
  1. La importancia de la expresión artística en el desarrollo de la identidad de los pueblos.<br>
  2. La arquelogía urbana como forma de aprender acerca de la historia cultural de una ciudad.<br>
  3. La tecnología satelital en un proyecto para descubrir actividad volcánica para prevenir catástrofes climáticas.<br>
  4. Ninguna de las opciones.', number:13, type:'1/2/3/4', description:'13')
q14 = Question.create(name:'Integraría un equipo de trabajo encargado de producir un audiovisual sobre:<br>
1. La práctica de deportes y su influencia positiva en el estado de ánimo de las personas.<br>
2. Los pensadores del siglo XX y su aporte a la gestión de las organizaciones.<br>
3 Las mascotas y su incidencia en la calidad de vida de las personas no videntes.<br>
4 El uso de la PC como herramienta para el control de los procesos industriales.<br>
5 Procesos productivos de una empresa<br>
6 Ninguna de las opciones.', number:14, type:'1/2/3/4/5/6', description:'14')
q15 = Question.create(name:'Sería importante destacarme como:<br>
1. Director de una investigación técnico científica<br>
2. Gerente general de una empresa reconocida por su responsabilidad social.<br>
3 Un deportista famoso por su destreza física y su ética profesional.<br>
4 Experto en la detección precoz de enfermedades neurológicas en niños.<br>
5 Un agente de prensa audaz, número uno en el ranking de notas a celebridades.<br>
6 Ninguna de las opciones.', number:15, type:'1/2/3/4/5/6', description:'15')


## crear choices
ch1 = Choice.create(text:'SI', question_id:q1.id)
ch2 = Choice.create(text:'NO', question_id:q1.id)
ch3 = Choice.create(text:'SI', question_id:q2.id)
ch4 = Choice.create(text:'NO', question_id:q2.id)
ch5 = Choice.create(text:'SI', question_id:q3.id)
ch6 = Choice.create(text:'NO', question_id:q3.id)
ch7 = Choice.create(text:'SI', question_id:q4.id)
ch8 = Choice.create(text:'NO', question_id:q4.id)
ch9 = Choice.create(text:'SI', question_id:q5.id)
ch10 = Choice.create(text:'NO', question_id:q5.id)
ch11 = Choice.create(text:'SI', question_id:q6.id)
ch12 = Choice.create(text:'NO', question_id:q6.id)
ch13 = Choice.create(text:'SI', question_id:q7.id)
ch14 = Choice.create(text:'NO', question_id:q7.id)
ch15 = Choice.create(text:'SI', question_id:q8.id)
ch16 = Choice.create(text:'NO', question_id:q8.id)
ch17 = Choice.create(text:'SI', question_id:q9.id)
ch18 = Choice.create(text:'NO', question_id:q9.id)
ch19 = Choice.create(text:'SI', question_id:q10.id)
ch20 = Choice.create(text:'NO', question_id:q10.id)
ch21 = Choice.create(text:'SI', question_id:q11.id)
ch22 = Choice.create(text:'NO', question_id:q11.id)
ch23 = Choice.create(text:'SI', question_id:q12.id)
ch24 = Choice.create(text:'NO', question_id:q12.id)
ch25 = Choice.create(text:'1', question_id:q13.id)
ch26 = Choice.create(text:'2', question_id:q13.id)
ch27 = Choice.create(text:'3', question_id:q13.id)
ch28 = Choice.create(text:'4', question_id:q13.id)
ch29 = Choice.create(text:'1', question_id:q14.id)
ch30 = Choice.create(text:'2', question_id:q14.id)
ch31 = Choice.create(text:'3', question_id:q14.id)
ch32 = Choice.create(text:'4', question_id:q14.id)
ch33 = Choice.create(text:'5', question_id:q14.id)
ch34 = Choice.create(text:'6', question_id:q14.id)
ch35 = Choice.create(text:'1', question_id:q15.id)
ch35 = Choice.create(text:'2', question_id:q15.id)
ch35 = Choice.create(text:'3', question_id:q15.id)
ch35 = Choice.create(text:'4', question_id:q15.id)
ch35 = Choice.create(text:'5', question_id:q15.id)
ch35 = Choice.create(text:'6', question_id:q15.id)
