require "spec_helper"

describe Comment do
  describe "validations" do
    it { should belong_to :article }
    it { should ensure_length_of(:body).is_at_most(4000) }
  end
end