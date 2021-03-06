require 'models/spec_helper'

require 'lims-core/persistence/store'
require 'lims-core/persistence/session'

shared_context "create object" do
  let (:uuid) { "00000000-1111-2222-3333-444444444444" }
  before do 
    Lims::Core::Persistence::Session.any_instance.tap do |session|
      session.stub(:save)
      session.stub(:uuid_for!) { uuid }
    end
    Lims::Core::Persistence::Persistor.any_instance.tap do |persistor|
      persistor.stub(:bulk_insert)
      persistor.stub(:bulk_delete)
    end
  end
end


