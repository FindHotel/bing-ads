module Bing
  module Ads
    module API
      module V12
        module Services
          # Bing::Ads::API::V12::Base
          class Base
            attr_accessor :soap_client, :environment, :retry_attempts

            # @param options - Hash with autentication and environment settings
            # * environment - +:production+ or +:sandbox+
            # * developer_token - client application's developer access token
            # * customer_id - identifier for the customer that owns the account
            # * account_id - identifier of the account that own the entities in the request
            # * client_settings - Hash with any Client additional options (such as header, logger or enconding)
            # * retry_attempts - Number of times the service must retry on failure
            # * log_level - :debug :warn :error :fatal
            # (EITHER)
            # * authentication_token - OAuth2 token
            # (OR)
            # * username - Bing Ads username
            # * password - Bing Ads password
            def initialize(options = {})
              @environment = options.delete(:environment)
              @retry_attempts = options.delete(:retry_attempts) || 0
              @account_id = options[:account_id]
              @customer_id = options[:customer_id]
              raise 'You must set the service environment' unless @environment
              options[:wsdl_url] = service_wsdl_url
              options[:namespace_identifier] = Bing::Ads::API::V12::NAMESPACE_IDENTIFIER
              @soap_client = Bing::Ads::API::SOAPClient.new(options)
            end

            # This is a utility wrapper for calling services into the
            # SOAPClient. This methods handle the Savon::Client Exceptions
            # and returns a Hash with the call response
            #
            # @param operation - name of the operation to be called
            # @param payload - hash with the parameters to the operation
            #
            # @example
            #   service.call(:some_operation, { key: value })
            #   # => <Hash>
            #
            # @return Hash with the result of the service call
            # @raise ServiceError if the SOAP call fails or the response is invalid
            def call(operation, payload)
              retries_made = 0
              raise 'You must provide an operation' if operation.nil?
              begin
                response = soap_client.call(operation: operation.to_sym, payload: payload)
                return response.hash
              rescue Savon::SOAPFault => error
                fault = error.to_hash[:fault]

                if fault.dig(:detail, :api_fault_detail)
                  handle_soap_fault(operation, fault[:detail], :api_fault_detail)
                elsif fault.dig(:detail, :ad_api_fault_detail)
                  handle_soap_fault(operation, fault[:detail], :ad_api_fault_detail)
                else
                  if retries_made < retry_attempts
                    sleep(2**retries_made)
                    retries_made += 1
                    retry
                  else
                    raise Bing::Ads::API::Errors::UnhandledSOAPFault,
                          "SOAP error (#{fault.keys.join(', ')}) while calling #{operation}. #{error.message}"
                  end
                end
              rescue Savon::HTTPError => error
                # TODO better handling
                raise
              rescue Savon::InvalidResponseError => error
                # TODO better handling
                raise
              rescue
                if retries_made < retry_attempts
                  sleep(2**retries_made)
                  retries_made += 1
                  retry
                else
                  raise
                end
              end
            end

            # Extracts the actual response from the entire response hash.
            #
            # @param response - The complete response hash received from a Operation call
            # @param method - Name of the method of with the 'reponse' tag is require
            #
            # @example
            #   service.response_body(Hash, 'add_campaigns')
            #   # => Hash
            #
            # @return Hash with the content of the called method response hash
            def response_body(response, method)
              response[:envelope][:body]["#{method}_response".to_sym]
            end

            private

            # Returns service name. This method must be overriden by specific services.
            #
            # @return String with the service name
            # @raise exception if the specific Service class hasn't overriden this method
            def service_name
              raise 'Should return the a service name from config.wsdl keys'
            end

            # Gets the service WSDL URL based on the service name and environment
            #
            # @return String with the Service url
            def service_wsdl_url
              Bing::Ads::API::V12.constants.wsdl.send(environment).send(service_name)
            end

            def handle_soap_fault(operation, fault_detail, key)
              if fault_detail[key][:errors] &&
                 fault_detail[key][:errors][:ad_api_error] &&
                 fault_detail[key][:errors][:ad_api_error][:error_code] == 'AuthenticationTokenExpired'
                raise Bing::Ads::API::Errors::AuthenticationTokenExpired,
                      'renew authentication token or obtain a new one.'
              else
                raise Bing::Ads::API::Errors::UnhandledSOAPFault,
                      "SOAP error (#{fault_detail[key]}) while calling #{operation}."
              end
            end
          end
        end
      end
    end
  end
end
