### 0.6.1 (Next)

*   Your contribution here.

### 0.6.0 (2023/12/15)

*   Add Residential Delivery Indicator (rdi) to `TaxCloud::Address` on successful address verification - @nononoy.

### 0.5.0 (2023/7/21)

*   Update README, CHANGELOG, and LICENSE from RDoc to Markdown -
    @brchristian.
*   Migrate from Travis CI to GitHub Actions -
    @rchekaluk.
*   Update WSDL endpoint URL as recommended by TaxCloud to
    https://api.taxcloud.com/1.0/?wsdl - @mrmarcondes.


### 0.4.0 (2020/12/7)

*   Add `open_timeout` and `read_timeout` options into configuration -
    @ka8725.
*   Switch to using BigDecimal for `tax_amount` to avoid floating point
    arithmetic errors - @paulhenrich.
*   Require ruby 2.6.0+
*   Upgrade to rubocop latest
    *   Add `TargetRubyVersion: 2.6` to rubocop config (based on
        https://www.ruby-lang.org/en/downloads/branches/ oldest "normal
        maintenance" version)
    *   Add `required_ruby_version` to gemspec
    *   addresses rubocop violations

*   Update WSDL endpoint URL as recommended by TaxCloud to
    https://asmx.taxcloud.com/1.0/?wsdl - @brchristian.


### 0.3.0 (2014/1/9)

*   #19: Support Savon 2 - @drewtempelmeyer.
*   Implemented Rubocop, Ruby style linter - @dblock.
*   Ruby 1.8.7 and 1.9.2 are no longer supported - @dblock.


### 0.2.2 (2013/4/29)

*   Relaxed thirdparty gem dependency versions - @mperham.


### 0.2.1 (2013/3/3)

*   Fixed date formatting in API requests with localized applications -
    @soulcutter.


### 0.2.0 (2012/11/26)

*   The gem is now licensed under the MIT license - @dblock.
*   Raise specialized configuration and SOAP errors - @dblock.
*   Added `TaxCloud::Client.ping` - @dblock.
*   Returning a verified `TaxCloud::Address` from `TaxCloud::Address.verify` -
    @dblock.
*   Added `TaxCloud::Address.zip` that returns a 9-digit address zip code,
    when available - @dblock.
*   Returning a `TaxCloud::Responses::Lookup` from
    `TaxCloud::Transaction.lookup` - @dblock.
*   Returning transaction state, ie. `"OK"` from all other TaxCloud
    transactions. Exceptions are raised on error - @dblock.
*   Added support for tax codes and tax code groups lookup with
    `TaxCloud::TaxCodes` and `TaxCloud::TaxCode::Groups` - @dblock.


### 0.1.5 (2012/5/9)

*   Fixed compatibility with Ruby 1.8.7 and 1.9.3, removed super from
    constructors for classes which inherit from `Object` - @gfmurphy.


### 0.1.4 (2011/10/20)

*   Upgraded rdoc - @drewtempelmeyer.
*   Fixed `.gemspec` dependency declaration for savon - @drewtempelmeyer.


### 0.1.3 (2011/9/19)

*   Added support for the "returned" request - @danielmorrison.
*   Refactoreted tests to use vcr and webmock - @danielmorrison.


### 0.1.0 (2011/8/23)

*   Initial public release - @drewtempelmeyer.

