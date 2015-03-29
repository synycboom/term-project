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
    @location = Location.new
  end
  
  def add_new_location
    @location = Location.create(params[:location])
    
    if @location.save and @location.valid?
      flash[:notice] = "#{@location.room_no} was successfully created."
      redirect_to show_all_locations_path
    else
      render :add_location_form
    end
  end
  
  def add_subject_form
    @subject = Subject.new
  end
  
  def add_new_subject
    @subject = Subject.create(params[:subject])
    
    if @subject.save and @subject.valid?
      flash[:notice] = "#{@subject.s_id} was successfully created."
      redirect_to show_all_subjects_path
    else
      render :add_subject_form
    end
  end
  
  def show_subject_detail
    @subjects = Subject.all
    @sub = Subject.find(params[:dsub])
  end
  
  def show_location_detail
    @locations = Location.all
    @room = Location.find(params[:dlocation])
  end
  
end
