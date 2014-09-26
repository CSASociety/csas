require 'test_helper'

class AssistantsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Assistant.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Assistant.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Assistant.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to assistant_url(assigns(:assistant))
  end

  def test_edit
    get :edit, :id => Assistant.first
    assert_template 'edit'
  end

  def test_update_invalid
    Assistant.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Assistant.first
    assert_template 'edit'
  end

  def test_update_valid
    Assistant.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Assistant.first
    assert_redirected_to assistant_url(assigns(:assistant))
  end

  def test_destroy
    assistant = Assistant.first
    delete :destroy, :id => assistant
    assert_redirected_to assistants_url
    assert !Assistant.exists?(assistant.id)
  end
end
