require 'spec_helper'

describe 'samba::share' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      let :pre_condition do
        'class { "samba": }'
      end

      context 'with boolean true as a value', :compile do
        let(:title) { 'APPS' }
        let(:params) do
          {
            comment: 'Apps',
            path: '/pool/data',
            writable: true,
            available: false,
            browseable: true,
            valid_users: ['ray', 'penny'],
          }
        end

        it {
          is_expected.to contain_augeas('APPS-section').with(
            'incl' => '/etc/samba/smb.conf',
            'lens' => 'Samba.lns',
            'context' => '/files/etc/samba/smb.conf',
            'changes' => 'set target[. = \'APPS\'] \'APPS\'',
          )
        }

        it {
          is_expected.to contain_samba__option('APPS-comment').with_key('comment').with_value('Apps')
          is_expected.to contain_samba__option('APPS-path').with_key('path').with_value('/pool/data')
          is_expected.to contain_samba__option('APPS-writable').with_key('writable').with_value(true)
          is_expected.to contain_samba__option('APPS-available').with_key('available').with_value(false)
          is_expected.to contain_samba__option('APPS-browseable').with_key('browseable').with_value(true)
          is_expected.to contain_samba__option('APPS-valid users').with_key('valid users').with_value(['ray', 'penny'])
        }

        it {
          is_expected.to have_samba__option_resource_count(59)
        }
      end
    end
  end
end
