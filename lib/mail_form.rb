require "mail_form/version"
require "mail_form/railtie"

module MailForm
  # autoload allow us to lazily load a constant when it is first referenced
  autoload :Base, "mail_form/base"
end
