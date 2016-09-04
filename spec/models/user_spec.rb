require 'rails_helper'

RSpec.describe User, type: :model do


    it 'should_create_a_password' do
        user = build(:user)
        expect user.password_digest
    end

    it 'should be able to save to database' do
        user = create(:user)
        expect(user.id).to be_an Integer
    end

    it 'should be able to find by credentials' do
        user = create(:user)
        found_user = User.find_by_credentials(user.email, user.password)
        expect(found_user.email).to eq(user.email)
    end

    it 'should reset session_token' do
        user = create(:user)
        save_token = user.session_token
        user.reset_session_token!
        expect(save_token).to_not eq(user.session_token)
    end

    it 'should ensure_session_token on creation' do
        user = create(:user)
        expect user.session_token
    end

    it 'should have many dogs' do
        user = create(:user)
        expect user.save
        expect user.dogs.empty?
        dog1 = Dog.new({ name: 'Loki', age: 5, size: 'medium', description: 'white dog'})
        dog1.owner_id = user.id
        expect dog1.save
        expect(user.dogs.empty?).to_not be true
        dog1 = Dog.new({ name: 'Paddington', age: 5, size: 'large', description: 'white fluffy dog'})
        dog1.owner_id = user.id
        expect dog1.save
        expect(user.dogs.length).to eq(2)
    end

    it 'should be able to find by email' do
        user = create(:user)
        user = User.find_by_email(user.email)
        expect(user).to_not be(nil)
    end

    it 'uses factory girl to create test user' do
        user = create(:user)
        expect(user.id).to be_an Integer
    end
end

def create_user(name, email, password)
    user = User.new({   name: name,
                        email: email,
                        session_token: 'AAAAAAAAAAAAAAAAA'
                    })
    user.password=password
    user
end
