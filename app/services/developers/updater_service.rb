module Developers
  class UpdaterService
    attr_reader :error

    def initialize(developer, params)
      @params = params
      @developer = developer
    end

    def call
      if @params[:project_ids].blank?
        @error = 'Developer must be assigned to at least one project'

        return
      end

      updated = @developer.update_attributes(@params)

      @error = @developer.errors.full_messages.to_sentence unless updated

      updated
    end
  end
end
