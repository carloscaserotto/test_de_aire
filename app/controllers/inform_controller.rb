class InformController < ApplicationController
    skip_before_action :verify_authenticity_token  

    def create
        #byebug
        @patient = Patient.find(params[:id])
        @date = Date.today.to_s 
        @tests = Tda.all()
    end

    def show_table
        #byebug
        @minutos = params[:datos].split(",").map(&:to_i)
        @medico_solicitante = params[:solicitante]
        @comentario = params[:comentario]
        if request.xhr?
            respond_to do |format|
                format.js {render partial: 'inform/result'}
            end
        end
    end
    def show_chart
        #byebug
        @minutos = params[:minutos].split(",").map(&:to_i)
        @ppmh2 = params[:ppmh2].split(",").map(&:to_i)
        if request.xhr?
            respond_to do |format|
                format.js {render partial: 'inform/chart'}
            end
        end
    end

    def pdf
        #byebug
        
        
        @user = current_user
        @user.avatar.attach(data: params[:imagen])
        @minutos = params[:minutos].split(',').reject(&:empty?).map(&:to_i)
        @datos = params[:ppmh2].split(',').reject(&:empty?).map(&:to_i)
    
        @logo = "#{Rails.root}/app/assets/images/vilella.png"
        @firma = "#{Rails.root}/app/assets/images/firma.png"
        @date = Date.today.to_s
        @titulo = "TEST DE H2 EN AIRE ESPIRADO"
        @sustrato = params[:sustrato] #"Fructuosa 25gr"
        @paciente= params[:paciente] #"Carolina"
        @cobertura_medica = params[:cobertura_medica] #"OSDE310"
        @medico_requirio_estudio= params[:medico_solicitante] #"Lubrano, Pablo"
        @medico_reviso_estudio= current_user.name #params[:medico_revisor] #"Dorribo"
        @especialidad = params[:especialidad_medica] #"Medica Esp. Gastroenterologia"
        @mn = current_user.mn #params[:matricula_medica] #"136971"
        @conclusiones = params[:comentario] #"Perfil fermentativo normal"
        @footer = "Av. de los Incas 3536 | Belgrano R | CABA | Turnos: 4117 8000 | info@vilella.com.ar | www.vilella.com |"
    
        pdf = Prawn::Document.new
        pdf.image @logo, fit: [80,80],at: [460, 715] 
        pdf.move_down 50
        pdf.stroke_horizontal_rule
        pdf.move_down 30
        pdf.draw_text "Fecha: #{@date}", at: [460, 630], size: 10
        pdf.move_cursor_to 650
        pdf.text "#{@titulo}", size: 15, style: :bold, align: :center
        pdf.draw_text "Sustrato:", at: [0, 600], size: 12, style: :bold
        pdf.draw_text "#{@sustrato}", at: [185, 600], size: 10, style: :bold
        pdf.draw_text "Paciente:", at: [0, 580], size: 12, style: :bold
        pdf.draw_text "#{@paciente}", at: [185, 580], size: 10
        pdf.draw_text "Cobertura Medica:", at: [0, 560], size: 12, style: :bold
        pdf.draw_text "#{@cobertura_medica}", at: [185, 560], size: 10
        pdf.draw_text "Medico:", at: [0, 540], size: 12, style: :bold
        pdf.draw_text "Dr./Dra.#{@medico_requirio_estudio}", at: [185, 540], size: 10
        
        pdf.draw_text "Previa obtencion de muestra basal de H2 espirado, se administraron 25 gr de sustrato diluidos en 240 ml de agua con" , at: [0, 520], size: 10 
        pdf.draw_text "posterior toma de  muestras cada 15 min por periodo de de 2 horas", at: [0, 510], size: 10
        pdf.draw_text "Se considera positivo para malaabsorcion de lactosa un aumento de >20 ppm respecto de la medicion basal e intolerancia ", at: [0, 500], size: 10
        pdf.draw_text "si el paciete presento, ademas, sintomas asociados.", at: [0, 490], size: 10
        
        imagen_reporte = StringIO.open(@user.avatar.download)
        pdf.image imagen_reporte, fit: [400,400],at: [120, 470] 
        
        #data = [ %w[Minuto PPM_H2 ],
        #         ["#{@minutos[0]}", "#{@datos[0]}"],
        #         ["#{@minutos[1]}", "#{@datos[1]}"],
        #         ["#{@minutos[2]}", "#{@datos[2]}"],
        #         ["#{@minutos[3]}", "#{@datos[3]}"],
        #         ["#{@minutos[4]}", "#{@datos[4]}"],
        #         ["#{@minutos[5]}", "#{@datos[5]}"],
        #         ["#{@minutos[6]}", "#{@datos[6]}"],
        #         ["#{@minutos[7]}", "#{@datos[7]}"],
        #         ["#{@minutos[8]}", "#{@datos[8]}"],
        #         ["#{@minutos[9]}", "#{@datos[9]}"],
        #        ]
        
      
      


        #:row_colors => ["F0F0F0",nil,"F0F0F0",nil],
      
        pdf.move_cursor_to 460
      #  pdf.table(data, :column_widths => {0 => 35, 1 => 40}, 
      #                  :cell_style => { :font => "Times-Roman", :size => 8,:align => :center })
        pdf.table([%w[Minuto PPM_H2]], :column_widths => {0 => 35, 1 => 40},
                                       :cell_style => { :font => "Times-Roman", 
                                       :size => 8,:align => :center })
        @minutos.each_with_index do |m,i|
            pdf.table([["#{m}","#{@datos[i]}"]], :column_widths => {0 => 35, 1 => 40},
                                                 :cell_style => { :font => "Times-Roman", 
                                                 :size => 8,:align => :center })
        end   
        pdf.move_down 50
         
        pdf.draw_text "Conclusiones:", at: [0, 215], size: 12, style: :bold
        pdf.move_cursor_to 200
        pdf.text "#{@conclusiones}", size: 12, style: :bold, align: :center
                  
        pdf.image @firma, fit: [85,85], at: [400, 130]           
        pdf.draw_text "Dr./Dra.#{@medico_reviso_estudio}", at: [400, 70], size: 10
        pdf.draw_text "#{@especialidad}", at: [400, 60], size: 10
        pdf.draw_text "MN #{@mn}", at: [400, 50], size: 10
        
        pdf.move_cursor_to 30
        pdf.stroke_horizontal_rule
        pdf.draw_text "#{@footer}", at: [20, 0], size: 10
              
        send_data(pdf.render,
            filename: "pruebas.pdf",
            type: 'application/pdf',
            disposition: 'inline',
        )
      end
            
end