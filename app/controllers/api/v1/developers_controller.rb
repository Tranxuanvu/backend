module Api
  module V1
    class DevelopersController < BaseController
      before_action :authorize_user!
      before_action :prepare_developer, only: %i[show update destroy]

      def index
        pagy, developers = pagy(Developer.includes(:projects).order(:first_name, :last_name))

        render_json(
          success: true,
          result: DeveloperSerializer.new(developers),
          pagy: render_pagy(pagy)
        )
      end

      def create
        developer_service = Developers::CreatorService.new(developer_params)

        if developer_service.call
          render_json(
            success: true,
            message: "#{action_name.capitalize} successfully."
          )
        else
          render_json(
            success: false,
            message: developer_service.error
          )
        end
      end

      def update
        developer_service = Developers::UpdaterService.new(@developer, developer_params)

        if developer_service.call
          render_json(
            success: true,
            message: "#{action_name.capitalize} successfully."
          )
        else
          render_json(
            success: false,
            message: developer_service.error
          )
        end
      end

      def destroy
        if @developer.destroy
          render_json(
            success: true,
            message: "#{action_name.capitalize} successfully."
          )
        else
          render_json(
            success: false,
            message: @developer.errors.full_messages.to_sentence
          )
        end
      end

      private

      def developer_params
        params.require(:developer).permit(
          :first_name,
          :last_name,
          project_ids: []
        )
      end

      def prepare_developer
        @developer = Developer.find(params[:id])
      end
    end
  end
end
