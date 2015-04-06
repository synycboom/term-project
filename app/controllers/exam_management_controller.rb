class ExamManagementController < ApplicationController
  def index
    
  end
  
  def about
    
  end
  
  def show_managed_rooms
    @subjects = Subject.all
    @locations = Location.all
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
    @subject = Subject.find(params[:dsub])
  end
  
  def show_location_detail
    @room = Location.find(params[:dlocation])
  end
  
  def edit_subject
    id = params[:usub]
    @subject = Subject.find(id)
  end
  
  def edit_location
    no = params[:ulocation]
    @location = Location.find(no)
  end
  
  def update_s
    @subject = Subject.find(params[:s_id])
    @subject.assign_attributes( params[:subject] )
    if @subject.valid?
      @subject.save
      flash[:notice] = "#{@subject.s_name} was successfully updated."
      redirect_to show_all_subjects_path
    else
      render :edit_subject
    end
  end
  
  def update_l
    @location = Location.find(params[:room_no])
    @location.assign_attributes(params[:location])
    if @location.valid?
      @location.save
      flash[:notice] = "#{@location.room_no} was successfully updated."
      redirect_to show_all_locations_path
    else
      render :edit_location
    end
  end
  
  def destroy_s
      @subject = Subject.find(params[:dsub])
      @subject.destroy
      flash[:notice] = "Subject '#{@subject.s_name}' deleted."
      redirect_to show_all_subjects_path
  end
  
  def destroy_l
    @room = Location.find(params[:dlocation])
    @room.destroy
    flash[:notice] = "Room '#{@room.room_no}' deleted."
    redirect_to show_all_locations_path
  end
  
  def show_search_location
    @search_location = Location.where("#{params[:search_by]} = ?",params[:search_value])
    if @search_location.blank?
        flash[:notice] = "No Data!!!"
        redirect_to show_all_locations_path
    end
  end
  
  def show_search_subject
    @search_subject = Subject.where("#{params[:search_by]} = ?",params[:search_value])
    if @search_subject.blank?
        flash[:notice] = "No Data!!!"
        redirect_to show_all_subjects_path
    end
  end
  
end
