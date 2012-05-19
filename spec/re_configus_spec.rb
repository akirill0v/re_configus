require 'spec_helper'

describe ReConfigus do
  before(:all) do
    @reconfigus = ReConfigus.build :development do
      env :development, :parent => :production do
        my_key 'development'
        database do
          adapter 'sqlite'
        end
      end

      env :production do
        my_key 'production2'
      end
    end
  end

  it "should get value from re_configus instance" do
    @reconfigus.my_key.should eq('development')
  end

  it "should retrive blocks from congifus" do
    @reconfigus.database.adapter.should eq('sqlite')
  end
end
