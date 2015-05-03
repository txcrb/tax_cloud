namespace :tax_cloud do
  desc 'Generate tax codes.'
  task tax_codes: :configure do
    filename = 'lib/tax_cloud/tax_code_constants.rb'

    begin
      groups = TaxCloud::TaxCode::Groups.all.values
      groups_and_tax_codes = Hash[groups.map do |group|
        [group, group.tax_codes.values]
      end]
      File.open filename, 'wt' do |f|
        f.write "module TaxCloud\n"
        f.write "  # Tax Codes.\n"
        f.write "  class TaxCodes\n"
        f.write "\n"
        codes = {}
        groups_and_tax_codes.each_pair do |group, tax_codes|
          puts " #{group.description}"
          f.write "    \# #{group.description}\n\n"
          tax_codes.each do |tax_code|
            code = tax_code.description.upcase
            code.gsub! /[^A-Z0-9]/, '_'
            code.gsub! /\_+$/, ''
            code.gsub! /\_+/, '_'
            # avoid duplicates
            code_id = codes[code] ? "#{code}_#{codes[code]}" : code
            codes[code] = (codes[code] || 0) + 1
            f.write "    \# #{group.description}: #{tax_code.description}\n"
            f.write "    #{code_id} = #{tax_code.ticid}\n"
          end
          f.write "\n"
        end
        f.write "  end\n"
        f.write "end\n"
      end
      puts "Done, #{filename}."
    rescue => e
      puts 'ERROR: Unable to generate a new list of tax codes.'
      puts e.message
      raise e
    end
  end
end
