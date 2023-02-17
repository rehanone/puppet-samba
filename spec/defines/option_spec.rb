require 'spec_helper'

describe 'samba::option' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let :pre_condition do
        'class { "samba": }'
      end

      context 'with boolean true as a value', :compile do
        let(:title) { 'test' }
        let(:params) { { key: 'foo', value: true } }

        it {
          is_expected.to contain_augeas('samba option (test=yes)').with(
            'incl' => '/etc/samba/smb.conf',
            'lens' => 'Samba.lns',
            'changes' => 'set "target[. = "global"]/foo" "yes"',
          )
        }
      end

      context 'with boolean false as a value', :compile do
        let(:title) { 'test' }
        let(:params) { { key: 'foo', value: false } }

        it {
          is_expected.to contain_augeas('samba option (test=no)').with(
            'incl' => '/etc/samba/smb.conf',
            'lens' => 'Samba.lns',
            'changes' => 'set "target[. = "global"]/foo" "no"',
          )
        }
      end

      context 'with integer as a value', :compile do
        let(:title) { 'test' }
        let(:params) { { value: 100 } }

        it {
          is_expected.to contain_augeas('samba option (test=100)').with(
            'incl' => '/etc/samba/smb.conf',
            'lens' => 'Samba.lns',
            'changes' => 'set "target[. = "global"]/test" "100"',
          )
        }
      end

      context 'with string as a value', :compile do
        let(:title) { 'test' }
        let(:params) { { value: 'ssl' } }

        it {
          is_expected.to contain_augeas('samba option (test=ssl)').with(
            'incl' => '/etc/samba/smb.conf',
            'lens' => 'Samba.lns',
            'changes' => 'set "target[. = "global"]/test" "ssl"',
          )
        }
      end

      context 'with an undef as a value', :compile do
        let(:title) { 'test' }
        let(:params) { {} }

        it {
          is_expected.to contain_augeas('samba option (test=)').with(
            'incl' => '/etc/samba/smb.conf',
            'lens' => 'Samba.lns',
            'changes' => 'rm "target[. = "global"]/test"',
          )
        }
      end

      context 'with an empty array as a value', :compile do
        let(:title) { 'test' }
        let(:params) { { value: [] } }

        it {
          is_expected.to contain_augeas('samba option (test=)').with(
            'incl' => '/etc/samba/smb.conf',
            'lens' => 'Samba.lns',
            'changes' => 'rm "target[. = "global"]/test"',
          )
        }
      end

      context 'with an array of strings as a value', :compile do
        let(:title) { 'test' }
        let(:params) { { value: ['ssl', 'tls'] } }

        it {
          is_expected.to contain_augeas('samba option (test=ssl tls)').with(
            'incl' => '/etc/samba/smb.conf',
            'lens' => 'Samba.lns',
            'changes' => 'set "target[. = "global"]/test" "ssl tls"',
          )
        }
      end

      context 'with a hash as a value', :compile do
        let(:title) { 'test' }
        let(:params) { { value: {} } }

        it {
          is_expected.to contain_augeas('samba option (test=ssl tls)').with(
            'incl' => '/etc/samba/smb.conf',
            'lens' => 'Samba.lns',
            'changes' => 'set "target[. = "global"]/test" "ssl tls"',
          )
        }
      end
    end
  end
end
