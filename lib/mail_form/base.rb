module MailForm
  class Base
    # read more about this
    class_attribute :attribute_names
    self.attribute_names = []

    include ActiveModel::Model
    include ActiveModel::AttributeMethods # 1) attribute methds behavior
    # include ActiveModel::Conversion
    # extend ActiveModel::Naming
    # extend ActiveModel::Translation
    # extend ActiveModel::Callbacks # << add callbacks behavior
    #
    # include ActiveModel::Validations

    attribute_method_prefix "clear_" # 2) clear_ is attribute prefix
    attribute_method_suffix "?" # 1) add the attribute suffix

    # define the callbacks, the line bellow will create both before_deliver
    # and after_deliver callbacks, with teh same semantes as in Active Record

    define_model_callbacks :deliver

    def self.attributes(*names)
      attr_accessor(*names)

      # 3) ask to define the prefix methods for the given attributes names
      define_attribute_methods(names)

      self.attribute_names += names
    end

    def initialize(attributes = {})
      attributes.each do |attr, value|
        self.public_send("#{attr}=", value)
      end if attributes
    end

    def persisted?
      false
    end

    def deliver
      if valid?
        run_callbacks(:deliver) do
          MailForm::Notifier.contact(self).deliver
        end
      else
        false
      end
    end

    protected

    # 4) Since we declared a "clear_" prefix, it expects to have a
    # "crear_attribute" method defined, which receives an attribute name and implementsthe clearing logic
    def clear_attribute(attribute)
      send("#{attribute}=", nil)
    end

    # 2) Implement the logic required by the "?" suffix
    def attribute?(attribute)
      send(attribute).present?
    end
  end
end
