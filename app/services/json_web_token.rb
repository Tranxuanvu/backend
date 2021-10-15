class JsonWebToken
  HMAC_SECRET = Rails.application.credentials.secret_key_base.to_s

  class << self
    def encode(payload, exp = 24.hours.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, HMAC_SECRET)
    end

    def decode(token = '')
      HashWithIndifferentAccess.new(JWT.decode(token, HMAC_SECRET)[0])
    rescue JWT::DecodeError, JWT::ExpiredSignature, JWT::VerificationError
      HashWithIndifferentAccess.new
    end
  end
end
