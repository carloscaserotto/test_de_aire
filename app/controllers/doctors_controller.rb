class DoctorsController < ApplicationController
    skip_before_action :verify_authenticity_token  

    def index
      @doctors = Doctor.all
    end

    def indexJson
        doctors = Doctor.all
        render json: doctors
    end
    def showJson
        #byebug
        doctor = Doctor.find_by(:name => params[:name])
        render json: doctor
    end
    def addDoctorJson
        #byebug
        if Doctor.find_by(:name => [doctor_params[:name]])
        #if Doctor.find(params[:id])
            doctor = Doctor.find_by(:name => [doctor_params[:name]])
        #    doctor = Doctor.find(params[:id])
            redirect_to "list/doctors/#{doctor.name}"
        else
            doctor = Doctor.create(doctor_params)
            doctor.save!
            render json: doctor
        end
    end
  
    def show
        @doctor = Doctor.find(params[:id])
    end
  
    def new
      @doctor = Doctor.new
    end
    def create
      #byebug
      @doctor = Doctor.new(doctor_params)
      if @doctor.save
        redirect_to @doctor
      else
        render 'new'
      end
    end
    def edit
      @doctor = Doctor.find(params[:id])
    end
    def update
      @doctor = Doctor.find(params[:id])
  
      if @doctor.update(doctor_params)
        redirect_to @doctor
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @doctor = Doctor.find(params[:id])
      @doctor.destroy
  
      redirect_to doctors_path
    end
  
    def doctor_params
      params.require(:doctor).permit(:name, :speciality, :mn)
    end
  end
  