require 'rails_helper'
require 'spec_helper'

RSpec.describe ExamManagementController, :type => :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end
  
  describe "GET #show_all_locations" do
    it "return http success" do
      get :show_all_locations
      expect(response).to have_http_status(:success)
    end
    it "show all locations" do
       get :show_all_locations
       response.should render_template 'show_all_locations'

    end
  end
  
  describe "GET #show_all_subjects" do
    it "return http success" do
      get :show_all_subjects
      expect(response).to have_http_status(:success)
    end
  end
  
  # describe "show subject detail" do
  #   let(:subject) { Subject.new(s_id:"cn201",s_name:"OOP",section:"570001",time:"12:00",date:"1/Jan/2558") }
  #   it "return http success" do
  #     visit show_subject_detail(subject)
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  
  describe "#add_new_location" do
    it 'should render the add_location_form template' do
			get :add_location_form
			response.should render_template 'add_location_form'
		end
		it 'should create a new location' do
		  #fill_in 'location_room_no', :with => '503'
		  #fill_in 'location_building', :with => 'Engineering'
		  #fill_in 'location_total_table', :with => '40'
		  
		  #double = mock('Location')
     #ExamManagementController.any_instance.stub(:add_new_location).and_return(double)
     
      #post :add_new_location, {:room_no => "503",:building => "Engineering",:total_table => "40"}
      #flash[:notice].should_not be_nil
      #response.should render_template 'add_location_form'
    end
  end
  
  describe "add_new_location (sad path)" do
    it 'should render the add_location_form template' do
			get :add_location_form
			response.should render_template 'add_location_form'
		end
		it 'should create a new location' do
      post :add_new_location, {:room_no => "",:building => "Engineering",:total_table => "aaa"}
      flash[:notice].should be_nil
      response.should render_template 'add_location_form'
    end
  end
  
  describe "add_new_subject (sad path)" do
    it 'should render the add_suject_form template' do
			get :add_subject_form
			response.should render_template 'add_subject_form'
		end
		it 'should create a new subject' do
      post :add_new_subject, {:s_id => 'cn201',:s_name => 'OOP',
      :section => '570001', :time => '', :date => ''}
      flash[:notice].should be_nil
      response.should render_template 'add_subject_form'
    end
  end

end
