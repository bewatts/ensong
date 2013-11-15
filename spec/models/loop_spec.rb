require 'spec_helper'

describe Loop do
  it { should belong_to(:author) }
  it { should have_many(:collection_inclusions) }  
  it { should have_many(:collections).through(:collection_inclusions) }
  
  it { should validate_presence_of(:author)}  
  it { should validate_presence_of(:audio)}  
  
end
