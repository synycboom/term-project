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
    let(:subject) { Subject.create(s_id:"cn201",s_name:"OOP",section:"570001",duration:"2") }
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
      s = Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001",duration:"2")
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
      :section => '570001', :duration => '2'}
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
      :section => '570001', :duration => ''}
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
      sub1 =  Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001",duration:"2") 
      post :update_s ,:s_id => sub1, :subject => {:s_id => 'cn201',:s_name => 'Data Structure 1',
      :section => '570001', :duration => '2'}

      flash[:notice].should_not be_nil
      subT = Subject.where(s_id: 'cn201')
      expect(sub1).should_not eq(subT[0])
    end
  end
  
  describe "update subject (sad path)"do
    it 'should update subject' do
      sub1 =  Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001",duration:"2")
      post :update_s ,:s_id => sub1, :subject => {:s_id => '',:s_name => 'Data Structure 1',
      :section => '', :duration => '2'}
      
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
      s =  Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001",duration:"2")
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
      s =  Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001",duration:"2")
      post :show_search_subject ,:search_by => "s_id", :search_value => "cn201"
      flash[:notice].should be_nil
    end
    
    it 'should search subject (sad path)' do
      s =  Subject.create!(s_id:"cn201",s_name:"OOP",section:"570001",duration:"2")
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
    
 
end
