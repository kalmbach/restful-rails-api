json.users @users do |user|
  json.id user.id
  json.username user.username
end
json.partial! 'api/shared/pagination', data: @users
