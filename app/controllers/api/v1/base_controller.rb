module Api
  module V1
    class BaseController < ActionController::API
      include Response
    end
  end
end
