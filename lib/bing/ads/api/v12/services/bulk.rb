module Bing
  module Ads
    module API
      module V12
        module Services
          # Bing::Ads::API::V12::Services::Bulk
          class Bulk < Base
            def initialize(options = {})
              super(options)
            end

            def get_bulk_upload_url(account_id = nil, response_mode = 'ErrorsOnly')
              account_id ||= @account_id

              response = call(__method__, response_mode: response_mode, account_id: account_id)
              response_body = response_body(response, __method__)
              response_body.slice(:request_id, :upload_url)
            end

            def get_bulk_upload_status(request_id)
              response = call(__method__, request_id: request_id)
              response_body = response_body(response, __method__)
              response_body.slice(:errors, :percent_complete, :request_status, :result_file_url)
            end

            # TODO operations: https://msdn.microsoft.com/en-us/library/bing-ads-bulk-service-operations.aspx

            private

            def service_name
              'bulk'
            end
          end
        end
      end
    end
  end
end
