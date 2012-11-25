namespace :tax_cloud do

  desc "Generate tax codes."
  task :tax_codes => :configure do
    filename = "lib/tax_cloud/tax_code_constants.rb"
    File.open filename, "wt" do |f|
      
      f.write "module TaxCloud\n"
      f.write "  class TaxCodes\n"
      f.write "\n"

      TaxCloud::TaxCode::Groups.all.values.each do |group|
        f.write "    \# #{group.description}\n"
        group.tax_codes.values.each do |tic|
          code = tic.description.upcase
          code.gsub! /[^A-Z0-9]/, '_'
          code.gsub! /_$/, ''
          code.gsub! /\_+/, '_'
          f.write "    #{code} = #{tic.ticid} \# #{tic.description}\n"
        end
        f.write "\n"
      end

      f.write "  end\n"
      f.write "end\n"
    end
    puts "Done, #{filename}."
  end

end