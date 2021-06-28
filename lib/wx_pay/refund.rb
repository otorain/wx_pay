

module WxPay
  class Refund
    def self.decrypt(info)
      aes = OpenSSL::Cipher::AES.new('256-ECB')
      aes.decrypt
      aes.key = Digest::MD5.hexdigest(WxPay.key)
      result = aes.update(Base64.decode64(info)) + aes.final
      Hash.from_xml(result)["root"]
    end
  end
end