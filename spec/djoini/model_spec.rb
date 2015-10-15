require 'spec_helper'

describe Djoini::Base do
  context 'model of User' do
    before(:each) do
      User.delete_all
    end

    it 'expected to set one value' do
      _user = User.create(name: 'Jack', last_name: 'Daniels')
      _user.name = 'Jack'
      _user.save

      expect(User.find(_user.id).name).to eq 'Jack'
    end

    it 'expected to update multiple values' do
      _user = User.create(name: 'Jack', last_name: 'Daniels')
      _user.name = 'Nansy'
      _user.last_name = 'Drew'
      _user.age = 30
      _user.save

      _new_user = User.find(_user.id)
      expect(_new_user.name).to eq 'Nansy'
      expect(_new_user.last_name).to eq 'Drew'
      expect(_new_user.age).to eq '30'
    end

    it 'expected to return 3 users' do
      3.times { User.create(name: 'Bot') }

      expect(User.all.count).to eq 3
    end

    it 'expected to succesfully delete user' do
      _user = User.create(name: 'Sacrifice')
      3.times { User.create(name: 'Bot') }

      expect(User.all.count).to eq 4

      _user.destroy

      expect(User.all.count).to eq 3
    end

    it 'should find user by name' do
      User.create(name: 'Bilbo', last_name: 'Beggins')

      _users = User.where(name: 'Bilbo')
      expect(_users.count).to eq 1

      expect(_users[0]).to be_a User
      expect(_users[0].last_name).to eq 'Beggins'
    end
  end
end
