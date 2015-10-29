require './spec/spec_helper'

describe 'test_tuned::recommend' do
  # run tests in centos 6 & 7
  platforms = {
    'centos' => ['6.6', '7.0']
  }

  platforms.each do |platform, versions|
    versions.each do |version|
      context "on #{platform.capitalize} #{version}" do
        let(:chef_run) do
          # setup paths for local 'tuned' and test cookbooks for recipe less LWRP 'tuned_profile'
          # step into 'tuned_profile' LWRP
          ChefSpec::SoloRunner.new(step_into: ['tuned_profile']).converge(described_recipe)
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

        it 'creates resource :default tuned_profile[default]' do
          expect(chef_run).to recommended_tuned_profile('default')
        end

        it 'enables recommeneded tuned profile via execute' do
          expect(chef_run).to run_execute('tuned-adm recommend|xargs -r tuned-adm profile')
        end
      end
    end
  end
end
