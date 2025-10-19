User.find_or_create_by!(email: "admin@example.com") do |u|
  u.password = "admin123"
  u.password_confirmation = "admin123"
  u.role = :admin
end
