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
    ##test duration
    type = params[:type]
    
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
      if type == 'midterm'
        Manage.delete_all
        
        interval.each do |i|
          all_location.each do |l|
            Manage.create(room_no:"#{l.room_no}",date:"#{i}")  
          end
        end
        
      else
        ManagesFinal.delete_all
        
        interval.each do |i|
          all_location.each do |l|
            ManagesFinal.create(room_no:"#{l.room_no}",date:"#{i}")  
          end
        end
        
      end
      
      
      #################################################################################
      #           add subject to manage slot                                         #
      #################################################################################

      last_room = Location.last
      find_new_time_slot = false
      Manage.full = false
      ManagesFinal.full = false
      
      all_subject.each do |s|
        if type == 'midterm'
          temp = 4
        else
          temp = 6
        end

        manage = Manage.all
        manageFinal = ManagesFinal.all
        
        #if there is available time slot
        if temp == 4
          unless Manage.full
          
            #if general time are available (9-11 and 13-15)
            unless (find_new_time_slot)
              #for midterm exam
              manage.each do |m|
              
                #at the morning 
                #if 9:00 - 11:00 is available
                if m.slot1.nil?  && temp > 0
                  man = Manage.find(m.id)
                  man.assign_attributes({ :slot1 => "#{s.s_name}",
                  :slot2 => "#{s.s_name}",
                  :slot3 => "#{s.s_name}",
                  :slot4 => "#{s.s_name}",
                  :exam_type => "#{type}"})
                  man.save!
                  temp -= 4
                end
                if temp == 0
                  break
                end
             
                if ( (m.date === endd)  && ( m.room_no == last_room.room_no))
                  find_new_time_slot = true
                end
                
                #at the afternoon 
                #if 13:00 - 15:00 is available
                if m.slot9.nil? && temp > 0
                  man = Manage.find(m.id)
                  man.assign_attributes({ :slot9 => "#{s.s_name}",
                    :slot10 => "#{s.s_name}",
                    :slot11 => "#{s.s_name}",
                    :slot12 => "#{s.s_name}",
                    :exam_type => "#{type}"
                  })
                  man.save!
                  temp -= 4
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
                
                #if 11:00-13:00 is available
                if m.slot5.nil?  && temp > 0
                  man = Manage.find(m.id)
                  man.assign_attributes({ :slot5 => "#{s.s_name}",
                    :slot6 => "#{s.s_name}",
                    :slot7 => "#{s.s_name}",
                    :slot8 => "#{s.s_name}",
                    :exam_type => "#{type}"
                  })
                  man.save!
                  temp -= 4
                end
                
                if temp == 0
                  break
                end
        
              end #find new time slot (11-13)
            end #unless find new time slot
          #if full
          else
            break
          end #unless full
        
        else #final exam
          unless ManagesFinal.full
            manageFinal.each do |m|
              #if time slot is full
              if ( (m.date === endd)  && ( m.room_no == last_room.room_no))
               ManagesFinal.full = true
              end
              
              #at the morning 
              #if 9:00 - 12:00 is available
              if m.slot1.nil?  && temp > 0
                man = ManagesFinal.find(m.id)
                man.assign_attributes({ :slot1 => "#{s.s_name}",
                  :slot2 => "#{s.s_name}",
                  :slot3 => "#{s.s_name}",
                  :slot4 => "#{s.s_name}",
                  :slot5 => "#{s.s_name}",
                  :slot6 => "#{s.s_name}",
                  :exam_type => "#{type}"
                })
                man.save!
                temp -= 6
              end
              if temp == 0
                break
              end
              
              #at the afternoon 
              #if 13:30 - 16:30 is available
              if m.slot10.nil? && temp > 0
                man = ManagesFinal.find(m.id)
                man.assign_attributes({ :slot10 => "#{s.s_name}",
                  :slot11 => "#{s.s_name}",
                  :slot12 => "#{s.s_name}",
                  :slot13 => "#{s.s_name}",
                  :slot14 => "#{s.s_name}",
                  :slot15 => "#{s.s_name}",
                  :exam_type => "#{type}"
                })
                man.save!
                temp -= 6
              end
              if temp == 0
                break
              end
             
            end #manage.each
          else
            break
          end #unless full  
        end
      end #all_subject.each
      
      if type == 'midterm'
        redirect_to show_managed_rooms_m_path
      else
        redirect_to show_managed_rooms_f_path
      end
      
    end
  end
  
  ###############################################################################################
  ###############################################################################################
  ####################################   edit managed room   ####################################
  ###############################################################################################
  ###############################################################################################
  
  def edit_mid_form 
    @manage_edit = Manage.all
    unless (params[:subjectname].nil?) && (params[:firstslot].nil?)
      @current_subject = params[:subjectname]
      @begin_slot = params[:firstslot]
      
      cookies[:currentsubject] = params[:subjectname]
      cookies[:beginslot] = params[:firstslot]
    else
      @current_subject =  cookies[:currentsubject]
      @begin_slot = cookies[:beginslot]
    end
    
  end
  
  def edit_final_form
    unless (params[:subjectnamef].nil?) && (params[:firstslotf].nil?)
      @current_subject_f = params[:subjectnamef]
      @begin_slot_f = params[:firstslotf]
      
      cookies[:currentsubject] = params[:subjectnamef]
      cookies[:beginslot] = params[:firstslotf]
    else
      @current_subject_f =  cookies[:currentsubject]
      @begin_slot_f = cookies[:beginslot]
    end
  end
  

  
  ###############################################################################################
  ###############################  edit timing block of managed room   ##########################
  ###############################################################################################
  
  def edit_timing_block_mid
    

    id = params[:select_date_room]
    
    start_block = params[:select_slot]
    start_block = start_block.to_i
    subject = cookies[:currentsubject]
    
    #original slot
    slot = cookies[:beginslot]
    slot = slot.to_i
    
    #find a row in which the target subject reside 
    current = Manage.where("slot#{slot} = ?","#{subject}").first
    i = 0
    
    #if user wants to edit schedule at the same day
    if current.id.to_i == id.to_i
      #delete subject out of time slot of that day
      while i<4
        current.assign_attributes "slot#{slot+i}" => nil
        i += 1
      end
      
      #if the block is not available then restore the current's value and warn user
      unless eval "current.slot#{start_block}.nil? && current.slot#{start_block+3}.nil?"
        i = 0
        while i<4
          current.assign_attributes "slot#{slot+i}" => subject
          i += 1
        end
        current.save!
        flash[:warning] = "the peroid you selected is not available"
        render :edit_mid_form
      #if the block is available
      else
        i = 0
        while i<4
          current.assign_attributes "slot#{start_block+i}" => subject
          i += 1
        end
        current.save!
        redirect_to show_managed_rooms_m_path
      end
    
    #user wants to move subject to the other day
    else
      target = Manage.find(id)
      #if the block on date and time which user selected are available 
      if eval "target.slot#{start_block}.nil? && target.slot#{start_block+3}.nil?"
        #delete subject out of time slot of that day
        while i<4
          current.assign_attributes "slot#{slot+i}" => nil
          target.assign_attributes "slot#{slot+i}" => subject
          i += 1
        end
        current.save!
        target.save!
        redirect_to show_managed_rooms_m_path
      else
        flash[:warning] = "the peroid you selected is not available"
        render :edit_mid_form
      end
    end
  end
  

  def edit_timing_block_final
    
    id = params[:select_date_room]
    start_block = params[:select_slot]
    start_block = start_block.to_i
    subject = cookies[:currentsubject]
    
    #original slot
    slot = cookies[:beginslot]
    slot = slot.to_i
    
    #find a row in which the target subject reside 
    current = ManagesFinal.where("slot#{slot} = ?","#{subject}").first
    i = 0
    
    #if user wants to edit schedule at the same day
    if current.id.to_i == id.to_i
      #delete subject out of time slot of that day
      while i<6
        current.assign_attributes "slot#{slot+i}" => nil
        i += 1
      end
      
      #if the block is not available then restore the current's value and warn user
      unless eval "current.slot#{start_block}.nil? && current.slot#{start_block+5}.nil?"
        i = 0
        while i<6
          current.assign_attributes "slot#{slot+i}" => subject
          i += 1
        end
        current.save!
        flash[:warning] = "the peroid you selected is not available"
        render :edit_final_form
      #if the block is available
      else
        i = 0
        while i<6
          current.assign_attributes "slot#{start_block+i}" => subject
          i += 1
        end
        current.save!
        redirect_to show_managed_rooms_f_path
      end
    
    #user wants to move subject to the other day
    else
      target = ManagesFinal.find(id)
      #if the block on date and time which user selected are available 
      if eval "target.slot#{start_block}.nil? && target.slot#{start_block+5}.nil?"
        #delete subject out of time slot of that day
        while i<6
          current.assign_attributes "slot#{slot+i}" => nil
          target.assign_attributes "slot#{slot+i}" => subject
          i += 1
        end
        current.save!
        target.save!
        redirect_to show_managed_rooms_f_path
      else
        flash[:warning] = "the peroid you selected is not available"
        render :edit_final_form
      end
    end
  end
  
  
  
  ###############################################################################################
  ####################################       show managed room         ##########################
  ###############################################################################################

  def show_managed_rooms_m
     @manage = Manage.all
  end
  
  def show_managed_rooms_f
     @managef = ManagesFinal.all
  end
  
  def edit_managed
    @manage = Manage.all
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
