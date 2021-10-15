module Api
  module V1
    class AuthsController < BaseController
      def sign_in
        user = User.find_by(email: params[:email])

        if user.present? && user.authenticate(params[:password])
          render_json(
            success: true,
            result: {
              auth_token: JsonWebToken.encode(user_id: user.id)
            }
          )
        else
          render_json(
            success: false,
            message: 'Invalid Credentials'
          )
        end
      end
    end
  end
end
