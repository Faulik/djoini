require 'spec_helper'

describe Djoini::Files do
  before(:all) do
    @loader = Djoini::Files.new(File.join(File.dirname(__FILE__), '/task_fixtures/'))
  end

  context 'Ini fixture' do
    before(:all) { User.delete_all }

    it 'should load all ini files' do
      @loader.load_files('ini')
    end

    it 'should find loaded entity in database' do
      _users = User.where(name: 'Cowboy')

      expect(_users.count).to eq 1
      expect(_users[0].last_name).to eq 'Bebop'
    end
  end

  context 'Json fixture' do
    before(:all) { User.delete_all }

    it 'should load all json files' do
      @loader.load_files('json')
    end

    it 'should find loaded entity in database' do
      _users = User.where(name: 'Tom')

      expect(_users.count).to eq 1
      expect(_users[0].last_name).to eq 'Sowyer'
    end
  end

  context 'Mixed fixtures' do
    before(:all) { User.delete_all }

    it 'should load all json files' do
      @loader.load_files
    end

    it 'should find loaded entity from json in database' do
      _users = User.where(name: 'Tom')

      expect(_users.count).to eq 1
      expect(_users[0].last_name).to eq 'Sowyer'
    end

    it 'should find loaded entity from ini in database' do
      _users = User.where(name: 'Tom')

      expect(_users.count).to eq 1
      expect(_users[0].last_name).to eq 'Sowyer'
    end
  end
end
