##
# An example of doing a tax lookup that hits TaxCloud.  To run:
#
# bundle exec ruby lookup_example.rb
#
# Make sure you copy the .env.example to .env an update the
# values in it before running.  I also recommend no running
# this script against a live TaxCloud site.  Run it only against
# test sites.
##

require 'dotenv/load'
require 'securerandom'

require_relative '../lib/tax_cloud'

##
# Load the TaxCloud settings from the environment file.\
#
def load_config
  TaxCloud.configure do |config|
    config.api_login_id = ENV['TAX_CLOUD_LOGIN_ID']
    config.api_key = ENV['TAX_CLOUD_API_KEY']
    config.open_timeout = 10
    config.read_timeout = 10
  end
end

##
# Display the current TaxCloud settings.
#
def display_config
  TaxCloud.configure do |config|
    puts "API Login ID: #{config.api_login_id}"
    puts "API Key: #{config.api_key}"
    puts "Open timeout: #{config.open_timeout}"
    puts "Read timeout: #{config.read_timeout}"
  end
end

##
# Create a test transaction with one cart item.
#
# Will create a new customer and cart each time using GUIDs for
# the customer and cart IDs.  This prevents collisions with
# existing customer/carts when running the script multiple times.
#
def create_test_transaction
  origin = TaxCloud::Address.new(
      :address1 => '162 East Avenue',
      :address2 => 'Third Floor',
      :city => 'Norwalk',
      :state => 'CT',
      :zip5 => '06851')

  destination = TaxCloud::Address.new(
      :address1 => '3121 West Government Way',
      :address2 => 'Suite 2B',
      :city => 'Seattle',
      :state => 'WA',
      :zip5 => '98199')

  transaction = TaxCloud::Transaction.new(
      :customer_id => SecureRandom.uuid,
      :cart_id => SecureRandom.uuid,
      :origin => origin,
      :destination => destination)

  transaction.cart_items << TaxCloud::CartItem.new(
      :index => 0,
      :item_id => 'SKU-100',
      :tic => TaxCloud::TaxCodes::GENERAL,
      :price => 10.00,
      :quantity => 1)

  transaction
end

##
# Displays information about the transaction:
#
# - Customer ID
# - Cart ID
# - Origin Address
# - Destination Address
# - Cart Items
#
# @param [TaxCloud::Transaction] transaction
#
def display_transaction(transaction)
  puts "Customer ID: #{transaction.customer_id}"
  puts "Cart ID: #{transaction.cart_id}"
  puts "Origin: #{transaction.origin.to_hash}"
  puts "Destination: #{transaction.destination.to_hash}"
  puts "Cart Items: #{transaction.cart_items.map(&:to_hash)}"
end

##
# Display the total tax and tax for each cart item.
#
# @param [TaxCloud::Responses::Lookup] lookup
def display_tax(lookup)
  puts "Total tax amount: #{lookup.tax_amount}"

  lookup.cart_items.each do |cart_item|
    puts "Tax cart index #{cart_item.cart_item_index}: #{cart_item.tax_amount}"
  end
end


##
# Run an example lookup
##
puts 'Loading config information from .env file...'
load_config
puts 'Config loaded'
puts

puts 'The TaxCloud config is:'
display_config
puts

puts 'Checking config...'
TaxCloud.configuration.check!
puts 'Check passed.'
puts

puts 'Pinging TaxCloud server...'
puts TaxCloud.client.ping

puts 'Cart values:'
transaction = create_test_transaction
display_transaction(transaction)
puts

puts 'Tax lookup:'
lookup = transaction.lookup
display_tax(lookup)
puts