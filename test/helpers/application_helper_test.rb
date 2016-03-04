require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "full title helper" do
    assert_equal full_title,         "Recipe Manager"
    assert_equal full_title("Help"), "Help | Recipe Manager"
  end
end