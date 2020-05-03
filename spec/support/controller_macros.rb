module ControllerMacros
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      user = FactoryBot.create(:user)
      sign_in user
    end
  end

  def create_tweet
    before(:each) do
      tweeet = FactoryBot.create(:tweeet)
    end
  end
end
