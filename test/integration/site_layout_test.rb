require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "layout links" do
    get root_path
    assert_template 'welcome/index'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", recipes_path
    assert_select "a[href=?]", products_path
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
  end

  test "signup_page" do
    get signup_path
    assert_template 'users/new'
    assert_select "title", full_title("Sign up")
  end
end
