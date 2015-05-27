require 'rails_helper'
require 'spec_helper'

RSpec.describe ExamManagementController, :type => :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  
  ######################################################################
  #               show  all locations function                         #
  ######################################################################
  
  describe "show_all_locations" do
    let(:location) { Location.create(room_no:"503",building:"Engineering",total_table:"40") }
    let(:web) {ExamManagementController.new}
    let(:locations) {Location.all}

    it "return http success" do
      get :show_all_locations
      expect(response).to have_http_status(:success)
    end
    it "show all locations" do
      expect(web.show_all_locations).to eq(locations)
    end
  end
  
  ######################################################################
  #               show  all subjects function                          #
  ######################################################################
  
  describe "show_all_subjects" do
    
    let(:web) {ExamManagementController.new}
    let(:subject) { Subject.create(s_id:"cn201",s_name:"OOP",section:"570001") }
    let(:subjects) {Subject.all}
      
    it "return http success" do
      get :show_all_subjects
      expect(response).to have_http_status(:success)
    end
    
    it 'should show all subjects' do
      expect(web.show_all_subjects).to eq(subjects)
    end
  end
  
  ######################################################################
  #               show subject detail function                         #
  ######################################################################
  
  describe "show subject detail" do
    
    it "should show detail of subject" do
      s = Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001")
      get :show_subject_detail ,:dsub => s
    end
  end
  
  ######################################################################
  #               show location detail function                        #
  ######################################################################
  
  describe "show location detail" do

    it "should show detail of location" do
      l = Location.create!(room_no:"503",building:"Engineering",total_table:"40")
      get :show_location_detail ,:dlocation => l
      
    end
  end
  
  ######################################################################
  #               add new location function                            #
  ######################################################################
  
  describe "add_new_location" do

    it 'should render the add_location_form template' do
			get :add_location_form
			response.should render_template 'add_location_form'
		end
		it 'should create a new location' do
		  amount = Location.count
      location = {:room_no => "503",:building => "Engineering",:total_table => "40"}
      post :add_new_location, {:location => location}
      flash[:notice].should_not be_nil
      response.should redirect_to(show_all_locations_path)
      expect(amount).to be < Location.count
    end
  end
  
  describe "add_new_location (sad path)" do
    it 'should render the add_location_form template' do
			get :add_location_form
			response.should render_template 'add_location_form'
		end
		it 'should not create a new location' do
		  amount = Location.count
      post :add_new_location, {:room_no => "",:building => "Engineering",:total_table => "aaa"}
      flash[:notice].should be_nil
      response.should render_template 'add_location_form'
      expect(amount).to be == Location.count
    end
  end
  
  ######################################################################
  #               add new subject function                             #
  ######################################################################
  
  describe "add_new_subject (happy path)" do
    it 'should render the add_suject_form template' do
			get :add_subject_form
			response.should render_template 'add_subject_form'
		end
		it 'should not create a new subject' do
		  amount = Subject.count
		  subject = {:s_id => 'cn201',:s_name => 'OOP',
      :section => '570001'}
      post :add_new_subject, {:subject => subject}
      flash[:notice].should_not be_nil
      response.should redirect_to(show_all_subjects_path)
      expect(amount).to be < Subject.count
    end
  end
  
  describe "add_new_subject (sad path)" do
    it 'should render the add_suject_form template' do
			get :add_subject_form
			response.should render_template 'add_subject_form'
		end
		it 'should not create a new subject' do
		  amount = Subject.count
      post :add_new_subject, {:s_id => 'cn201',:s_name => 'OOP',
      :section => ''}
      flash[:notice].should be_nil
      response.should render_template 'add_subject_form'
       expect(amount).to be == Subject.count
    end
  end
  
  ######################################################################
  #               update subject  function                             #
  ######################################################################
  
  describe "update subject (happy path)"do
    it 'should update subject' do
      sub1 =  Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001") 
      post :update_s ,:s_id => sub1, :subject => {:s_id => 'cn201',:s_name => 'Data Structure 1',
      :section => '570001'}

      flash[:notice].should_not be_nil
      subT = Subject.where(s_id: 'cn201')
      expect(sub1).should_not eq(subT[0])
    end
  end
  
  describe "update subject (sad path)"do
    it 'should update subject' do
      sub1 =  Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001")
      post :update_s ,:s_id => sub1, :subject => {:s_id => '',:s_name => 'Data Structure 1',
      :section => ''}
      
      flash[:notice].should be_nil
      subT = Subject.where(s_id: 'cn201')
      expect(sub1).to eq(subT[0])
    end
  end
  
  ######################################################################
  #               update location function                             #
  ######################################################################
  describe "update location (happy path)"do
    it 'should update subject' do
      loc1 =  Location.create!(room_no:"503",building:"Engineering",total_table:"40")
      post :update_l ,:room_no => loc1, :location => {:room_no => "503",:building => "SC",:total_table => "60"}

      flash[:notice].should_not be_nil
      locT = Location.where(room_no: '503')
      expect(loc1).should_not eq(locT[0])
    end
  end
  
  describe "update location (sad path)"do
    it 'should update subject' do
      loc1 =  Location.create!(room_no:"503",building:"Engineering",total_table:"40")
      post :update_l ,:room_no => loc1, :location => {:room_no => "",:building => "",:total_table => "60"}

      flash[:notice].should be_nil
      locT = Location.where(room_no: '503')
      expect(loc1).to eq(locT[0])
    end
  end
  
  ######################################################################
  #                        delete function                             #
  ######################################################################
  
  describe "delete subject " do
    it 'should delete subject' do
      s =  Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001")
      amount = Subject.count
      get :destroy_s ,:dsub => s
      flash[:notice].should_not be_nil
      expect(amount).to be > Subject.count
    end
  end
  
  describe "delete location " do
    it 'should delete location' do
      l = Location.create!(room_no:"503",building:"Engineering",total_table:"40")
      amount = Location.count
      get :destroy_l ,:dlocation => l
      flash[:notice].should_not be_nil
      expect(amount).to be > Location.count
    end
  end
  
  
  ######################################################################
  #                        search function                             #
  ######################################################################

  describe 'search subject' do
    it 'should search subject (happy path)' do
      s =  Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001")
      post :show_search_subject ,:search_by => "s_id", :search_value => "cn201"
      flash[:notice].should be_nil
    end
    
    it 'should search subject (sad path)' do
      s =  Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001")
      post :show_search_subject ,:search_by => "s_id", :search_value => "cn333"
      flash[:notice].should_not be_nil
    end
  end
  
  describe 'search location' do
    it 'should search location (happy path)' do
      l = Location.create!(room_no:"503",building:"Engineering",total_table:"40")
      post :show_search_location ,:search_by => "room_no", :search_value => "503"
      flash[:notice].should be_nil
    end
    
    it 'should search location (sad path)' do
      l = Location.create!(room_no:"503",building:"Engineering",total_table:"40")
      post :show_search_location ,:search_by => "room_no", :search_value => "777"
      flash[:notice].should_not be_nil
    end
  end
  
  ######################################################################
  #                        manage room function                        #
  ######################################################################
  
  describe 'manage room' do
    #################################################################
    ####################     Happy Path  ############################
    #################################################################
    
    ###################       Midterm     ###########################
    it 'should generate examination time, date and room automatically
        for midterm examination' do
      
      Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001")
      Location.create!(room_no:"503",building:"Engineering",total_table:"40")
      post :manage_room ,:start_date => {:year => "2015", :month => "05", :day => "17"},
            :end_date => {:year => "2015", :month => "05", :day => "17"},:type => "midterm"
      new_record = Manage.all.first
      expect(new_record.slot1).to be == "OOP"
      expect(new_record.slot2).to be == "OOP"
      expect(new_record.slot3).to be == "OOP"
      expect(new_record.slot4).to be == "OOP"
      expect(new_record.slot5).to be == nil
      expect(new_record.slot6).to be == nil
      expect(new_record.slot7).to be == nil
      expect(new_record.slot8).to be == nil
      expect(new_record.slot9).to be == nil
      expect(new_record.slot10).to be == nil
      expect(new_record.slot11).to be == nil
      expect(new_record.slot12).to be == nil
      expect(new_record.slot13).to be == nil
      expect(new_record.slot14).to be == nil
      expect(new_record.slot15).to be == nil
      expect(Manage.full).to be == false
    end
    
    ###################        final      ###########################
    it 'should generate examination time, date and room automatically
        for final  examination' do

      Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001")
      Subject.create!(s_id:"cn202",s_name:"Data Structure1",section:"570001")
      Location.create!(room_no:"503",building:"Engineering",total_table:"40")
      post :manage_room ,:start_date => {:year => "2015", :month => "05", :day => "17"},
            :end_date => {:year => "2015", :month => "05", :day => "17"},:type => "final"
      new_record = ManagesFinal.all.first
      expect(new_record.slot1).to be == "OOP"
      expect(new_record.slot2).to be == "OOP"
      expect(new_record.slot3).to be == "OOP"
      expect(new_record.slot4).to be == "OOP"
      expect(new_record.slot5).to be == "OOP"
      expect(new_record.slot6).to be == "OOP"
      expect(new_record.slot7).to be == nil
      expect(new_record.slot8).to be == nil
      expect(new_record.slot9).to be == nil
      expect(new_record.slot10).to be == "Data Structure1"
      expect(new_record.slot11).to be == "Data Structure1"
      expect(new_record.slot12).to be == "Data Structure1"
      expect(new_record.slot13).to be == "Data Structure1"
      expect(new_record.slot14).to be == "Data Structure1"
      expect(new_record.slot15).to be == "Data Structure1"
      expect(ManagesFinal.full).to be == false
    end

    #################################################################
    ####################      Sad Path    ###########################
    #################################################################
    
    ###################       Midterm     ###########################

    it 'should not generate examination time, date and room automatically
        for midterm examination' do
          
      Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001")
      Subject.create!(s_id:"cn202",s_name:"Data Structure1",section:"570001")
      Subject.create!(s_id:"cn310",s_name:"Data Structure2",section:"570001")
      Subject.create!(s_id:"cn350",s_name:"Microprocessor",section:"570001")
      Location.create!(room_no:"503",building:"Engineering",total_table:"40")
      post :manage_room ,:start_date => {:year => "2015", :month => "05", :day => "17"},
            :end_date => {:year => "2015", :month => "05", :day => "17"},:type => "midterm"
      new_record = Manage.all.first
      expect(new_record.slot1).to be == "OOP"
      expect(new_record.slot2).to be == "OOP"
      expect(new_record.slot3).to be == "OOP"
      expect(new_record.slot4).to be == "OOP"
      expect(new_record.slot5).to be == "Data Structure2"
      expect(new_record.slot6).to be == "Data Structure2"
      expect(new_record.slot7).to be == "Data Structure2"
      expect(new_record.slot8).to be == "Data Structure2"
      expect(new_record.slot9).to be == "Data Structure1"
      expect(new_record.slot10).to be == "Data Structure1"
      expect(new_record.slot11).to be == "Data Structure1"
      expect(new_record.slot12).to be == "Data Structure1"
      expect(new_record.slot13).to be == nil
      expect(new_record.slot14).to be == nil
      expect(new_record.slot15).to be == nil
      expect(Manage.full).to be == true
      
      
    end
    
    
    ###################        final      ###########################
    it 'should not generate examination time, date and room automatically
        for final  examination' do

      Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001")
      Subject.create!(s_id:"cn202",s_name:"Data Structure1",section:"570001")
      Subject.create!(s_id:"cn310",s_name:"Data Structure2",section:"570001")
      Location.create!(room_no:"503",building:"Engineering",total_table:"40")
      post :manage_room ,:start_date => {:year => "2015", :month => "05", :day => "17"},
            :end_date => {:year => "2015", :month => "05", :day => "17"},:type => "final"
      new_record = ManagesFinal.all.first
      expect(new_record.slot1).to be == "OOP"
      expect(new_record.slot2).to be == "OOP"
      expect(new_record.slot3).to be == "OOP"
      expect(new_record.slot4).to be == "OOP"
      expect(new_record.slot5).to be == "OOP"
      expect(new_record.slot6).to be == "OOP"
      expect(new_record.slot7).to be == nil
      expect(new_record.slot8).to be == nil
      expect(new_record.slot9).to be == nil
      expect(new_record.slot10).to be == "Data Structure1"
      expect(new_record.slot11).to be == "Data Structure1"
      expect(new_record.slot12).to be == "Data Structure1"
      expect(new_record.slot13).to be == "Data Structure1"
      expect(new_record.slot14).to be == "Data Structure1"
      expect(new_record.slot15).to be == "Data Structure1"
      expect(ManagesFinal.full).to be == true
    end
    
  end
  
  
  ######################################################################
  #                       edit manage room form                        #
  ######################################################################
 
  describe 'edit room form' do
    #################################    Happy Path    ############################
    ###############################################################################
    
    ###################       Midterm     ###########################
    it 'should store data on the cookies when user passed params (midterm form)' do
      post :edit_mid_form ,:subjectname => "OOP",:firstslot => "1"
      cookies[:currentsubject].should== "OOP"
      cookies[:beginslot].should == "1"
    end
    
    ###################       Final       ###########################
    it 'should store data on the cookies when user passed params (final form)' do
      post :edit_final_form ,:subjectnamef => "OOP",:firstslotf => "1"
      cookies[:currentsubject].should== "OOP"
      cookies[:beginslot].should == "1"
    end
    
    #################################     Sad Path     ############################
    ###############################################################################
    
    ###################       Midterm     ###########################
    it 'should not store data on the cookies when user press back button (midterm form)'do
      post :edit_mid_form 
      cookies[:currentsubject].should be_nil
      cookies[:beginslot].should be_nil
    end
    
    ###################         Final     ###########################
    it 'should not store data on the cookies when user press back button (final form)'do
      post :edit_mid_form 
      cookies[:currentsubject].should be_nil
      cookies[:beginslot].should be_nil
    end
    
  end
  
  
  
  ######################################################################
  ######################################################################
  ######################################################################
  ######################################################################
  ######################################################################
  ###########             edit timing block                #############
  ############         on the same day and room            #############
  ######################################################################
  ######################################################################
  ######################################################################
  ######################################################################
  ######################################################################
  ######################################################################
  
  
  ######################################################################
  ##################            Midterm         ########################       
  ######################################################################
 
  describe 'midterm edit timing block' do
    
    #################################    Happy Path    ############################
    it 'should edit timing block for midterm' do
      
      #create data
      Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001")
      Location.create!(room_no:"503",building:"Engineering",total_table:"40")
      #generate manege database
      post :manage_room ,:start_date => {:year => "2015", :month => "05", :day => "17"},
            :end_date => {:year => "2015", :month => "05", :day => "17"},:type => "midterm"
            
      new_record = Manage.all.first
      expect(new_record.slot1).to be == "OOP"
      expect(new_record.slot2).to be == "OOP"
      expect(new_record.slot3).to be == "OOP"
      expect(new_record.slot4).to be == "OOP"
      expect(new_record.slot5).to be == nil
      expect(new_record.slot6).to be == nil
      expect(new_record.slot7).to be == nil
      expect(new_record.slot8).to be == nil
      expect(new_record.slot9).to be == nil
      expect(new_record.slot10).to be == nil
      expect(new_record.slot11).to be == nil
      expect(new_record.slot12).to be == nil
      expect(new_record.slot13).to be == nil
      expect(new_record.slot14).to be == nil
      expect(new_record.slot15).to be == nil
      
      #move oop from 8.00-11.00 to 11.00-13.00
      post :edit_mid_form ,:subjectname => "OOP",:firstslot => "1"
      post :edit_timing_block_mid , :select_date_room => "1" , :select_slot => "5"
      
      new_record = Manage.all.first
      expect(new_record.slot1).to be == nil
      expect(new_record.slot2).to be == nil
      expect(new_record.slot3).to be == nil
      expect(new_record.slot4).to be == nil
      expect(new_record.slot5).to be == "OOP"
      expect(new_record.slot6).to be == "OOP"
      expect(new_record.slot7).to be == "OOP"
      expect(new_record.slot8).to be == "OOP"
      expect(new_record.slot9).to be == nil
      expect(new_record.slot10).to be == nil
      expect(new_record.slot11).to be == nil
      expect(new_record.slot12).to be == nil
      expect(new_record.slot13).to be == nil
      expect(new_record.slot14).to be == nil
      expect(new_record.slot15).to be == nil

      
    end
    #################################     Sad Path     ############################
    it 'should not edit timing block for midterm when collision occured' do
      
      #create data
      Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001")
      Subject.create!(s_id:"cn202",s_name:"Data Structure1",section:"570001")
      Location.create!(room_no:"503",building:"Engineering",total_table:"40")
      #generate manege database
      post :manage_room ,:start_date => {:year => "2015", :month => "05", :day => "17"},
            :end_date => {:year => "2015", :month => "05", :day => "17"},:type => "midterm"
            
      new_record = Manage.all.first
      expect(new_record.slot1).to be == "OOP"
      expect(new_record.slot2).to be == "OOP"
      expect(new_record.slot3).to be == "OOP"
      expect(new_record.slot4).to be == "OOP"
      expect(new_record.slot5).to be == nil
      expect(new_record.slot6).to be == nil
      expect(new_record.slot7).to be == nil
      expect(new_record.slot8).to be == nil
      expect(new_record.slot9).to be == "Data Structure1"
      expect(new_record.slot10).to be == "Data Structure1"
      expect(new_record.slot11).to be == "Data Structure1"
      expect(new_record.slot12).to be == "Data Structure1"
      expect(new_record.slot13).to be == nil
      expect(new_record.slot14).to be == nil
      expect(new_record.slot15).to be == nil
      
      #can't move oop from 8.00-11.00 to 13.00-15.00,
      post :edit_mid_form ,:subjectname => "OOP",:firstslot => "1"
      post :edit_timing_block_mid , :select_date_room => "1" , :select_slot => "9"
      
      new_record = Manage.all.first
      expect(new_record.slot1).to be == "OOP"
      expect(new_record.slot2).to be == "OOP"
      expect(new_record.slot3).to be == "OOP"
      expect(new_record.slot4).to be == "OOP"
      expect(new_record.slot5).to be == nil
      expect(new_record.slot6).to be == nil
      expect(new_record.slot7).to be == nil
      expect(new_record.slot8).to be == nil
      expect(new_record.slot9).to be == "Data Structure1"
      expect(new_record.slot10).to be == "Data Structure1"
      expect(new_record.slot11).to be == "Data Structure1"
      expect(new_record.slot12).to be == "Data Structure1"
      expect(new_record.slot13).to be == nil
      expect(new_record.slot14).to be == nil
      expect(new_record.slot15).to be == nil

      
    end
    
 
  end
  
  
  ######################################################################
  ##################              Final         ########################       
  ######################################################################
  
  describe 'final edit timing block' do
    #################################    Happy Path    ############################
    it 'should edit timing block for final' do
      
      #create data
      Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001")
      Location.create!(room_no:"503",building:"Engineering",total_table:"40")
      #generate manege database
      post :manage_room ,:start_date => {:year => "2015", :month => "05", :day => "17"},
            :end_date => {:year => "2015", :month => "05", :day => "17"},:type => "final"
            
      new_record = ManagesFinal.all.first
      expect(new_record.slot1).to be == "OOP"
      expect(new_record.slot2).to be == "OOP"
      expect(new_record.slot3).to be == "OOP"
      expect(new_record.slot4).to be == "OOP"
      expect(new_record.slot5).to be == "OOP"
      expect(new_record.slot6).to be == "OOP"
      expect(new_record.slot7).to be == nil
      expect(new_record.slot8).to be == nil
      expect(new_record.slot9).to be == nil
      expect(new_record.slot10).to be == nil
      expect(new_record.slot11).to be == nil
      expect(new_record.slot12).to be == nil
      expect(new_record.slot13).to be == nil
      expect(new_record.slot14).to be == nil
      expect(new_record.slot15).to be == nil
      
      
      #move oop from 8.00-12.00 to 13.30-16.30
      post :edit_final_form ,:subjectnamef => "OOP",:firstslotf => "1"
      post :edit_timing_block_final , :select_date_room => "1" , :select_slot => "10"
      
      new_record = ManagesFinal.all.first
      expect(new_record.slot1).to be == nil
      expect(new_record.slot2).to be == nil
      expect(new_record.slot3).to be == nil
      expect(new_record.slot4).to be == nil
      expect(new_record.slot5).to be == nil
      expect(new_record.slot6).to be == nil
      expect(new_record.slot7).to be == nil
      expect(new_record.slot8).to be == nil
      expect(new_record.slot9).to be == nil
      expect(new_record.slot10).to be == "OOP"
      expect(new_record.slot11).to be == "OOP"
      expect(new_record.slot12).to be == "OOP"
      expect(new_record.slot13).to be == "OOP"
      expect(new_record.slot14).to be == "OOP"
      expect(new_record.slot15).to be == "OOP"

      
    end
    #################################     Sad Path     ############################
    it 'should not edit timing block for final when collision occured' do
      
      #create data
      Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001")
      Subject.create!(s_id:"cn202",s_name:"Data Structure1",section:"570001")
      Location.create!(room_no:"503",building:"Engineering",total_table:"40")
      #generate manege database
      post :manage_room ,:start_date => {:year => "2015", :month => "05", :day => "17"},
            :end_date => {:year => "2015", :month => "05", :day => "17"},:type => "final"
      
      new_record = ManagesFinal.all.first   
      expect(new_record.slot1).to be == "OOP"
      expect(new_record.slot2).to be == "OOP"
      expect(new_record.slot3).to be == "OOP"
      expect(new_record.slot4).to be == "OOP"
      expect(new_record.slot5).to be == "OOP"
      expect(new_record.slot6).to be == "OOP"
      expect(new_record.slot7).to be == nil
      expect(new_record.slot8).to be == nil
      expect(new_record.slot9).to be == nil
      expect(new_record.slot10).to be == "Data Structure1"
      expect(new_record.slot11).to be == "Data Structure1"
      expect(new_record.slot12).to be == "Data Structure1"
      expect(new_record.slot13).to be == "Data Structure1"
      expect(new_record.slot14).to be == "Data Structure1"
      expect(new_record.slot15).to be == "Data Structure1"
      
      #can't move oop from 8.00-12.00 to 13.30-16.30
      post :edit_final_form ,:subjectnamef => "OOP",:firstslotf => "1"
      post :edit_timing_block_final , :select_date_room => "1" , :select_slot => "10"
      
      new_record = ManagesFinal.all.first
      expect(new_record.slot1).to be == "OOP"
      expect(new_record.slot2).to be == "OOP"
      expect(new_record.slot3).to be == "OOP"
      expect(new_record.slot4).to be == "OOP"
      expect(new_record.slot5).to be == "OOP"
      expect(new_record.slot6).to be == "OOP"
      expect(new_record.slot7).to be == nil
      expect(new_record.slot8).to be == nil
      expect(new_record.slot9).to be == nil
      expect(new_record.slot10).to be == "Data Structure1"
      expect(new_record.slot11).to be == "Data Structure1"
      expect(new_record.slot12).to be == "Data Structure1"
      expect(new_record.slot13).to be == "Data Structure1"
      expect(new_record.slot14).to be == "Data Structure1"
      expect(new_record.slot15).to be == "Data Structure1"

      
    end
 
  end
  
  
  
  
  
  
  ######################################################################
  ######################################################################
  ######################################################################
  ######################################################################
  ###########             edit timing block                #############
  ############      on the other day and room            ###############
  ######################################################################
  ######################################################################
  ######################################################################
  ######################################################################
  ######################################################################
  
  ######################################################################
  ##################            Midterm         ########################       
  ######################################################################
 
  describe 'midterm edit timing block' do
    
    #################################    Happy Path    ############################
    it 'should edit timing block for midterm' do
      
      #create data
      Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001")
      Location.create!(room_no:"503",building:"Engineering",total_table:"40")
      #generate manege database
      post :manage_room ,:start_date => {:year => "2015", :month => "05", :day => "17"},
            :end_date => {:year => "2015", :month => "05", :day => "18"},:type => "midterm"
            
      first_record = Manage.all.first
      expect(first_record.slot1).to be == "OOP"
      expect(first_record.slot2).to be == "OOP"
      expect(first_record.slot3).to be == "OOP"
      expect(first_record.slot4).to be == "OOP"
      expect(first_record.slot5).to be == nil
      expect(first_record.slot6).to be == nil
      expect(first_record.slot7).to be == nil
      expect(first_record.slot8).to be == nil
      expect(first_record.slot9).to be == nil
      expect(first_record.slot10).to be == nil
      expect(first_record.slot11).to be == nil
      expect(first_record.slot12).to be == nil
      expect(first_record.slot13).to be == nil
      expect(first_record.slot14).to be == nil
      expect(first_record.slot15).to be == nil
      
      last_record = Manage.all.last
      expect(last_record.slot1).to be == nil
      expect(last_record.slot2).to be == nil
      expect(last_record.slot3).to be == nil
      expect(last_record.slot4).to be == nil
      expect(last_record.slot5).to be == nil
      expect(last_record.slot6).to be == nil
      expect(last_record.slot7).to be == nil
      expect(last_record.slot8).to be == nil
      expect(last_record.slot9).to be == nil
      expect(last_record.slot10).to be == nil
      expect(last_record.slot11).to be == nil
      expect(last_record.slot12).to be == nil
      expect(last_record.slot13).to be == nil
      expect(last_record.slot14).to be == nil
      expect(last_record.slot15).to be == nil
      
      #move oop from 8.00-11.00,17/05/2015 to 11.00-13.00, 18/05/2015
      post :edit_mid_form ,:subjectname => "OOP",:firstslot => "1"
      post :edit_timing_block_mid , :select_date_room => "2" , :select_slot => "5"
      
      new_record = Manage.all.first
      expect(new_record.slot1).to be == nil
      expect(new_record.slot2).to be == nil
      expect(new_record.slot3).to be == nil
      expect(new_record.slot4).to be == nil
      expect(new_record.slot5).to be == nil
      expect(new_record.slot6).to be == nil
      expect(new_record.slot7).to be == nil
      expect(new_record.slot8).to be == nil
      expect(new_record.slot9).to be == nil
      expect(new_record.slot10).to be == nil
      expect(new_record.slot11).to be == nil
      expect(new_record.slot12).to be == nil
      expect(new_record.slot13).to be == nil
      expect(new_record.slot14).to be == nil
      expect(new_record.slot15).to be == nil
      
      last_record = Manage.all.last
      expect(last_record.slot1).to be == nil
      expect(last_record.slot2).to be == nil
      expect(last_record.slot3).to be == nil
      expect(last_record.slot4).to be == nil
      expect(last_record.slot5).to be == "OOP"
      expect(last_record.slot6).to be == "OOP"
      expect(last_record.slot7).to be == "OOP"
      expect(last_record.slot8).to be == "OOP"
      expect(last_record.slot9).to be == nil
      expect(last_record.slot10).to be == nil
      expect(last_record.slot11).to be == nil
      expect(last_record.slot12).to be == nil
      expect(last_record.slot13).to be == nil
      expect(last_record.slot14).to be == nil
      expect(last_record.slot15).to be == nil

      
    end
    #################################     Sad Path     ############################
    it 'should not edit timing block for midterm when collision occured' do
      
      #create data
      Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001")
      Subject.create!(s_id:"cn202",s_name:"Data Structure1",section:"570001")
      Subject.create!(s_id:"cn310",s_name:"Data Structure2",section:"570001")
      Subject.create!(s_id:"cn350",s_name:"Microprocessor",section:"570001")
      Location.create!(room_no:"503",building:"Engineering",total_table:"40")
      #generate manege database
      post :manage_room ,:start_date => {:year => "2015", :month => "05", :day => "17"},
            :end_date => {:year => "2015", :month => "05", :day => "18"},:type => "midterm"
            
      new_record = Manage.all.first
      expect(new_record.slot1).to be == "OOP"
      expect(new_record.slot2).to be == "OOP"
      expect(new_record.slot3).to be == "OOP"
      expect(new_record.slot4).to be == "OOP"
      expect(new_record.slot5).to be == nil
      expect(new_record.slot6).to be == nil
      expect(new_record.slot7).to be == nil
      expect(new_record.slot8).to be == nil
      expect(new_record.slot9).to be == "Data Structure1"
      expect(new_record.slot10).to be == "Data Structure1"
      expect(new_record.slot11).to be == "Data Structure1"
      expect(new_record.slot12).to be == "Data Structure1"
      expect(new_record.slot13).to be == nil
      expect(new_record.slot14).to be == nil
      expect(new_record.slot15).to be == nil
      
      last_record = Manage.all.last
      expect(last_record.slot1).to be == "Data Structure2"
      expect(last_record.slot2).to be == "Data Structure2"
      expect(last_record.slot3).to be == "Data Structure2"
      expect(last_record.slot4).to be == "Data Structure2"
      expect(last_record.slot5).to be == nil
      expect(last_record.slot6).to be == nil
      expect(last_record.slot7).to be == nil
      expect(last_record.slot8).to be == nil
      expect(last_record.slot9).to be == "Microprocessor"
      expect(last_record.slot10).to be == "Microprocessor"
      expect(last_record.slot11).to be == "Microprocessor"
      expect(last_record.slot12).to be == "Microprocessor"
      expect(last_record.slot13).to be == nil
      expect(last_record.slot14).to be == nil
      expect(last_record.slot15).to be == nil
      
      #can't move oop from 8.00-11.00,17/05/2015 to 8.00-11.00, 18/05/2015
      post :edit_mid_form ,:subjectname => "OOP",:firstslot => "1"
      post :edit_timing_block_mid , :select_date_room => "2" , :select_slot => "1"
      
      new_record = Manage.all.first
      expect(new_record.slot1).to be == "OOP"
      expect(new_record.slot2).to be == "OOP"
      expect(new_record.slot3).to be == "OOP"
      expect(new_record.slot4).to be == "OOP"
      expect(new_record.slot5).to be == nil
      expect(new_record.slot6).to be == nil
      expect(new_record.slot7).to be == nil
      expect(new_record.slot8).to be == nil
      expect(new_record.slot9).to be == "Data Structure1"
      expect(new_record.slot10).to be == "Data Structure1"
      expect(new_record.slot11).to be == "Data Structure1"
      expect(new_record.slot12).to be == "Data Structure1"
      expect(new_record.slot13).to be == nil
      expect(new_record.slot14).to be == nil
      expect(new_record.slot15).to be == nil
      
      last_record = Manage.all.last
      expect(last_record.slot1).to be == "Data Structure2"
      expect(last_record.slot2).to be == "Data Structure2"
      expect(last_record.slot3).to be == "Data Structure2"
      expect(last_record.slot4).to be == "Data Structure2"
      expect(last_record.slot5).to be == nil
      expect(last_record.slot6).to be == nil
      expect(last_record.slot7).to be == nil
      expect(last_record.slot8).to be == nil
      expect(last_record.slot9).to be == "Microprocessor"
      expect(last_record.slot10).to be == "Microprocessor"
      expect(last_record.slot11).to be == "Microprocessor"
      expect(last_record.slot12).to be == "Microprocessor"
      expect(last_record.slot13).to be == nil
      expect(last_record.slot14).to be == nil
      expect(last_record.slot15).to be == nil

      
    end
    
 
  end
  
  
  ######################################################################
  ##################              Final         ########################       
  ######################################################################
  
  describe 'final edit timing block' do
    #################################    Happy Path    ############################
    it 'should edit timing block for final' do
      
      #create data
      Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001")
      Location.create!(room_no:"503",building:"Engineering",total_table:"40")
      #generate manege database
      post :manage_room ,:start_date => {:year => "2015", :month => "05", :day => "17"},
            :end_date => {:year => "2015", :month => "05", :day => "18"},:type => "final"
            
      first_record = ManagesFinal.all.first
      expect(first_record.slot1).to be == "OOP"
      expect(first_record.slot2).to be == "OOP"
      expect(first_record.slot3).to be == "OOP"
      expect(first_record.slot4).to be == "OOP"
      expect(first_record.slot5).to be == "OOP"
      expect(first_record.slot6).to be == "OOP"
      expect(first_record.slot7).to be == nil
      expect(first_record.slot8).to be == nil
      expect(first_record.slot9).to be == nil
      expect(first_record.slot10).to be == nil
      expect(first_record.slot11).to be == nil
      expect(first_record.slot12).to be == nil
      expect(first_record.slot13).to be == nil
      expect(first_record.slot14).to be == nil
      expect(first_record.slot15).to be == nil
      
      last_record = ManagesFinal.all.last
      expect(last_record.slot1).to be == nil
      expect(last_record.slot2).to be == nil
      expect(last_record.slot3).to be == nil
      expect(last_record.slot4).to be == nil
      expect(last_record.slot5).to be == nil
      expect(last_record.slot6).to be == nil
      expect(last_record.slot7).to be == nil
      expect(last_record.slot8).to be == nil
      expect(last_record.slot9).to be == nil
      expect(last_record.slot10).to be == nil
      expect(last_record.slot11).to be == nil
      expect(last_record.slot12).to be == nil
      expect(last_record.slot13).to be == nil
      expect(last_record.slot14).to be == nil
      expect(last_record.slot15).to be == nil
      
      
      #move oop from 8.00-12.00, 17/05/2015 to 13.30-16.30, 18/05/2015
      post :edit_final_form ,:subjectnamef => "OOP",:firstslotf => "1"
      post :edit_timing_block_final , :select_date_room => "2" , :select_slot => "10"
      
      first_record = ManagesFinal.all.first
      expect(first_record.slot1).to be == nil
      expect(first_record.slot2).to be == nil
      expect(first_record.slot3).to be == nil
      expect(first_record.slot4).to be == nil
      expect(first_record.slot5).to be == nil
      expect(first_record.slot6).to be == nil
      expect(first_record.slot7).to be == nil
      expect(first_record.slot8).to be == nil
      expect(first_record.slot9).to be == nil
      expect(first_record.slot10).to be == nil
      expect(first_record.slot11).to be == nil
      expect(first_record.slot12).to be == nil
      expect(first_record.slot13).to be == nil
      expect(first_record.slot14).to be == nil
      expect(first_record.slot15).to be == nil
      
      last_record = ManagesFinal.all.last
      expect(last_record.slot1).to be == nil
      expect(last_record.slot2).to be == nil
      expect(last_record.slot3).to be == nil
      expect(last_record.slot4).to be == nil
      expect(last_record.slot5).to be == nil
      expect(last_record.slot6).to be == nil
      expect(last_record.slot7).to be == nil
      expect(last_record.slot8).to be == nil
      expect(last_record.slot9).to be == nil
      expect(last_record.slot10).to be == "OOP"
      expect(last_record.slot11).to be == "OOP"
      expect(last_record.slot12).to be == "OOP"
      expect(last_record.slot13).to be == "OOP"
      expect(last_record.slot14).to be == "OOP"
      expect(last_record.slot15).to be == "OOP"

      
    end
    #################################     Sad Path     ############################
    it 'should not edit timing block for final when collision occured' do
      
      #create data
      Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001")
      Subject.create!(s_id:"cn202",s_name:"Data Structure1",section:"570001")
      Subject.create!(s_id:"cn310",s_name:"Data Structure2",section:"570001")
      Subject.create!(s_id:"cn350",s_name:"Microprocessor",section:"570001")
      Location.create!(room_no:"503",building:"Engineering",total_table:"40")
      #generate manege database
      post :manage_room ,:start_date => {:year => "2015", :month => "05", :day => "17"},
            :end_date => {:year => "2015", :month => "05", :day => "18"},:type => "final"
      
      first_record = ManagesFinal.all.first
      expect(first_record.slot1).to be == "OOP"
      expect(first_record.slot2).to be == "OOP"
      expect(first_record.slot3).to be == "OOP"
      expect(first_record.slot4).to be == "OOP"
      expect(first_record.slot5).to be == "OOP"
      expect(first_record.slot6).to be == "OOP"
      expect(first_record.slot7).to be == nil
      expect(first_record.slot8).to be == nil
      expect(first_record.slot9).to be == nil
      expect(first_record.slot10).to be == "Data Structure1"
      expect(first_record.slot11).to be == "Data Structure1"
      expect(first_record.slot12).to be == "Data Structure1"
      expect(first_record.slot13).to be == "Data Structure1"
      expect(first_record.slot14).to be == "Data Structure1"
      expect(first_record.slot15).to be == "Data Structure1"
      
      last_record = ManagesFinal.all.last
      expect(last_record.slot1).to be == "Data Structure2"
      expect(last_record.slot2).to be == "Data Structure2"
      expect(last_record.slot3).to be == "Data Structure2"
      expect(last_record.slot4).to be == "Data Structure2"
      expect(last_record.slot5).to be == "Data Structure2"
      expect(last_record.slot6).to be == "Data Structure2"
      expect(last_record.slot7).to be == nil
      expect(last_record.slot8).to be == nil
      expect(last_record.slot9).to be == nil
      expect(last_record.slot10).to be == "Microprocessor"
      expect(last_record.slot11).to be == "Microprocessor"
      expect(last_record.slot12).to be == "Microprocessor"
      expect(last_record.slot13).to be == "Microprocessor"
      expect(last_record.slot14).to be == "Microprocessor"
      expect(last_record.slot15).to be == "Microprocessor"
      
      #can't move oop from 8.00-12.00, 17/05/2015 to 13.30-16.30, 18/05/2015
      post :edit_final_form ,:subjectnamef => "OOP",:firstslotf => "1"
      post :edit_timing_block_final , :select_date_room => "2" , :select_slot => "10"
      
      first_record = ManagesFinal.all.first
      expect(first_record.slot1).to be == "OOP"
      expect(first_record.slot2).to be == "OOP"
      expect(first_record.slot3).to be == "OOP"
      expect(first_record.slot4).to be == "OOP"
      expect(first_record.slot5).to be == "OOP"
      expect(first_record.slot6).to be == "OOP"
      expect(first_record.slot7).to be == nil
      expect(first_record.slot8).to be == nil
      expect(first_record.slot9).to be == nil
      expect(first_record.slot10).to be == "Data Structure1"
      expect(first_record.slot11).to be == "Data Structure1"
      expect(first_record.slot12).to be == "Data Structure1"
      expect(first_record.slot13).to be == "Data Structure1"
      expect(first_record.slot14).to be == "Data Structure1"
      expect(first_record.slot15).to be == "Data Structure1"
      
      last_record = ManagesFinal.all.last
      expect(last_record.slot1).to be == "Data Structure2"
      expect(last_record.slot2).to be == "Data Structure2"
      expect(last_record.slot3).to be == "Data Structure2"
      expect(last_record.slot4).to be == "Data Structure2"
      expect(last_record.slot5).to be == "Data Structure2"
      expect(last_record.slot6).to be == "Data Structure2"
      expect(last_record.slot7).to be == nil
      expect(last_record.slot8).to be == nil
      expect(last_record.slot9).to be == nil
      expect(last_record.slot10).to be == "Microprocessor"
      expect(last_record.slot11).to be == "Microprocessor"
      expect(last_record.slot12).to be == "Microprocessor"
      expect(last_record.slot13).to be == "Microprocessor"
      expect(last_record.slot14).to be == "Microprocessor"
      expect(last_record.slot15).to be == "Microprocessor"

      
    end
 
  end
  
end
