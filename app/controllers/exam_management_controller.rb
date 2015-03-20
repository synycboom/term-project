class ExamManagementController < ApplicationController
  def index
    
  end
  
  def about
    
  end
  
  def show_managed_rooms

  end
  
  def show_all_subjects
    @subjects = Subject.all
  end
  
  def show_all_locations
    @locations = Location.all
  end
  
  def add_location_form
  end
  
  def add_new_location
    @location = Location.create!(params[:location])
    flash[:notice] = "#{@location.room_no} was successfully created."
    redirect_to show_all_locations_path
  end
end
