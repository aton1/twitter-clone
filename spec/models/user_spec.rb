require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(email: "test@test.com",
                                name: "test",
                                username: "userTest",
                                created_at: DateTime.now,
                                updated_at: DateTime.now,
                                password: "123456",
                                id: 1)
                              }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is invalid without an email" do
    subject.email = nil 

    expect(subject).not_to be_valid
  end

  it "is invalid with a password less than 6 characters" do
    subject.password = "test"

    expect(subject).not_to be_valid
  end

  it "is invalid without a name" do
    subject.name = nil

    expect(subject).not_to be_valid
  end

  it "is invalid without a username" do
    subject.username = nil

    expect(subject).not_to be_valid
  end

  it "user has name" do 
    expect(subject.name).to eq("test") 
  end

  it "user has username" do
    expect(subject.username).to eq("userTest")
  end

  it "user has email" do
    expect(subject.email).to eq("test@test.com")
  end

  it "user has password" do
    expect(subject.password).to eq("123456")
  end
end
