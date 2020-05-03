require 'rails_helper'

RSpec.describe Tweeet, type: :model do
  let(:tweeter){ User.create(name: "test", username: "userTest", email: "test@test.com", password: "123456") }
  subject { described_class.new(tweeet: "hello",
                                created_at: DateTime.now,
                                updated_at: DateTime.now,
                                id: 1,
                                user_id: tweeter.id)
                              }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a user" do
    subject.user_id = nil 

    expect(subject).not_to be_valid
  end

  it "is not valid with a blank tweeet" do
    subject.tweeet = nil

    expect(subject).not_to be_valid
  end

  it "has tweet" do
    expect(subject.tweeet).to eq("hello")
  end

  it "has user" do
    expect(subject.user_id).to eq(tweeter.id)
  end
 end
