class Encryption
  def encode_token(payload)
    JWT.encode(payload, 'haHahaN1ce0neDud3')
  end

  def auth_header
    # { Authorization: 'Bearer <token>' }
    request.headers['Authorization']
  end

  def decoded_token
    return unless auth_header

    token = auth_header.split(' ')[1]
    # header: { 'Authorization': 'Bearer <token>' }
    begin
      JWT.decode(token, 'haHahaN1ce0neDud3', true, algorithm: 'HS256')
    rescue JWT::DecodeError
      nil
    end
  end
end
