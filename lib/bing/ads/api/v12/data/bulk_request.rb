module Bing
  module Ads
    module API
      module V12
        module Data
          class BulkRequest

            KEYS_ORDER = %i[
              account_ids
              compression_type
              data_scope
              download_entities
              download_file_type
              format_version
              last_sync_time_in_utc
            ].freeze

            class << self
              def prepare(bulk_request_row)
                bulk_request_row[:account_ids] = prepare_account_ids(
                  account_ids: bulk_request_row[:account_ids]
                )
                bulk_request_row[:download_entities] =
                  prepare_download_entities(
                    levels: bulk_request_row.delete(:levels),
                  )
                bulk_request_row.execpt!(:levels)
                bulk_request = Bing::Ads::Utils.sort_keys(bulk_request_row, KEYS_ORDER)
                namespace_identifier = Bing::Ads::API::V12::NAMESPACE_IDENTIFIER
                {
                  get_campaigns_by_account_ids: Bing::Ads::Utils.camelcase_keys(bulk_request),
                  :attributes! => {
                    get_campaigns_by_account_ids: {
                      'xmlns:i' => 'http://www.w3.org/2001/XMLSchema-instance',
                      'i:type' => "#{namespace_identifier}:GetCampaignsByAccountIds"
                    }
                  }
                }
              end

              private

              def prepare_account_ids(account_ids:)
                {
                  'a1:long' => account_ids,
                  '@xmlns:a1' => 'http://schemas.microsoft.com/2003/10/Serialization/Arrays'
                }
              end

              def prepare_download_entities(levels:)
                levels = %w[campaign] if levels.nil? || levels.empty?
                return levels.map do |e|
                  Bing::Ads::API::V12.constants.bulk.download_entities.send(e)
                end
              end
            end
          end
        end
      end
    end
  end
end
