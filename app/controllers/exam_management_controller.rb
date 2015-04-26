require 'date'
class ExamManagementController < ApplicationController
  def index
    
  end
  
  def about
    
  end
  
  #yield all interval date
  def interval_date start_date, end_date
    while(start_date <= end_date)
      yield start_date
      start_date +=1
    end
  end
  
  def generate_schedule_form
  end
  
  def manage_room
    start_year = params[:start_date][:year]
    start_month = params[:start_date][:month]
    start_day = params[:start_date][:day]
    
    end_year = params[:end_date][:year]
    end_month = params[:end_date][:month]
    end_day = params[:end_date][:day]
    
    some_error = false
    
    all_location = Location.all
    all_subject = Subject.all
    
    begin
      start = Date.new(start_year.to_i,start_month.to_i,start_day.to_i)
      endd = Date.new(end_year.to_i,end_month.to_i,end_day.to_i)
      
      #invalid date
      if(start > endd)
        some_error = true
        flash[:warning] = "invalid date"
        redirect_to generate_schedule_form_path
      #valid date
      else
        interval = Array.new
        interval_date start , endd  do |d|
          interval.push(d)
        end

      end #end else
    
    #invalid date exception
    rescue
      some_error = true
      flash[:warning] = "invalid date"
      redirect_to generate_schedule_form_path
    end
    
    
    unless some_error
          
      #################################################################################
      #           first create time slot for each subject in manage model             #
      #################################################################################
      Manage.delete_all
      
      interval.each do |i|
        all_location.each do |l|
          Manage.create(room_no:"#{l.room_no}",date:"#{i}")  
        end
      end
      
      #################################################################################
      #           add subject to manage slot                                         #
      #################################################################################
      # 2 ชม / 0.5 

      last_room = Location.last
      find_new_time_slot = false
      Manage.full = false
      
      all_subject.each do |s|
        
        temp = s.duration.to_i * 2
        fraction = (s.duration.to_f * 10) % 10
        if fraction == 3.0
          temp += 1
        end
        
        manage = Manage.all
        
        #if there is available time slot
        unless Manage.full
          #if general time are available (9-11 and 13-15)
          unless (find_new_time_slot)
            #for midterm exam
            manage.each do |m|
              
              #at the morning 
              #if 9:00 - 9:30 is available
              if m.slot1.nil?  && temp > 0
                man = Manage.find(m.id)
                man.assign_attributes({ :slot1 => "#{s.s_name}"})
                man.save!
                temp -= 1
              end
              if temp == 0
                break
              end
              #if 9:30 - 10:00 is available
              if m.slot2.nil?   && temp > 0
                man = Manage.find(m.id)
                man.assign_attributes({ :slot2 => "#{s.s_name}"})
                man.save!
                temp -= 1
              end
              if temp == 0
                break
              end
              #if 10:00 - 10:30 is available
              if m.slot3.nil?  && temp > 0
                man = Manage.find(m.id)
                man.assign_attributes({ :slot3 => "#{s.s_name}"})
                man.save!
                temp -= 1
              end
              if temp == 0
                break
              end
              #if 10:30 - 11:00 is available
              if m.slot4.nil? && temp > 0
                man = Manage.find(m.id)
                man.assign_attributes({ :slot4 => "#{s.s_name}"})
                man.save!
                temp -= 1
              end
              if temp == 0
                break
              end
    
              if ( (m.date === endd)  && ( m.room_no == last_room.room_no))
                find_new_time_slot = true
              end
              
              #at the afternoon 
              #if 13:00 - 13:30 is available
              if m.slot9.nil? && temp > 0
                man = Manage.find(m.id)
                man.assign_attributes({ :slot9 => "#{s.s_name}"})
                man.save!
                temp -= 1
              end
              if temp == 0
                break
              end
              #if 13:30 - 14:00 is available
              if m.slot10.nil?  && temp > 0
                man = Manage.find(m.id)
                man.assign_attributes({ :slot10 => "#{s.s_name}"})
                man.save!
                temp -= 1
              end
              if temp == 0
                break
              end
              #if 14:00 - 14:30 is available
              if m.slot11.nil?  && temp > 0
                man = Manage.find(m.id)
                man.assign_attributes({ :slot11 => "#{s.s_name}"})
                man.save!
                temp -= 1
              end
              if temp == 0
                break
              end
              #if 14:30 - 15:00 is available
              if m.slot12.nil? && temp > 0
                man = Manage.find(m.id)
                man.assign_attributes({ :slot12 => "#{s.s_name}"})
                man.save!
                temp -= 1
              end
              
              if temp == 0
                break
              end
              
            end #manage.each
          
          #if general time are not available (9-11 and 13-15). add remain subjects at time slot(11-13)
          else #find new time slot
          
            manage.each do |m|
              
              #if time slot is full
              if ( (m.date === endd)  && ( m.room_no == last_room.room_no))
               Manage.full = true
              end
              
              #if 11:00-11:30 is available
              if m.slot5.nil?  && temp > 0
                man = Manage.find(m.id)
                man.assign_attributes({ :slot5 => "#{s.s_name}"})
                man.save!
                temp -= 1
              end
              if temp == 0
                break
              end
              
              #if 11:30-12:00 is available
              if m.slot6.nil?  && temp > 0
                man = Manage.find(m.id)
                man.assign_attributes({ :slot6 => "#{s.s_name}"})
                man.save!
                temp -= 1
              end
              if temp == 0
                break
              end
              
              #if 12:00-12:30 is available
              if m.slot7.nil?  && temp > 0
                man = Manage.find(m.id)
                man.assign_attributes({ :slot7 => "#{s.s_name}"})
                man.save!
                temp -= 1
              end
              if temp == 0
                break
              end
              
              #if 12:30-13:00 is available
              if m.slot8.nil?  && temp > 0
                man = Manage.find(m.id)
                man.assign_attributes({ :slot8 => "#{s.s_name}"})
                man.save!
                temp -= 1
              end
              if temp == 0
                break
              end
              
            end #find new time slot (11-13)
            
          end #unless find new time slot
          
        else
          break
        end #unless full
        
      end #all_subject.each
      
      redirect_to show_managed_rooms_path
    end
  end
  
  
  def show_managed_rooms
     @manage = Manage.all
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
