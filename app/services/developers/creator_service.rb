module Developers
  class CreatorService
    attr_reader :error

    def initialize(params)
      @params = params
    end

    def call
      if @params[:project_ids].blank?
        @error = 'Developer must be assigned to at least one project'

        return
      end

      developer = Developer.new(@params)
      saved = developer.save

      @error = developer.errors.full_messages.to_sentence unless saved

      saved
    end
  end
end
