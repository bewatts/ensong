require 'spec_helper'

describe LoopCollection do
  it { should have_many(:favorites) }
  it { should have_many(:user_favorites) }
  it { should have_many(:loop_inclusions) }
  it { should have_many(:loops) }
  it { should belong_to(:user) }
  
  it { should allow_mass_assignment_of(:title)}
  it { should allow_mass_assignment_of(:user_id)}
  

  it { should validate_presence_of(:user)}
  it { should validate_presence_of(:title)}
end
