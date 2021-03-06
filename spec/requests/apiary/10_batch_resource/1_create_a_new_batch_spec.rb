require "requests/apiary/10_batch_resource/spec_helper"
describe "create_a_new_batch", :batch => true do
  include_context "use core context service"
  it "create_a_new_batch" do
  # **Create a new batch**
  # 
  # * `process` the process that the batch is going through

    header('Content-Type', 'application/json')
    header('Accept', 'application/json')

    response = post "/batches", <<-EOD
    {
    "batch": {
        "process": "manual extraction",
        "kit": "AAABBBCCC"
    }
}
    EOD
    response.should match_json_response(200, <<-EOD) 
    {
    "batch": {
        "actions": {
            "read": "http://example.org/11111111-2222-3333-4444-555555555555",
            "create": "http://example.org/11111111-2222-3333-4444-555555555555",
            "update": "http://example.org/11111111-2222-3333-4444-555555555555",
            "delete": "http://example.org/11111111-2222-3333-4444-555555555555"
        },
        "uuid": "11111111-2222-3333-4444-555555555555",
        "process": "manual extraction",
        "kit": "AAABBBCCC"
    }
}
    EOD

  end
end
