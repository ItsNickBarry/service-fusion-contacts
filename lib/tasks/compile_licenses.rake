task :compile_licenses do
  output = 'public/LICENSE.txt'

  `npx yarn licenses generate-disclaimer --silent > #{ output }`

  additional_licenses = <<-HERE

-----

beige-tiles.png and irongrip.png released under the CC BY-SA 3.0 license, which can be found at https://creativecommons.org/licenses/by-sa/3.0/legalcode.
  HERE

  `echo "#{ additional_licenses }" >> #{ output }`
end
