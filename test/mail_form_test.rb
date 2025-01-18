require "test_helper"
require "fixtures/sample_mail"

class MailFormTest < ActiveSupport::TestCase
  test "it has a version number" do
    assert MailForm::VERSION
  end

  test "sample mail has name and email as attributes" do
    sample = SampleMail.new
    sample.name = "User"
    assert_equal "User", sample.name
    sample.email = "user@example.com"
    assert_equal "user@example.com", sample.email
  end
end
