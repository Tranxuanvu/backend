module Api
  module V1
    class TechnologiesController < BaseController
      before_action :authorize_user!
      before_action :prepare_technology, only: %i[update destroy]
      before_action :valid_delete, only: %i[destroy]

      def index
        pagy, technologies = pagy(Technology.order(:id))

        render_json(
          success: true,
          result: TechnologySerializer.new(technologies),
          pagy: render_pagy(pagy)
        )
      end

      def create
        technology = Technology.new(technology_params)

        if technology.save
          render_json(
            success: true,
            message: "#{action_name.capitalize} successfully."
          )
        else
          render_json(
            success: false,
            message: technology.errors.full_messages.to_sentence
          )
        end
      end

      def update
        if @technology.update_attributes(technology_params)
          render_json(
            success: true,
            message: "#{action_name.capitalize} successfully."
          )
        else
          render_json(
            success: false,
            message: @technology.errors.full_messages.to_sentence
          )
        end
      end

      def destroy
        if @technology.destroy
          render_json(
            success: true,
            message: "#{action_name.capitalize} successfully."
          )
        else
          render_json(
            success: false,
            message: "#{action_name.capitalize} unsuccessfully."
          )
        end
      end

      private

      def technology_params
        params.require(:technology).permit(:name)
      end

      def prepare_technology
        @technology = Technology.find(params[:id])
      end

      def valid_delete
        return if @technology.present? && @technology.projects.blank?

        render_json(
          success: false,
          message: 'Technology assigned to the project cannot be deleted.'
        )
      end
    end
  end
end
