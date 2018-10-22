module Bing
  module Ads
    module API
      module V12
        module Data
          # Bing::Ads::API::V12::Data::ReportRequest
          class ReportRequest

            # @order
            # https://msdn.microsoft.com/en-us/library/bing-ads-reporting-reportrequest.aspx
            KEYS_ORDER = [
              :exclude_column_headers,
              :exclude_report_footer,
              :exclude_report_header,
              :format,
              :language,
              :report_name,
              :return_only_complete_data,
              :aggregation,
              :columns,
              :filter,
              :scope,
              :time
            ]

            class << self
              def prepare(type, report_request_raw)
                report_request_raw[:columns] = prepare_columns(
                  columns: report_request_raw[:columns],
                  type: type.to_s.classify
                )

                report_request_raw[:scope] = prepare_scope(
                  account_ids: report_request_raw[:account_ids]
                )

                report_request_raw[:time] = prepare_time_period(
                  from_date: report_request_raw[:from_date],
                  to_date:   report_request_raw[:to_date]
                )

                report_request_raw.except!(:from_date, :to_date, :account_ids)

                report_request = Bing::Ads::Utils.sort_keys(report_request_raw, KEYS_ORDER)
                namespace_identifier = Bing::Ads::API::V12::NAMESPACE_IDENTIFIER
                {
                  report_request: Bing::Ads::Utils.camelcase_keys(report_request),
                  :attributes! => {
                    report_request: {
                      "xmlns:i" => "http://www.w3.org/2001/XMLSchema-instance",
                      "i:type" => "#{namespace_identifier}:#{type.to_s.classify}ReportRequest"
                    }
                  }
                }
              end

              private

              def prepare_columns(type:, columns:)
                {
                  "#{type}ReportColumn" => columns.map(&:to_s).map(&:camelcase)
                }
              end

              def prepare_scope(account_ids:)
                account_ids_elements =
                  if account_ids.nil?
                    nil
                  else
                    {
                      'a1:long' => account_ids,
                      '@xmlns:a1' => 'http://schemas.microsoft.com/2003/10/Serialization/Arrays'
                    }
                  end

                {
                  account_ids: account_ids_elements,
                  ad_groups: nil,
                  campaigns: nil
                }
              end

              def prepare_time_period(from_date:, to_date:)
                from_date = Date.parse(from_date)
                to_date = Date.parse(to_date)

                {
                  custom_date_range_end: {
                    day: to_date.day,
                    month: to_date.month,
                    year: to_date.year
                  },
                  custom_date_range_start: {
                    day: from_date.day,
                    month: from_date.month,
                    year: from_date.year
                  }
                }
              end
            end
          end
        end
      end
    end
  end
end
