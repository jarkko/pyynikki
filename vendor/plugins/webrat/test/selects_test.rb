require File.dirname(__FILE__) + "/helper"

class SelectsTest < Test::Unit::TestCase
  def setup
    @session = ActionController::Integration::Session.new
    @session.stubs(:assert_response)
    @session.stubs(:get_via_redirect)
    @session.stubs(:response).returns(@response=mock)
  end

  def test_should_fail_if_option_not_found
    @response.stubs(:body).returns(<<-EOS)
      <form method="get" action="/login">
        <select name="month"><option value="1">January</option></select>
      </form>
    EOS
    @session.expects(:flunk)
    @session.selects "February"
  end
  
  def test_should_send_value_from_option
    @response.stubs(:body).returns(<<-EOS)
      <form method="post" action="/login">
        <select name="month"><option value="1">January</option></select>
        <input type="submit" />
      </form>
    EOS
    @session.expects(:post_via_redirect).with("/login", "month" => "1")
    @session.selects "January"
    @session.clicks_button
  end
  
  def test_should_option_text_if_no_value
    @response.stubs(:body).returns(<<-EOS)
      <form method="post" action="/login">
        <select name="month">
          <option selected="selected">January</option>
          <option>February</option>
        </select>
        <input type="submit" />
      </form>
    EOS
    @session.expects(:post_via_redirect).with("/login", "month" => "February")
    @session.selects "February"
    @session.clicks_button
  end
  
  def test_should_send_first_real_option_of_a_list_if_nothing_selected
    @response.stubs(:body).returns(<<-EOS)
      <form method="post" action="/login">
        <select name="month">
          <option value="1">January</option>
        </select>
        <input type="submit" />
      </form>
    EOS
    @session.expects(:post_via_redirect).with("/login", "month" => "1")
    @session.clicks_button
  end
  
  def test_should_send_first_preselected_option_of_a_list_if_nothing_selected
    @response.stubs(:body).returns(<<-EOS)
      <form method="post" action="/login">
        <select name="month">
          <option value="1">January</option>
          <option value="2" selected="selected">February</option>
        </select>
        <input type="submit" />
      </form>
    EOS
    @session.expects(:post_via_redirect).with("/login", "month" => "2")
    @session.clicks_button
  end
end
