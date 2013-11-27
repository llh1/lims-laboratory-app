module Lims
  module Core::Persistence
    class Persistor
      alias :load_children_old :load_children
      def load_children(states, *params)
        if self.is_a? Lims::Core::Persistence::PersistorModule::EagerLabellableLoading
          eager_load_labellables(states, *params) 
        end

        load_children_old(states, *params)
      end
    end


    module PersistorModule
      module EagerLabellableLoading

        # @param [String] model
        # @return [Bool]
        def self.defined_for?(model)
          [
            "filter_paper", "flowcell", "gel", "plate", 
            "spin_column", "tube", "tube_rack"
          ].include?(model.to_s)
        end

        # @param [GroupState] states
        def eager_load_labellables(states, *params)
          load_labellables(states).each do |labellable|
            labelled_resource_state = states.find { |state| state.uuid_resource.uuid == labellable.name }
            next unless labelled_resource_state
            labelled_resource = labelled_resource_state.resource
            bind_labellable(labelled_resource, labellable)
          end
        end

        # @param [GroupState] states
        # @return [Array]
        def load_labellables(states)
          uuid_resources = states.map { |state| @session.uuid_resource_for(state) }.compact
          uuids = uuid_resources.map(&:uuid).map { |uuid| @session.pack_uuid(uuid) }
          @session.labellable.find_by(:name => uuids, :type => "resource")
        end

        # @param [Lims::Core::Resource] resource
        # @param [Labellable] labellable
        def bind_labellable(resource, labellable)
          resource.extend Lims::LaboratoryApp::Laboratory::WithLabellable
          resource.labellable = labellable
        end
      end
    end
  end


  module LaboratoryApp::Laboratory
    module WithLabellable
      def self.extended(k)
        k.instance_eval do
          class << self
            attr_accessor :labellable
          end
        end
      end
    end
  end
end