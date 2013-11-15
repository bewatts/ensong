require 'spec_helper'

describe LoopInclusion do
  it { should belong_to(:loop_collection)}
  it { should belong_to(:loop)}
  it { should validate_presence_of(:loop_collection_id)}
  it { should validate_presence_of(:loop_id)}

  it { should allow_mass_assignment_of(:loop_collection_id)}
  it { should allow_mass_assignment_of(:loop_id)}
    
end
