require 'spec_helper'

describe ReConfigus do
  before(:all) do
    @reconfigus = ReConfigus.build :development do
      env :development, :parent => :production do
        my_key 'development'
        database do
          adapter 'sqlite'
        end
        node1 do
          node2 do
            node_value 'value'
          end
        end
      end

      env :production do
        my_key 'production2'
        second_key 'production'
      end
    end
  end

  it "should get value from re_configus instance" do
    @reconfigus.my_key.should eq('development')
  end

  it "should retrive blocks from congifus" do
    @reconfigus.database.adapter.should eq('sqlite')
    @reconfigus.node1.node2.node_value.should eq('value')
  end

  it "should acts as hash" do
    @reconfigus[:node1][:node2][:node_value].should eq('value')
  end

  it "should inherist parent" do
    @reconfigus.second_key.should eq('production')
  end
end
