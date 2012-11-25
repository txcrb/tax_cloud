module TaxCloud
  class TaxCodes

    GENERAL = 00000

    # SHIPPING AND ADMINISTRATIVE
    GIFT_CARD = 10005
    SERVICE_FEE = 10010
    INSTALLATION_FEE = 10040
    TRADE_IN_VALUE = 10060
    TELECOM = 10070
    HANDLING_FEE = 11000
    POSTAGE = 11010
    DMAIL_HANDLING_FEE = 11020
    DMAIL_TRANSPORTATION = 11021
    DMAIL_POSTAGE = 11022

    # CLOTHING, SPORTS, AND ACCESSORIES
    CLOTHING = 20010
    ESSENTIAL_CLOTHING = 20015
    CLOTHING_ACCESSORY = 20020
    PROTECTIVE_EQUIPMENT = 20030
    SPORT_EQUIPMENT = 20040
    FUR_CLOTHING = 20050
    CLOTHING_TAX_HOLIDAY = 20130
    SCHOOL_SUPPLY = 20070

    DISASTER_PREPAREDNESS_SUPPLY = 20150

    # COMPUTERS, ELECTRONICS, AND APPLIANCES
    ENERGY_STAR_APPLIANCE = 20060
    CUSTOM_SOFTWARE = 30015
    SOFTWARE = 30040
    COMPUTER = 30100
    DIGITAL_PRODUCT = 31000

    # FOOD RELATED
    CANDY = 40010
    DIETARY_SUPPLEMENT = 40020
    FOOD = 40030
    VENDING_FOOD = 40040
    SOFT_DRINK = 40050
    BOTTLED_WATER = 40060
    PREPARED_FOOD = 41000
    BULK_FOOD__FROM_MANUFACTURER = 41010
    BULK_FOOD = 41020
    BAKERY_ITEM = 41030

    # MEDICAL AND HYGENE RELATED

    class << self

      # All TICs.
      def all
        @tax_codes ||= begin
          response = TaxCloud.client.request :get_ti_cs
          tax_codes = TaxCloud::Responses::TaxCodes.parse response
          Hash[tax_codes.map { |tic| [ tic.ticid, tic ] }]
        end
      end

      # Lookup a tax code by ID.
      def [](ticid)
        all[ticid]
      end

    end

  end
end
