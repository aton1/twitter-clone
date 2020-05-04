require "rails_helper"

RSpec.describe TweeetsController, type: :controller do
  login_user

  it "should have a current_user" do
    expect(subject.current_user).not_to eq(nil)
  end

  context "when rendering templates" do
    create_tweet
    params = { id: 1 }

    it "renders #index template" do
      get :index
  
      expect(response).to render_template("index")
    end
  
    it "renders #new template" do
      get :new
  
      expect(response).to render_template("new")
    end
  
    it "renders #edit template" do
      get :edit, params: params
  
      expect(response).to render_template("edit")
    end
  
    it "renders #show template" do
      get :show, params: params
  
      expect(response).to render_template("show")
    end
  end

  context "when routing to different pages" do
    it "routes to #index" do
      expect(get: "/tweeets").to route_to("tweeets#index")
      end
    
    it "routes to #show" do
    expect(get: "/tweeets/1").to route_to("tweeets#show", id: "1")
    end
  
    it "routes to #new" do
    expect(get: "/tweeets/new").to route_to("tweeets#new")
    end
  
    it "routes to #update via PUT" do
    expect(put: "/tweeets/1").to route_to("tweeets#update", id: "1")
    end
    
    it "routes to #update via PATCH" do
    expect(patch: "/tweeets/1").to route_to("tweeets#update", id: "1")
    end
  end

  context "when creating a new tweet" do
    it "creates a new tweet" do
      params = {
        tweeet: "hello"
      }
  
      expect { post(:create, params: { tweeet: params }) }.to change(Tweeet, :count).by(1)
      expect(flash[:notice]).to eq("Tweet was successfully created.")
    end
  end

  context "when updating a tweet" do
    let!(:tweeet) { create :tweeet }

    it "should update the tweet" do
      params = {
        tweeet: "hello"
      }
      put :update, params: { id: tweeet.id, tweeet: params }
      tweeet.reload

      expect(tweeet.attributes[params.to_s]).to eq params[params]
      expect(flash[:notice]).to eq("Tweet was successfully updated.")
    end
  end

  context "when deleting a tweet" do
    let!(:tweeet) { create :tweeet }
   
    it "should delete tweet" do
      expect { delete :destroy, params: { id: tweeet.id } }.to change(Tweeet, :count).by(-1)
      expect(flash[:notice]).to eq("Tweet was successfully deleted.")
    end
  end
end
