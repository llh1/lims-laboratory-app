require 'lims-core/resource'
require 'lims-laboratory-app/laboratory/receptacle'

module Lims::LaboratoryApp
  module Laboratory
    # Filter Paper is a labware which can contains samples.
    # The filter paper can contains a barcode (either Sanger generated
    # or provided with the filter paper by an external company).
    class FilterPaper
      include Lims::Core::Resource
      include Receptacle
    end
  end
end
