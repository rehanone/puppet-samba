## 3.1.0 (June 28, 2024)

**Features:**

- Updated os support matrix.
- Add 'samba::additional_config' option. ([#52](https://github.com/rehanone/puppet-samba/pull/52); [parkr](https://github.com/parkr))
- Allow puppetlabs-stdlib 9.x. ([#51](https://github.com/rehanone/puppet-samba/pull/51); [parkr](https://github.com/parkr))
- Remove custom types in favor of Puppetlabs Stdlib Stdlib::Ensure::Package. ([#50](https://github.com/rehanone/puppet-samba/pull/50); [bschonec](https://github.com/bschonec))
- Update parameters to samba.org defaults. ([#49](https://github.com/rehanone/puppet-samba/pull/49); [bschonec](https://github.com/bschonec))

## 3.0.0 (February 10, 2024)

**Features:**

This is a major release after a long while. The main reason for not being able to create a new release was two folds.
Firstly, the `pdk` in the latest releases has become almost unworkable (maybe it is my lack of understanding, but I do
not have the time commitment required to keep up with what is going on in there!). The second is the tests for this module
that were largely dependent on [TravisCI](https://app.travis-ci.com/github/rehanone/puppet-samba?serverType=git) which has
not been very kind to free and open source project of late. Without the ability to run any kind of tests, it was impossible
to merge further changes.

Well, most of that has been addressed to some extent in this release by very generous work of [bschonec](https://github.com/bschonec)
over the past few weeks. One of the main changes in this release is [#43](https://github.com/rehanone/puppet-samba/pull/43).
Not all integration tests are fully migrated yet but this is a good starting point.

Other notable changes in this release are:

- Adding obey pam restrictions param. ([#36](https://github.com/rehanone/puppet-samba/pull/36); [welchnut](https://github.com/welchnut))
- Change ntlm_auth variable to a Variant and change its default value. ([#40](https://github.com/rehanone/puppet-samba/pull/40); [bschonec](https://github.com/bschonec))
- Add parameter descriptions to the class modules. ([#48](https://github.com/rehanone/puppet-samba/pull/48); [bschonec](https://github.com/bschonec))
- Other minor changes.

## 2.0.1 (August 24, 2022)

**Features:**

- Added machine password timeout parameter. ([#29](https://github.com/rehanone/puppet-samba/pull/29); [welchnut](https://github.com/welchnut))
- Added inherit owner and inherit permissions share options. ([#26](https://github.com/rehanone/puppet-samba/pull/26); [casey36901](https://github.com/casey36901))
- Updated os support matrix.
- Updated `pdk` templates.

## 2.0.0 (November 19, 2021)

**Features:**

  - Updated os support matrix.
  - Updated `pdk` templates.
  - Updated minimum `puppet` version to `6.0.0`.
  - Updated dependency versions.
  - Added Debian 11 acceptance tests.

## 1.4.1 (May 6, 2021)

**Features:**

- Updated documentation with usage examples.

## 1.4.0 (May 6, 2021)

**Features:**

  - Added support for openSUSE Leap 15.
  - Added support for Puppet 7.

**Improvements:**

  - Updated `pdk` templates.
  - Updated os support matrix.
  - Added system tests for openSUSE Leap 15.

## 1.3.1 (May 22, 2020)

**Improvements:**

  - Changed default value `encrypt passwords` to undef as it is deprecated in Samba.
  - Updated `pdk` templates.

## 1.3.0 (April 29, 2020)

**Improvements:**

  - Added support for Ubuntu 20.04.
  - Updated `pdk` templates.
  - Apply firewall rules if `ferm` is defined as firewall manager. It uses [ferm](https://forge.puppet.com/puppet/ferm) module for managing `ferm`.

## 1.2.0 (March 12, 2020)

**Improvements:**

  - `samba::ntlm_auth param`

  This allows enabling NTLMv1 authentication which nowadays is
  disabled by default due to being insecure. However, some users may
  require this for backwards compatibility, e.g., Sonos does not
  support NTLMv2 or any other choice for that matter.
  ([#12](https://github.com/rehanone/puppet-samba/pull/12); jflorian)

**Bugfixes:**

  - README uses bogus param extra_global_options. ([#12](https://github.com/rehanone/puppet-samba/pull/12); jflorian)
  - README uses bogus param selinux_enable_home_dirs. ([#12](https://github.com/rehanone/puppet-samba/pull/12); jflorian)
  - README is wrong for samba::shares usage. ([#12](https://github.com/rehanone/puppet-samba/pull/12); jflorian)

  The `samba::share` define expects these params as a hash. Furthermore,
  it expects proper Boolean values instead of `yes/no` strings.

## 1.1.0 (February 13, 2020)

**Improvements:**

  - Added support for CentOS 8.
  - Updated os support matrix.
  - Updated `pdk` templates.

## 1.0.0 (August 25, 2019)

**Features:**

  - Initial release
