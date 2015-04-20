require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  test '#signup_success' do
    post :signup, {'username' => 'testuser', 'password' => 'testpass'}
    json = JSON.parse(response.body)
    assert json['user_name'] == 'testuser'
    assert json['login_count'] == 1
  end

  test '#signup_failure_user' do
    post :signup, {'username' => 'test', 'password' => 'testpass'}
    json = JSON.parse(response.body)
    assert json['error_code'] == -1
  end

  test '#signup_failure_user_long' do
    post :signup, {'username' => 'test_long_username_so_it_cannot_be_pass', 'password' => 'testpass'}
    json = JSON.parse(response.body)
    assert json['error_code'] == -1
  end

  test '#signup_failure_user_and_pass' do
    post :signup, {'username' => 'test_long_username_so_it_cannot_be_pass', 'password' => 'test'}
    json = JSON.parse(response.body)
    assert json['error_code'] == -1
  end

  test '#signup_failure_pwd' do
    post :signup, {'username' => 'testuser', 'password' => 'test'}
    json = JSON.parse(response.body)
    assert json['error_code'] == -2
  end

  test '#signup_failure_dup' do
    post :signup, {'username' => 'Romeo', 'password' => 'ihatejuliet'}
    json = JSON.parse(response.body)
    assert json['error_code'] == -3
  end

  test '#login_success' do
    post :login, {'username' => 'Romeo', 'password' => 'ilovejuliet'}
    json = JSON.parse(response.body)
    assert json['user_name'] == 'Romeo'
    assert json['login_count'] == 101
  end

  test '#login_failure' do
    post :login, {'username' => 'Shrek', 'password' => 'ilovefiona'}
    json = JSON.parse(response.body)
    assert json['error_code'] == -4
  end
end
