require 'lims-api/core_action_resource'
require 'lims-api/resources/create_container'

require 'lims-laboratory-app/laboratory/gel'

module Lims::LaboratoryApp
  module Laboratory
    class Gel
      class CreateGelResource < Lims::Api::CoreActionResource
        include Lims::Api::Resources::CreateContainer

        def self.element_attr
          'windows_description'
        end

        def self.element_attr_sym
          :windows_description
        end
      end
    end
  end
end
