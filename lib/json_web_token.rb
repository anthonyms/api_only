class JsonWebToken
  class << self
    def encode(payload, expiry = 1.hours.from_now)
      payload[:expiry] = expiry.to_i
      JWT.encode(payload, Rails.application.secrets.secret_key_base)
    end

    def decode(token)
      body = JWT.decode(token, Rails.application.secrets.secret_key_base)[0]
      HashWithIndifferentAccess.new body
    rescue => ex
      nil
    end
  end
end