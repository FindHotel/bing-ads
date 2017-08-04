module Bing
  module Ads
    module API
      # Bing::Ads::API::SOAPClient
      class SOAPClient
        attr_accessor :customer_id, :account_id, :developer_token, :wsdl_url, :client_settings
        attr_accessor :authentication_token, :username, :password, :namespace_identifier
        attr_accessor :savon_client

        def initialize(options)
          @customer_id            = options[:customer_id]
          @account_id             = options[:account_id]
          @developer_token        = options[:developer_token]
          @wsdl_url               = options[:wsdl_url]
          @namespace_identifier   = options[:namespace_identifier]
          @authentication_token   = options[:authentication_token]
          @username               = options[:username]
          @password               = options[:password]
          @client_settings        = options[:client_settings]
        end

        def call(operation:, payload: {})
          client(client_settings).call(operation, message: payload)
        end

        def client(settings)
          return savon_client if savon_client
          settings = {
            convert_request_keys_to: :camelcase,
            wsdl: wsdl_url,
            namespace_identifier: namespace_identifier,
            soap_header: soap_header,
            log: true,
            log_level: :debug,
            pretty_print_xml: true
          }
          settings.merge!(client_settings) if client_settings
          @savon_client = Savon.client(settings)
        end

        private
        def soap_header
          headers = {}
          if authentication_token
            headers[ns('AuthenticationToken')] = authentication_token
            headers[ns('CustomerAccountId')] = account_id
            headers[ns('CustomerId')] = customer_id
            headers[ns('DeveloperToken')] = developer_token
          elsif username && password
            headers[ns('CustomerAccountId')] = account_id
            headers[ns('CustomerId')] = customer_id
            headers[ns('DeveloperToken')] = developer_token
            headers[ns('UserName')] = username
            headers[ns('Password')] = password
          else
            raise Errors::AuthenticationParamsMissing, 'no authentication params provided'
          end
          headers
        end

        def ns(string)
          "#{namespace_identifier}:#{string}"
        end
      end
    end
  end
end
