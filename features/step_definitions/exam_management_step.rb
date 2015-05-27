Given /the following locations exist/ do |locations_table|
  locations_table.hashes.each do |location|
    Location.create!(location)
  end
end

Given /the following subjects exist/ do |subjects_table|
  subjects_table.hashes.each do |subject|
    Subject.create!(subject)
  end
end

Given /the following manages exist/ do |subjects_table|
  subjects_table.hashes.each do |subject|
   Manage.create!(subject)
  end
end