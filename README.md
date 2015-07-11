Restful Rails API
=================

Reference implementation of a REST API in Rails 4 using a base class that
encapsulates the majority of the API logic.

Requirements
------------
- rails 4
- responders
- jbuilder
- kaminari

About this reference implementation
-----------------------------------
It's an application that has two models, **Users** and **Repositories**,
a user has many repositories and a repository belongs to an user.

The controllers are implemented inheriting the base api class:
```ruby
module Api
  class UsersController < Api::BaseController

    private
      def user_params
        params.require(:user).permit(:username, :email)
      end

      def query_params
        params.permit(:username, :email)
      end
  end
end
```

The data is serialized using **jbuilder** as an ActionView template language,
```ruby
json.users @users do |user|
  json.id user.id
  json.username user.username
end
json.partial! 'api/shared/pagination', data: @users
```

The routes are pretty simple, although we could have excluded the `new` and 
`edit` actions.
```ruby
Rails.application.routes.draw do
  namespace :api do
    resources :users, :repositories
  end
end
```

This is just a very basic implementation, you probably will want to extend it
adding authentication, permissions, fragment caching in the jbuilder views, etc.

Have fun!
