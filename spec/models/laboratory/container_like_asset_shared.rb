# Spec requirements
require 'models/spec_helper'
require 'models/laboratory/aliquot_shared'

# Model requirements

require 'lims-laboratory-app/laboratory/gel/all'
require 'lims-laboratory-app/laboratory/plate/all'
require 'facets/array'

module Lims::LaboratoryApp
  module Laboratory
    shared_context "container-like asset factory" do
      include_context "aliquot factory"

      def new_plate_with_samples(sample_nb=5, quantity=nil)
        new_container_with_samples(Plate, sample_nb, quantity)
      end

      def new_gel_with_samples(sample_nb=5, quantity=nil)
        new_container_with_samples(Gel, sample_nb, quantity)
      end

      def new_container_with_samples(asset_to_create, sample_nb, volume=100, quantity=nil)
        asset_to_create.new(:number_of_rows => number_of_rows, :number_of_columns => number_of_columns).tap do |asset|
          asset.each_with_index do |w, i|
            1.upto(sample_nb) do |j|
              w <<  new_aliquot(i,j,quantity)
            end
            w << Aliquot.new(:type => Aliquot::Solvent, :quantity => volume) if volume
          end
        end
      end

      def new_empty_plate
        new_empty_container(Plate)
      end

      def new_empty_gel
        new_empty_container(Gel)
      end

      def new_empty_container(asset_to_create)
        asset_to_create.new(:number_of_rows => number_of_rows, :number_of_columns => number_of_columns)
      end

    end
  end
end
