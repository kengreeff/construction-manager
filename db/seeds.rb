# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Categories
categories = [
  { title: "Finishes & Colours", key: "finishes", category_type: "ProjectItem" },
  { title: "Fixture Fittings & Equipment", key: "fixtures", category_type: "ProjectItem" },
]

categories.each do |category|
  Category.find_or_create_by(key: category[:key]) do |r|
    r.title = category[:title]
    r.category_type = category[:category_type]
  end
end

# Roles
roles = [
  { title: "Admin", key: "admin" },
  { title: "Client User", key: "client_user" },
  { title: "Organization User", key: "organization_user" },
  { title: "User", key: "user" },
]

roles.each do |role|
  Role.find_or_create_by(key: role[:key]) do |r|
    r.title = role[:title]
  end
end

# Suppliers
suppliers = [
  { title: "Other" },
]

suppliers.each do |supplier|
  Supplier.find_or_create_by(title: supplier[:title])
end

# Statuses
statuses = [
  { title: "Approved", key: "approved" },
  { title: "Draft", key: "draft" },
  { title: "In Review", key: "in_review" },
  { title: "Shortlist", key: "shortlist" },
]

statuses.each do |status|
  Status.find_or_create_by(key: status[:key]) do |s|
    s.title = status[:title]
  end
end
