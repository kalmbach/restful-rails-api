module Api
  class RepositoriesControllerTest < ActionController::TestCase
    test "get index should respond with a 200" do
      get :index, { format: :json }
      assert_response 200
    end

    test "get index should respond with a json representation of the repositories" do
      get :index, { format: :json }
      assert_equal @response.body,
        { repositories:
          [
            { id: repositories(:one).id, name: repositories(:one).name },
            { id: repositories(:two).id, name: repositories(:two).name }
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

    test "get show sould respond with a json representation of the repository" do
      get :show, { format: :json, id: 1 }
      assert_equal @response.body,
        { repository:
          {
            id: repositories(:one).id,
            name: repositories(:one).name,
            description: repositories(:one).description
          }
        }.to_json
    end

    test "post create should respond with a 201" do
      post :create, { format: :json, repository: { name: 'test', description: 'test', user_id: 1 }}
      assert_response 201
    end

    test "post create should respond with a 422 when validation fails" do
      post :create, { format: :json, repository: { description: 'test' }}
      assert_response 422
    end

    test "post create should create a new repository" do
      assert_difference('Repository.count') do
        post :create, { format: :json, repository: { name: 'test', description: 'test', user_id: 1 }}
      end
    end

    test "patch update should respond with a 204" do
      patch :update, { format: :json, id: 1, repository: { name: 'test' }}
      assert_response 204
    end

    test "patch update should respond with a 422 when validation fails" do
      post :create, { format: :json, id: 1, repository: { name: nil  }}
      assert_response 422
    end

    test "patch update should update the repository" do
      patch :update, { format: :json, id: 1, repository: { name: 'test' }}
      assert_equal Repository.find(1).name, 'test'
    end

    test "delete destroy should respond with a 204" do
      delete :destroy, { format: :json, id: 1 }
      assert_response 204
    end

    test "delete destroy should delete the repository" do
      assert_difference('Repository.count', -1) do
        delete :destroy, { format: :json, id: 1 }
      end
    end
  end
end
