require 'rails_helper'

RSpec.describe User, type: :model do
  def valid_attributes(new_attributes = {})
    attributes = {first_name: "Jason",
                  last_name: "Tam",
                  email: "jason@email.com",
                  password: "abcd1234"}
    attributes.merge(new_attributes)
  end

  describe "Validations" do

    it "requires an email" do
      user = User.new(valid_attributes({email: nil}))
      expect(user).to be_invalid
    end

    it "requires an first name" do
      user = User.new(valid_attributes({first_name: nil}))
      expect(user).to be_invalid
    end

    it "requires an last name" do
      user = User.new(valid_attributes({last_name: nil}))
      expect(user).to be_invalid
    end

    it "requires a unique email" do
      User.create(valid_attributes)
      user = User.new(valid_attributes)
      user.save
      expect(user.errors.messages).to have_key(:email)
    end

    it "requires a valid email" do
      user = User.new(valid_attributes(email:"really eh"))
      expect(user).to be_invalid
    end
  end

  describe "Hashing password" do
    it "generates password digest if given a password" do
      user = User.new(valid_attributes)
      user.save
      expect(user.password_digest).to be
    end
  end

  describe ".full_name" do
    it "returns the concatenated first name and last name if both are given" do
      user = User.new(valid_attributes)
      expect(user.full_name).to eq("#{valid_attributes[:first_name]} #{valid_attributes[:last_name]}")
    end

    it "returns the first name only if only the first name is given" do
      user = User.new(valid_attributes(first_name: nil, last_name: nil))
      expect(user.full_name).to eq(valid_attributes[:email])
    end
  end

end
