module MailForm
  class Base
    include ActiveModel::AttributeMethods # 1) attribute methds behavior
    include ActiveModel::Conversion

    extend ActiveModel::Naming
    extend ActiveModel::Translation

    include ActiveModel::Validations

    attribute_method_prefix "clear_" # 2) clear_ is attribute prefix
    attribute_method_suffix "?" # 1) add the attribute suffix

    def self.attributes(*names)
      attr_accessor(*names)

      # 3) ask to define the prefix methods for the given attributes names
      define_attribute_methods(names)
    end

    def persisted?
      false
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
