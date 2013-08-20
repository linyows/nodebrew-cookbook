require 'chefspec'

describe 'nodebrew::default' do
  let(:chef_run) {
    options = {
      cookbook_path: %w(cookbooks site-cookbooks)
    }
    chef_run = ChefSpec::ChefRunner.new(options) do |node|
    end
    chef_run.converge described_recipe
    chef_run
  }

  it { expect(chef_run).to install_package 'git' }
end
