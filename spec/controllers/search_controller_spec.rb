require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  let(:user) { User.create!(email: "user@example.com", password: "password", minecraft_username: "char", confirmed_at: Time.now) }
  before(:each) { sign_in user }

  describe "GET #search" do
    it "returns http success" do
      get :search
      expect(response).to have_http_status(:success)
    end
  end

end
