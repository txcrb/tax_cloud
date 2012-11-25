namespace :tax_cloud do

  desc "Generate tax code groups."
  task :tax_code_groups => :configure do
    filename = "lib/tax_cloud/tax_code_group_constants.rb"
    File.open filename, "wt" do |f|
      
      f.write "module TaxCloud\n"
      f.write "  class TaxCode\n"
      f.write "   class Groups\n"
      f.write "\n"

      TaxCloud::TaxCode::Groups.all.values.each do |group|
        code = group.description.upcase
        code.gsub! /[^A-Z0-9]/, '_'
        code.gsub! /_$/, ''
        code.gsub! /\_+/, '_'
        f.write "      #{code} = #{group.group_id} \# #{group.description}\n"
      end

      f.write "    end\n"
      f.write "  end\n"
      f.write "end\n"
    end
    puts "Done, #{filename}."
  end

end