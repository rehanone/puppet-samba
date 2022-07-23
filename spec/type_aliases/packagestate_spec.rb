require 'spec_helper'

if Puppet::Util::Package.versioncmp(Puppet.version, '4.5.0') >= 0
  describe 'Samba::PackageState' do
    describe 'accepts package state in one of the following' do
      ['present', 'absent', 'purged', 'disabled', 'installed', 'latest'].each do |value|
        describe value.inspect do
          it { is_expected.to allow_value(value) }
        end
      end
    end

    describe 'rejects other values' do
      [
        [],
        {},
        'ensure',
        true,
        'install',
        'update',
      ].each do |value|
        describe value.inspect do
          it { is_expected.not_to allow_value(value) }
        end
      end
    end
  end
end
