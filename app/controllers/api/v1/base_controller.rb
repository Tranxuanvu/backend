module Api
  module V1
    class BaseController < ActionController::API
      include Pagy::Backend
      include Response
      include ExceptionHandler

      before_action :prepare_login_user

      attr_reader :current_user

      private

      def prepare_login_user
        @current_user = Authorize.new(request.headers).call
      end

      def authorize_user!
        raise AuthenticationError if @current_user.blank?
      end
    end
  end
end
