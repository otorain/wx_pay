require 'wx_pay/result'
require 'wx_pay/sign'
require 'wx_pay/service'
require 'wx_pay/version'
require 'openssl'

module WxPay
  @extra_rest_client_options = {}
  @debug_mode = true
  @sandbox_mode = false

  class<< self
    attr_accessor :appid, :mch_id, :key, :appsecret, :extra_rest_client_options, :debug_mode
    attr_accessor :sub_appid, :sub_mchid, :cert_path # 添加前两个是为了适配服务商模式，最后一个是为了适配自定义的类库
    attr_accessor :sandbox_mode, :manual_get_sandbox_key
    attr_reader :apiclient_cert, :apiclient_key

    def set_apiclient_by_pkcs12(str, pass)
      pkcs12 = OpenSSL::PKCS12.new(str, pass)
      @apiclient_cert = pkcs12.certificate
      @apiclient_key = pkcs12.key

      pkcs12
    end

    def apiclient_cert=(cert)
      @apiclient_cert = OpenSSL::X509::Certificate.new(cert)
    end

    def apiclient_key=(key)
      @apiclient_key = OpenSSL::PKey::RSA.new(key)
    end

    def debug_mode?
      @debug_mode
    end

    def sandbox_mode?
      @sandbox_mode
    end

    def manual_get_sandbox_key?
      @manual_get_sandbox_key
    end
  end
end
