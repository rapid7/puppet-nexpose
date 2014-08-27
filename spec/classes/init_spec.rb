require 'spec_helper'
describe 'nexpose' do

  context 'with defaults for all parameters' do
    it { should contain_class('nexpose') }
  end
end
