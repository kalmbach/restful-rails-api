module Api
  class RepositoriesController < Api::BaseController

    private

      def repository_params
        params.require(:repository).permit(:name, :description, :user_id)
      end

      def query_params
        params.permit(:user_id, :name, :description)
      end
  end
end
