require_relative "lib/mail_form/version"

Gem::Specification.new do |spec|
  spec.name        = "mail_form"
  spec.version     = MailForm::VERSION
  spec.authors     = [ "denialtorres" ]
  spec.email       = [ "denial.torres@gmail.com" ]
  spec.homepage    = "https://github.com/denialtorres/crafting-rails-4-apps"
  spec.summary     = "Mail form with active model"
  spec.description = "TODO: Description of MailForm."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end


  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 8.0.1"
end
