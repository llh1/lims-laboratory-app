require "requests/apiary/3_tube_resource/spec_helper"
describe "swap_samples_across_4_tubes", :tube => true do
  include_context "use core context service"
  it "swap_samples_across_4_tubes" do
    sample1 = Lims::LaboratoryApp::Laboratory::Sample.new(:name => 'sample 1')
    sample2 = Lims::LaboratoryApp::Laboratory::Sample.new(:name => 'sample 2')
    sample3 = Lims::LaboratoryApp::Laboratory::Sample.new(:name => 'sample 3')
    sample4 = Lims::LaboratoryApp::Laboratory::Sample.new(:name => 'sample 4')
    
    tube1 = Lims::LaboratoryApp::Laboratory::Tube.new 
    tube1 << Lims::LaboratoryApp::Laboratory::Aliquot.new(:quantity => 10, :type => "DNA", :sample => sample1)
    
    tube2 = Lims::LaboratoryApp::Laboratory::Tube.new 
    tube2 << Lims::LaboratoryApp::Laboratory::Aliquot.new(:quantity => 10, :type => "DNA", :sample => sample2)
    
    tube3 = Lims::LaboratoryApp::Laboratory::Tube.new 
    tube3 << Lims::LaboratoryApp::Laboratory::Aliquot.new(:quantity => 10, :type => "DNA", :sample => sample3)
    
    tube4 = Lims::LaboratoryApp::Laboratory::Tube.new 
    tube4 << Lims::LaboratoryApp::Laboratory::Aliquot.new(:quantity => 10, :type => "DNA", :sample => sample4)
    
    save_with_uuid({
      sample1 => [1,2,3,0,1], sample2 => [1,2,3,0,2], sample3 => [1,2,3,0,3], sample4 => [1,2,3,0,4], 
      tube1 => [1,2,3,1,1], tube2 => [1,2,3,1,2], tube3 => [1,2,3,1,3], tube4 => [1,2,3,1,4]
    })

    header('Content-Type', 'application/json')
    header('Accept', 'application/json')

    response = post "/actions/swap_samples", <<-EOD
    {
    "swap_samples": {
        "parameters": [
            {
                "resource_uuid": "11111111-2222-3333-1111-111111111111",
                "swaps": {
                    "11111111-2222-3333-0000-111111111111": "11111111-2222-3333-0000-444444444444"
                }
            },
            {
                "resource_uuid": "11111111-2222-3333-1111-222222222222",
                "swaps": {
                    "11111111-2222-3333-0000-222222222222": "11111111-2222-3333-0000-333333333333"
                }
            },
            {
                "resource_uuid": "11111111-2222-3333-1111-333333333333",
                "swaps": {
                    "11111111-2222-3333-0000-333333333333": "11111111-2222-3333-0000-222222222222"
                }
            },
            {
                "resource_uuid": "11111111-2222-3333-1111-444444444444",
                "swaps": {
                    "11111111-2222-3333-0000-444444444444": "11111111-2222-3333-0000-111111111111"
                }
            }
        ]
    }
}
    EOD
    response.should match_json_response(200, <<-EOD) 
    {
    "swap_samples": {
        "actions": {
        },
        "user": "user",
        "application": "application",
        "result": [
            {
                "tube": {
                    "actions": {
                        "read": "http://example.org/11111111-2222-3333-1111-111111111111",
                        "create": "http://example.org/11111111-2222-3333-1111-111111111111",
                        "update": "http://example.org/11111111-2222-3333-1111-111111111111",
                        "delete": "http://example.org/11111111-2222-3333-1111-111111111111"
                    },
                    "uuid": "11111111-2222-3333-1111-111111111111",
                    "type": null,
                    "max_volume": null,
                    "aliquots": [
                        {
                            "sample": {
                                "actions": {
                                    "read": "http://example.org/11111111-2222-3333-0000-444444444444",
                                    "create": "http://example.org/11111111-2222-3333-0000-444444444444",
                                    "update": "http://example.org/11111111-2222-3333-0000-444444444444",
                                    "delete": "http://example.org/11111111-2222-3333-0000-444444444444"
                                },
                                "uuid": "11111111-2222-3333-0000-444444444444",
                                "name": "sample 4"
                            },
                            "quantity": 10,
                            "type": "DNA",
                            "unit": "mole"
                        }
                    ]
                }
            },
            {
                "tube": {
                    "actions": {
                        "read": "http://example.org/11111111-2222-3333-1111-222222222222",
                        "create": "http://example.org/11111111-2222-3333-1111-222222222222",
                        "update": "http://example.org/11111111-2222-3333-1111-222222222222",
                        "delete": "http://example.org/11111111-2222-3333-1111-222222222222"
                    },
                    "uuid": "11111111-2222-3333-1111-222222222222",
                    "type": null,
                    "max_volume": null,
                    "aliquots": [
                        {
                            "sample": {
                                "actions": {
                                    "read": "http://example.org/11111111-2222-3333-0000-333333333333",
                                    "create": "http://example.org/11111111-2222-3333-0000-333333333333",
                                    "update": "http://example.org/11111111-2222-3333-0000-333333333333",
                                    "delete": "http://example.org/11111111-2222-3333-0000-333333333333"
                                },
                                "uuid": "11111111-2222-3333-0000-333333333333",
                                "name": "sample 3"
                            },
                            "quantity": 10,
                            "type": "DNA",
                            "unit": "mole"
                        }
                    ]
                }
            },
            {
                "tube": {
                    "actions": {
                        "read": "http://example.org/11111111-2222-3333-1111-333333333333",
                        "create": "http://example.org/11111111-2222-3333-1111-333333333333",
                        "update": "http://example.org/11111111-2222-3333-1111-333333333333",
                        "delete": "http://example.org/11111111-2222-3333-1111-333333333333"
                    },
                    "uuid": "11111111-2222-3333-1111-333333333333",
                    "type": null,
                    "max_volume": null,
                    "aliquots": [
                        {
                            "sample": {
                                "actions": {
                                    "read": "http://example.org/11111111-2222-3333-0000-222222222222",
                                    "create": "http://example.org/11111111-2222-3333-0000-222222222222",
                                    "update": "http://example.org/11111111-2222-3333-0000-222222222222",
                                    "delete": "http://example.org/11111111-2222-3333-0000-222222222222"
                                },
                                "uuid": "11111111-2222-3333-0000-222222222222",
                                "name": "sample 2"
                            },
                            "quantity": 10,
                            "type": "DNA",
                            "unit": "mole"
                        }
                    ]
                }
            },
            {
                "tube": {
                    "actions": {
                        "read": "http://example.org/11111111-2222-3333-1111-444444444444",
                        "create": "http://example.org/11111111-2222-3333-1111-444444444444",
                        "update": "http://example.org/11111111-2222-3333-1111-444444444444",
                        "delete": "http://example.org/11111111-2222-3333-1111-444444444444"
                    },
                    "uuid": "11111111-2222-3333-1111-444444444444",
                    "type": null,
                    "max_volume": null,
                    "aliquots": [
                        {
                            "sample": {
                                "actions": {
                                    "read": "http://example.org/11111111-2222-3333-0000-111111111111",
                                    "create": "http://example.org/11111111-2222-3333-0000-111111111111",
                                    "update": "http://example.org/11111111-2222-3333-0000-111111111111",
                                    "delete": "http://example.org/11111111-2222-3333-0000-111111111111"
                                },
                                "uuid": "11111111-2222-3333-0000-111111111111",
                                "name": "sample 1"
                            },
                            "quantity": 10,
                            "type": "DNA",
                            "unit": "mole"
                        }
                    ]
                }
            }
        ],
        "parameters": [
            {
                "resource_uuid": "11111111-2222-3333-1111-111111111111",
                "swaps": {
                    "11111111-2222-3333-0000-111111111111": "11111111-2222-3333-0000-444444444444"
                }
            },
            {
                "resource_uuid": "11111111-2222-3333-1111-222222222222",
                "swaps": {
                    "11111111-2222-3333-0000-222222222222": "11111111-2222-3333-0000-333333333333"
                }
            },
            {
                "resource_uuid": "11111111-2222-3333-1111-333333333333",
                "swaps": {
                    "11111111-2222-3333-0000-333333333333": "11111111-2222-3333-0000-222222222222"
                }
            },
            {
                "resource_uuid": "11111111-2222-3333-1111-444444444444",
                "swaps": {
                    "11111111-2222-3333-0000-444444444444": "11111111-2222-3333-0000-111111111111"
                }
            }
        ]
    }
}
    EOD

  end
end
