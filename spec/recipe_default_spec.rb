require './spec/spec_helper'

describe 'tuned::default' do
  # run tests in centos 6 & 7
  platforms = {
    'centos' => ['6.6', '7.0']
  }

  platforms.each do |platform, versions|
    versions.each do |version|
      context "on #{platform.capitalize} #{version}" do
        let(:chef_run) do
          ChefSpec::SoloRunner.new.converge(described_recipe)
        end

        it 'installs tuned' do
          expect(chef_run).to install_package('tuned')
        end

        it 'enables tuned' do
          expect(chef_run).to enable_service 'tuned'
        end

        it 'starts tuned' do
          expect(chef_run).to start_service 'tuned'
        end
      end
    end
  end
end
