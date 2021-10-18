module Error
  class RequestError < StandardError; end

  class AuthenticationError < StandardError; end

  class UnprocessableError < StandardError; end
end
