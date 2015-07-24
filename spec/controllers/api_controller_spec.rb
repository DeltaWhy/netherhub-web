require 'rails_helper'

RSpec.describe ApiController, type: :controller do
  ENV['JWT_SECRET'] = "s3cr3t_k3y"
  let! (:user) { User.create!(email: "user@example.com", password: "password", minecraft_username: "char") }
  describe "POST #authenticate" do
    it "returns JWT token for valid credentials" do
      post :authenticate, email: "user@example.com", password: "password"
      expect(response).to have_http_status(:success)
      expect { JWT.decode(response.body, ENV['JWT_SECRET']) }.to_not raise_error
    end

    it "returns error for invalid credentials" do
      post :authenticate
      expect(response).to have_http_status(403)
    end
  end

end
