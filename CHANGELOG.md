# Changelog

## 0.7.1 (Next)

* [#66](https://github.com/txcrb/tax_cloud/pull/66): Link every released CHANGELOG entry to its pull request and author, and check the whole CHANGELOG with danger-changelog - [@dblock](https://github.com/dblock).
* [#67](https://github.com/txcrb/tax_cloud/pull/67): Require new CHANGELOG entries to be added under the unreleased section again, and skip Danger comments when there is nothing to report - [@dblock](https://github.com/dblock).
* Your contribution here.

## 0.7.0 (2026/11/25)

* [#58](https://github.com/txcrb/tax_cloud/pull/58): Test on Ruby 2.6, 3.4, and 4.0 with current GitHub Actions, unpin Rake, which fails to load on Ruby 4.0, and keep Rack below 3 for httpi on Ruby 2.x - [@dblock](https://github.com/dblock).
* [#59](https://github.com/txcrb/tax_cloud/pull/59): Lint Markdown, YAML, and spelling with rubocop-md, rubocop-prose, rubocop-spellcheck, and rubocop-yaml in a separate Lint workflow, and clean up documentation - [@dblock](https://github.com/dblock).
* [#60](https://github.com/txcrb/tax_cloud/pull/60): Run CI pushes only on the default branch, cancel superseded pull request runs, and bound job times - [@dblock](https://github.com/dblock).
* [#62](https://github.com/txcrb/tax_cloud/pull/62): Release with ruby-gem-release through a manually dispatched GitHub Actions workflow and RubyGems Trusted Publishing - [@dblock](https://github.com/dblock).
* [#64](https://github.com/txcrb/tax_cloud/pull/64): Raise `TaxCloud::Errors::MissingCartItems` when looking up a transaction without cart items - [@dblock](https://github.com/dblock).
* [#65](https://github.com/txcrb/tax_cloud/pull/65): Check pull requests with Danger, including CHANGELOG entries with danger-changelog, and report results in a pull request comment with danger-pr-comment - [@dblock](https://github.com/dblock).

## 0.6.0 (2023/12/15)

* [#57](https://github.com/txcrb/tax_cloud/pull/57): Add Residential Delivery Indicator (rdi) to `TaxCloud::Address` on successful address verification - [@nononoy](https://github.com/nononoy).

## 0.5.0 (2023/7/21)

* [#49](https://github.com/txcrb/tax_cloud/pull/49): Update README, CHANGELOG, and LICENSE from RDoc to Markdown - [@brchristian](https://github.com/brchristian).
* [#54](https://github.com/txcrb/tax_cloud/pull/54): Migrate from Travis CI to GitHub Actions - [@rchekaluk](https://github.com/rchekaluk).
* [#55](https://github.com/txcrb/tax_cloud/pull/55): Update WSDL endpoint URL as recommended by TaxCloud to https://api.taxcloud.com/1.0/?wsdl - [@mrmarcondes](https://github.com/mrmarcondes).

## 0.4.0 (2020/12/7)

* [#25](https://github.com/txcrb/tax_cloud/pull/25): Add `open_timeout` and `read_timeout` options into configuration - [@ka8725](https://github.com/ka8725).
* [#35](https://github.com/txcrb/tax_cloud/pull/35): Switch to using BigDecimal for `tax_amount` to avoid floating point arithmetic errors - [@paulhenrich](https://github.com/paulhenrich).
* [#43](https://github.com/txcrb/tax_cloud/pull/43): Require Ruby 2.6.0+, upgrade RuboCop with `TargetRubyVersion: 2.6`, add `required_ruby_version` to the gemspec, and address RuboCop violations - [@ghepting](https://github.com/ghepting).
* [#45](https://github.com/txcrb/tax_cloud/pull/45): Update WSDL endpoint URL as recommended by TaxCloud to https://asmx.taxcloud.com/1.0/?wsdl - [@brchristian](https://github.com/brchristian).

## 0.3.0 (2014/1/9)

* [#19](https://github.com/txcrb/tax_cloud/issues/19): Support Savon 2 - [@drewtempelmeyer](https://github.com/drewtempelmeyer).
* Implemented RuboCop, Ruby style linter - [@dblock](https://github.com/dblock).
* Ruby 1.8.7 and 1.9.2 are no longer supported - [@dblock](https://github.com/dblock).

## 0.2.2 (2013/4/29)

* [#18](https://github.com/txcrb/tax_cloud/pull/18): Relaxed third-party gem dependency versions - [@mperham](https://github.com/mperham).

## 0.2.1 (2013/3/3)

* [#15](https://github.com/txcrb/tax_cloud/pull/15): Fixed date formatting in API requests with localized applications - [@soulcutter](https://github.com/soulcutter).

## 0.2.0 (2012/11/26)

* [#8](https://github.com/txcrb/tax_cloud/pull/8): The gem is now licensed under the MIT license - [@dblock](https://github.com/dblock).
* [#5](https://github.com/txcrb/tax_cloud/pull/5): Raise specialized configuration and SOAP errors - [@dblock](https://github.com/dblock).
* [#6](https://github.com/txcrb/tax_cloud/pull/6): Added `TaxCloud::Client.ping` - [@dblock](https://github.com/dblock).
* [#6](https://github.com/txcrb/tax_cloud/pull/6): Returning a verified `TaxCloud::Address` from `TaxCloud::Address.verify` - [@dblock](https://github.com/dblock).
* [#13](https://github.com/txcrb/tax_cloud/pull/13): Added `TaxCloud::Address.zip` that returns a 9-digit address zip code, when available - [@dblock](https://github.com/dblock).
* [#6](https://github.com/txcrb/tax_cloud/pull/6): Returning a `TaxCloud::Responses::Lookup` from `TaxCloud::Transaction.lookup` - [@dblock](https://github.com/dblock).
* [#6](https://github.com/txcrb/tax_cloud/pull/6): Returning transaction state, i.e. `"OK"`, from all other TaxCloud transactions and raising exceptions on error - [@dblock](https://github.com/dblock).
* [#7](https://github.com/txcrb/tax_cloud/pull/7): Added support for tax codes and tax code groups lookup with `TaxCloud::TaxCodes` and `TaxCloud::TaxCode::Groups` - [@dblock](https://github.com/dblock).

## 0.1.5 (2012/5/9)

* [#3](https://github.com/txcrb/tax_cloud/pull/3): Fixed compatibility with Ruby 1.8.7 and 1.9.3, removed super from constructors for classes which inherit from `Object` - [@gfmurphy](https://github.com/gfmurphy).

## 0.1.4 (2011/10/20)

* Upgraded RDoc - [@drewtempelmeyer](https://github.com/drewtempelmeyer).
* Fixed `.gemspec` dependency declaration for Savon - [@drewtempelmeyer](https://github.com/drewtempelmeyer).

## 0.1.3 (2011/9/19)

* [#1](https://github.com/txcrb/tax_cloud/pull/1): Added support for the "returned" request - [@danielmorrison](https://github.com/danielmorrison).
* [#1](https://github.com/txcrb/tax_cloud/pull/1): Refactored tests to use VCR and WebMock - [@danielmorrison](https://github.com/danielmorrison).

## 0.1.0 (2011/8/23)

* Initial public release - [@drewtempelmeyer](https://github.com/drewtempelmeyer).
