json.repositories @repositories do |repository|
  json.id repository.id
  json.name repository.name
end
json.partial! 'api/shared/pagination', data: @repositories
