class JwtService
  class << self
    def encode(payload)
      payload['exp'] = expired_time

      JWT.encode(payload, secret)
    end

    def decode(token)
      JWT.decode(token, secret).first
    rescue StandardError
      nil
    end

    private

    def secret
      Rails.application.secrets.secret_key_base
    end

    def expired_time
      2.weeks.from_now.to_i
    end
  end
end
