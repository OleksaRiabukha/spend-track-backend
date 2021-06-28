require "rails_helper"

module Request
  module AuthHelpers
    def auth_headers(user)
      # user = User.create(first_name: "random", last_name: "random", email: "randommail@mail.com", password: "password")
      token = ApplicationController.new.issue_token(user)
      # post login_path, params: { user: { email:"randommail@mail.com", password: "password" }}
      # token = JSON.parse(response.body).values.last
      headers = { "Authorization": token }
    end
  end
end