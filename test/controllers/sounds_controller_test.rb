require 'test_helper'

class SoundsControllerTest < ActionController::TestCase
  setup do
    @sound = sounds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sounds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sound" do
    assert_difference('Sound.count') do
      post :create, sound: { description: @sound.description, genre: @sound.genre, image_url: @sound.image_url, name: @sound.name, sound_url: @sound.sound_url, user_id_id: @sound.user_id_id }
    end

    assert_redirected_to sound_path(assigns(:sound))
  end

  test "should show sound" do
    get :show, id: @sound
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @sound
    assert_response :success
  end

  test "should update sound" do
    patch :update, id: @sound, sound: { description: @sound.description, genre: @sound.genre, image_url: @sound.image_url, name: @sound.name, sound_url: @sound.sound_url, user_id_id: @sound.user_id_id }
    assert_redirected_to sound_path(assigns(:sound))
  end

  test "should destroy sound" do
    assert_difference('Sound.count', -1) do
      delete :destroy, id: @sound
    end

    assert_redirected_to sounds_path
  end
end
