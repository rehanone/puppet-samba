# To check the correct dependencies are set up for samba.

require 'spec_helper'
describe 'samba' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it {
        is_expected.to compile.with_all_deps
      }

      describe 'Testing the dependencies between the classes' do
        it { is_expected.to contain_class('samba::install') }
        it { is_expected.to contain_class('samba::config') }
        it { is_expected.to contain_class('samba::service') }
        it { is_expected.to contain_class('samba::firewall') }

        it { is_expected.to contain_class('samba::install').that_comes_before('Class[samba::config]') }
        it { is_expected.to contain_class('samba::config').that_comes_before('Class[samba::service]') }
        it { is_expected.to contain_class('samba::service').that_comes_before('Class[samba::firewall]') }
      end
    end
  end
end
