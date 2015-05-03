namespace :tax_cloud do
  desc 'Generate tax code groups.'
  task tax_code_groups: :configure do
    filename = 'lib/tax_cloud/tax_code_group_constants.rb'

    begin
      groups = TaxCloud::TaxCode::Groups.all.values

      File.open filename, 'wt' do |f|
        f.write "module TaxCloud\n"
        f.write "  class TaxCode\n"
        f.write "    # Tax Code Groups.\n"
        f.write "    class Groups\n"

        groups.each do |group|
          puts " #{group.description}"
          code = group.description.upcase
          code.gsub! /[^A-Z0-9]/, '_'
          code.gsub! /_$/, ''
          code.gsub! /\_+/, '_'
          f.write "      \# #{group.description}\n"
          f.write "      #{code} = #{group.group_id}\n"
        end

        f.write "    end\n"
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
