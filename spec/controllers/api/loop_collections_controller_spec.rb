require 'spec_helper'

describe Api::LoopCollectionsController do

  describe "GET 'show'" do
    it "returns http success" do
      get 'show'
      response.should be_success
    end
  end

end
