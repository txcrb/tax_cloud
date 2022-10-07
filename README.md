# TaxCloud

[![Build Status](https://github.com/txcrb/tax_cloud/actions/workflows/test.yml/badge.svg?branch=master)](https://github.com/txcrb/tax_cloud/actions)

[TaxCloud](http://www.taxcloud.com) is a free service to calculate sales tax
and generate tax reports. The `tax_cloud` gem allows you to easily integrate
with TaxCloud's API.

### Getting Started
Create a [TaxCloud](http://www.taxcloud.com) merchant account at
http://www.taxcloud.net. Add a website to your account under
[Locations](https://taxcloud.net/account/locations). This will generate an API
ID and API Key that you will need to use the service.

[TaxCloud](http://www.taxcloud.com) also offers an optional address
verification API. To use it, you need a USPS (United States Postal Service)
Address API Username. To obtain your USPS Username:
1.  Go through the Web Tools API Portal registration process at
    https://registration.shippingapis.com/
2.  Once you have registered for your account, you will receive an email with
    your USPS username and password.
3.  Enter your USPS username in your TaxCloud initializer (see below).


### Setup
Add the gem to your Gemfile.

```ruby
gem 'tax_cloud'
```

Configure your environment. For example, create an initializer in Rails in
`config/initializers/tax_cloud.rb`.

```ruby
TaxCloud.configure do |config|
  config.api_login_id = 'your_tax_cloud_api_login_id'
  config.api_key = 'your_tax_cloud_api_key'
  config.usps_username = 'your_usps_username' # optional
  config.open_timeout = 1 # optional
  config.read_timeout = 1 # optional
end
```

The `open_timeout` and `read_timeout` options are used to specify waiting time
for the TaxCloud web service response in seconds. Default values:
`open_timeout = 2` and `read_timeout = 2`.

### Using TaxCloud
Define the destination and origin addresses using `TaxCloud::Address`.

```ruby
origin = TaxCloud::Address.new(
  address1: '162 East Avenue',
  address2: 'Third Floor',
  city: 'Norwalk',
  state: 'CT',
  zip5: '06851'
)
destination = TaxCloud::Address.new(
  address1: '3121 West Government Way',
  address2: 'Suite 2B',
  city: 'Seattle',
  state: 'WA',
  zip5: '98199'
)
```

Create your Transaction and set up your cart items

```ruby
transaction = TaxCloud::Transaction.new(
  customer_id: '1',
  cart_id: '1',
  origin: origin,
  destination: destination
)
transaction.cart_items << TaxCloud::CartItem.new(
  index: 0,
  item_id: 'SKU-100',
  tic: TaxCloud::TaxCodes::GENERAL,
  price: 10.00,
  quantity: 1
)
lookup = transaction.lookup # this will return a TaxCloud::Responses::Lookup instance
lookup.tax_amount # total tax amount
lookup.cart_items.each do |cart_item|
  cart_item.tax_amount # tax for a single item
end
```

After you've authorized and captured the transaction via your merchant
account, you should do the same with TaxCloud for maintaining accurate tax
information.

```ruby
transaction.order_id = 100
transaction.authorized_with_capture # returns "OK" or raises an error
```

Later, you may need to mark some cart items as returned. TaxCloud will ignore
any cart items that you don't include.

```ruby
transaction.order_id = 100
transaction.cart_items << TaxCloud::CartItem.new(
  index: 0,
  item_id: 'SKU-100',
  tic: TaxCloud::TaxCodes::GENERAL,
  price: 10.00,
  quantity: 1
)
transaction.returned # returns "OK" or raises an error
```

### Verifying Addresses

[TaxCloud](http://www.taxcloud.com) optionally integrates with the USPS
Address API. An address can be verified, which can also yield a 9-digit zip
code that helps determine a more accurate tax rate.

```ruby
address = TaxCloud::Address.new({
                                  address1: '888 6th Ave',
                                  city: 'New York',
                                  state: 'New York',
                                  zip5: '10001'
                                })

verified_address = address.verify
verified_address.zip5 # 10001
verified_address.zip4 # 3502
verified_address.zip # 10001-3502
```

### Tax Codes
[TaxCloud](http://www.taxcloud.com) maintains a list of all Taxability
Information Codes or TICs, which can be found at https://taxcloud.net/tic.

You can obtain all tax codes as well as lookup a tax code by ID.

```ruby
TaxCloud::TaxCodes.all # a hash of all codes
tax_code = TaxCloud::TaxCodes[TaxCloud::TaxCodes::DIRECT_MAIL_RELATED]
tax_code.ticid # 11000 or TaxCloud::TaxCodes::DIRECT_MAIL_RELATED
tax_code.description # "Direct-mail related"
```

Tax codes are organized in groups.

```ruby
TaxCloud::TaxCode::Groups.all # a hash of all groups
tax_code_group = TaxCloud::TaxCode::Groups[TaxCloud::TaxCode::Groups::SCHOOL_RELATED_PRODUCTS]
tax_code_group.group_id # 3 or TaxCloud::TaxCode::Groups::SCHOOL_RELATED_PRODUCTS
tax_code_group.description # School Related Products
tax_code_group.tax_codes # a hash of all codes in this group
```

Tax code constants are defined in `tax_code_constants.rb` and tax code group
constants in `tax_code_group_constants.rb`. These files can be generated by
running the following rake tasks.

```
TAXCLOUD_API_LOGIN_ID=... TAXCLOUD_API_KEY=... TAXCLOUD_USPS_USERNAME=... tax_cloud:tax_codes
TAXCLOUD_API_LOGIN_ID=... TAXCLOUD_API_KEY=... TAXCLOUD_USPS_USERNAME=... tax_cloud:tax_code_groups
```

### Tax States
TaxCloud manages a list of states in which you can calculate sales tax. The
default setup will only have SSUTA (Streamlined Sales and Use Tax Agreement)
states enabled. All other states will return $0 for tax values. To enable
other states, go to https://taxcloud.com/go/states-management/. You can find
more information about SSUTA
[here](http://www.streamlinedsalestax.org/index.php?page=About-Us).

### Running Tests
*   VCR and WebMock are used to replay requests and avoid hitting the API each
    time. To refresh the mocks, simply delete the `test/cassettes` directory.
*   Run tests.
        rake test

*   If you need to record new requests against TaxCloud, set your keys first.
        TAXCLOUD_API_LOGIN_ID=... TAXCLOUD_API_KEY=... TAXCLOUD_USPS_USERNAME=... rake test

    The mocks will filter out your configuration details.


### Bugs, fixes, etc
*   Fork.
*   Write test(s).
*   Fix.
*   Commit.
*   Submit pull request.


### License

Copyright Drew Tempelmeyer and contributors, 2011-2020.

This gem is licensed under the MIT license.
