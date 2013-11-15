require 'spec_helper'

describe User do
  it { should have_many(:loop_collections) }
  it { should have_many(:authored_loops) }
  it { should have_many(:favorites) }
  it { should have_many(:favorited_loop_collections).through(:favorites) }

  it { should validate_presence_of(:password_digest)}
  it { should validate_presence_of(:username)}
  it { should_not allow_value("four").for(:password)}
  it { should allow_mass_assignment_of(:password)}
  it { should allow_mass_assignment_of(:username)}
    
end