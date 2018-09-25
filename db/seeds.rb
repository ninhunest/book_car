arrRole = ["admin","lai_xe","nguoi_dung"]
arrRole.each do |name|
  Role.create!(name:  name)
end
