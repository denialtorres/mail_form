require "test_helper"
require "fixtures/sample_mail"

class MailFormTest < ActiveSupport::TestCase
  setup do
    ActionMailer::Base.deliveries.clear
  end

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

  test "sample mail can clear attributes using clear_ prefix" do
    sample = SampleMail.new

    sample.name = "User"
    sample.email = "user@example.com"
    assert_equal "User", sample.name
    assert_equal "user@example.com", sample.email

    sample.clear_name
    sample.clear_email

    assert_nil sample.name
    assert_nil sample.email
  end

  test "sample mail can ask if an attribute is present or not" do
    sample = SampleMail.new
    assert_not sample.name?

    sample.name = "User"
    assert sample.name?

    sample.email = ""
    assert_not sample.email?
  end

  test "delivers an email with attributes" do
    sample = SampleMail.new

    # Simulate data from the form
    sample.email = "user@example.com"
    sample.deliver

    assert_equal 1, ActionMailer::Base.deliveries.size
    mail = ActionMailer::Base.deliveries.last

    assert_equal [ "user@example.com" ], mail.from
    assert_match "Email: user@example.com", mail.body.encoded
  end

  test "validates absence of nickname" do
    sample = SampleMail.new(nickname: "Spam")
    assert_not sample.valid?
    assert_equal [ "must be blank" ], sample.errors[:nickname]
  end

  test "provides before and after deliver hooks" do
    sample = SampleMail.new(email: "user@example.com")
    sample.deliver
    assert_equal [ :before, :after ], sample.evaluated_callbacks
  end
end
