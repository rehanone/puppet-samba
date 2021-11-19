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
