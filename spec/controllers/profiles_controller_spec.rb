require File.dirname(__FILE__) + '/../spec_helper'

describe ProfilesController do
  fixtures :all
  render_views

  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end

  it "edit action should render edit template" do
    get :edit, :id => Profile.first
    response.should render_template(:edit)
  end

  it "update action should render edit template when model is invalid" do
    Profile.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Profile.first
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Profile.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Profile.first
    response.should redirect_to(profiles_url)
  end
end
