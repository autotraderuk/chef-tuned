require './spec/spec_helper'

describe 'test_tuned::create_apply_profile' do
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
          ChefSpec::SoloRunner.new(platform: platform, version: version, step_into: ['tuned_profile']).converge(described_recipe)
        end

        # profile directory is different in EL 6 & 7
        libdir = (version.to_i < 7) ? '/etc/tune-profiles/' : '/usr/lib/tuned/'

        it 'installs tuned' do
          expect(chef_run).to install_package('tuned')
        end

        it 'enables tuned' do
          expect(chef_run).to enable_service 'tuned'
        end

        it 'starts tuned' do
          expect(chef_run).to start_service 'tuned'
        end

        it 'creates resource tuned_profile[default]' do
          expect(chef_run).to create_tuned_profile('default')
        end

        it 'enables resource tuned_profile[default]' do
          expect(chef_run).to enable_tuned_profile('default')
        end

        it 'creates tuned config directory' do
          expect(chef_run).to create_directory(libdir + 'default')
        end

        it 'creates tuned.conf from template' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('[cpu]')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('governor=performance')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('energy_perf_bias=performance')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('min_perf_pct=100')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('[disk]')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('readahead=4096')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('[vm]')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('transparent_hugepage=never')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('transparent_hugepage.defrag=never')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('[sysctl]')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('kernel.sched_min_granularity_ns=10000000')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('kernel.sched_wakeup_granularity_ns=15000000')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('vm.dirty_background_ratio=10')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('vm.dirty_ratio=30')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('vm.swappiness=30')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('[sysfs]')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('sys/kernel/mm/transparent_hugepage/enabled=never')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('sys/kernel/mm/transparent_hugepage/defrag=never')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('[main]')
        end

        it 'populates profile file with attributes from test_tuned cookbook' do
          expect(chef_run).to render_file(libdir + 'default/tuned.conf').with_content('include=latency-performance')
        end

        it 'enables tuned profile via execute' do
          expect(chef_run).to run_execute('tuned-adm profile default')
        end
      end
    end
  end
end
