class Api::PatientsController < ApplicationController
  http_basic_authenticate_with :name => "cerner", :password => "cerner"

  skip_before_filter :authenticate_user! # we do not need devise authentication here
  before_filter :fetch_patient, :except => [:index, :create]

 def fetch_patient
    @patient = Patient.find_by_id(params[:id])
  end

  def index
    @patients = Patient.all
    respond_to do |format|
      format.json { render json: @patients }
      format.xml { render xml: @patients }
    end
  end

  def show
    respond_to do |format|
      format.json { render json: @patient }
      format.xml { render xml: @patient }
    end
  end

  def create
    @patient = Patient.new(params[:patient])
    @patient.temp_password = Devise.friendly_token
    respond_to do |format|
      if @patient.save
        format.json { render json: @patient, status: :created }
        format.xml { render xml: @patient, status: :created }
      else
        format.json { render json: @patient.errors, status: :unprocessable_entity }
        format.xml { render xml: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @patient.update_attributes(params[:patient])
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @patient.errors, status: :unprocessable_entity }
        format.xml { render xml: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @patient.destroy
        format.json { head :no_content, status: :ok }
        format.xml { head :no_content, status: :ok }
      else
        format.json { render json: @patient.errors, status: :unprocessable_entity }
        format.xml { render xml: @patient.errors, status: :unprocessable_entity }
      end
    end
  end
end