module Bing
  module Ads
    module API
      module V12
        module Services
          # Bing::Ads::API::V12::Services::CampaignManagement
          class Reporting < Base
            def initialize(options = {})
              super(options)
            end

            def submit_generate_report(type, report_options)
              payload = Bing::Ads::API::V12::Data::ReportRequest.prepare(type, report_options)
              response = call(:submit_generate_report, payload)
              response_body = response_body(response, __method__)
              response_body
            end

            def poll_generate_report(report_request_id)
              response = call(:poll_generate_report, report_request_id: report_request_id)
              response_body = response_body(response, __method__)
              response_body
            end

            def report_ready?(report_request_id)
              polled = poll_generate_report(report_request_id)
              status = polled.dig(:report_request_status, :status)
              raise "Report status: Error for ID: #{report_request_id}" if status == "Error"
              status == "Success"
            end

            def report_url(report_request_id)
              polled = poll_generate_report(report_request_id)
              polled.dig(:report_request_status, :report_download_url)
            end

            def report_body(report_request_id)
              HttpClient.download(report_url(report_request_id))
            end

            private

            def service_name
              'reporting'
            end
          end
        end
      end
    end
  end
end
