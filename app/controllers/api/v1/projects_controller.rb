module Api
  module V1
    class ProjectsController < BaseController
      before_action :authorize_user!
      before_action :prepare_project, only: %i[show update destroy]
      before_action :check_valid_update, only: %i[update]

      def index
        pagy, projects = pagy(Project.includes(:technologies, :developers).order(:name))

        render_json(
          success: true,
          result: ProjectSerializer.new(projects),
          pagy: render_pagy(pagy)
        )
      end

      def show
        render_json(
          success: true,
          result: ProjectSerializer.new(projects)
        )
      end

      def create
        project = Project.new(projects_params)

        if project.save
          render_json(
            success: true,
            message: "#{action_name.capitalize} successfully."
          )
        else
          render_json(
            success: false,
            message: project.errors.full_messages.to_sentence
          )
        end
      end

      def update
        if @project.update_attributes(projects_params)
          render_json(
            success: true,
            message: "#{action_name.capitalize} successfully."
          )
        else
          render_json(
            success: false,
            message: @project.errors.full_messages.to_sentence
          )
        end
      end

      def destroy
        if @project.destroy
          render_json(
            success: true,
            message: "#{action_name.capitalize} successfully."
          )
        else
          render_json(
            success: false,
            message: @project.errors.full_messages.to_sentence
          )
        end
      end

      private

      def projects_params
        params.require(:project).permit(
          :name,
          :description,
          :start_date,
          :end_date,
          developer_ids: [],
          technology_ids: []
        )
      end

      def prepare_project
        @project = Project.find(params[:id])
      end

      def check_valid_update
        return if projects_params[:start_date].blank?

        render_json(
          success: false,
          message: 'The project start date cannot be changed.'
        )
      end
    end
  end
end
