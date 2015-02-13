require 'spec_helper'
describe 'wraith' do

  context 'with defaults for all parameters' do
    it { should contain_class('wraith') }
  end
end
