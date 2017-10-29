require 'spec_helper'

describe package('ntp') do
  it { should be_installed }
  it { should be_running }
end

describe service('ntp') do
  it { should be_enabled   }
  it { should be_running   }
end
