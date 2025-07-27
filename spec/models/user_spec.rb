require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create!(username: "uniqueuser", password: "password") }

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username).case_insensitive }
  it { should have_secure_password }

  it "requires password to be at least 6 chars" do
    user = User.new(username: "test", password: "guest")
    expect(user.valid?).to be false
  end

  it "defaults role to chef" do
    user = User.create!(username: "Test Chef", password: "password")
    expect(user.role).to eq(User::ROLE_CHEF)
  end

  it "recognizes manager?" do
    user = User.create!(username: "Test Manager", password: "password", role: User::ROLE_MANAGER)
    expect(user.manager?).to be true
    expect(user.chef?).to be false
  end
end
