require 'spec_helper'

describe ReConfigus do
  before(:all) do
    ReConfigus.build :development do
      env :development do
        key 'development'
        test 'value'
      end

      #env :production, :parent => :development do
      #  key 'production'
      #end
    end
  end

  it "should get value from re_configus instance" do
    re_configus.test.should eq('value')
  end
end
