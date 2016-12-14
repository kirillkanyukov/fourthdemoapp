require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'Invalid Signup Information' do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {user: {
        name: '',
        email: 'user@invalid.com',
        password: 'asdasd',
        password_confirmation: 'asdasd'
        }}
    end
    assert_template 'users/new'
  end


  test 'Valid Signup Information' do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" }
                               }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.content_tag(:div, message, class: "alert alert-#{message_type}") 
  end
end
