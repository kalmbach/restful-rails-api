module Api
  class UsersControllerTest < ActionController::TestCase
    test "get index should respond with a 200" do
      get :index, { format: :json }
      assert_response 200
    end

    test "get index should respond with a json representation of the users" do
      get :index, { format: :json }
      assert_equal @response.body,
        { users:
          [
            { id: users(:john).id, username: users(:john).username },
            { id: users(:jane).id, username: users(:jane).username }
          ],
          page_count: 2, total_count: 2, current_page: 1, total_pages: 1
        }.to_json
    end

    test "get show should respond with a 200" do
      get :show, { format: :json, id: 1 }
      assert_response 200
    end

    test "get show should respond with a 404 when record doesn't exists" do
      get :show, { format: :json, id: 3 }
      assert_response 404
    end

    test "get show sould respond with a json representation of the user" do
      get :show, { format: :json, id: 1 }
      assert_equal @response.body,
        { user:
          {
            id: users(:john).id,
            username: users(:john).username,
            email: users(:john).email
          }
        }.to_json
    end

    test "post create should respond with a 201" do
      post :create, { format: :json, user: { username: 'test', email: 'test@email.com' }}
      assert_response 201
    end

    test "post create should respond with a 422 when validation fails" do
      post :create, { format: :json, user: { email: 'test@email.com' }}
      assert_response 422
    end

    test "post create should create a new user" do
      assert_difference('User.count') do
        post :create, { format: :json, user: { username: 'test', email: 'test@email.com' }}
      end
    end

    test "patch update should respond with a 204" do
      patch :update, { format: :json, id: 1, user: { username: 'test' }}
      assert_response 204
    end

    test "patch update should respond with a 422 when validation fails" do
      post :create, { format: :json, id: 1, user: { username: nil  }}
      assert_response 422
    end

    test "patch update should update the user" do
      patch :update, { format: :json, id: 1, user: { username: 'test' }}
      assert_equal User.find(1).username, 'test'
    end

    test "delete destroy should respond with a 204" do
      delete :destroy, { format: :json, id: 1 }
      assert_response 204
    end

    test "delete destroy should delete the user" do
      assert_difference('User.count', -1) do
        delete :destroy, { format: :json, id: 1 }
      end
    end
  end
end
