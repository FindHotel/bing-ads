module Bing
  module Ads
    module API
      module V13
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
                    levels: bulk_request_row.delete(:levels)
                  )
                bulk_request_row.except!(:levels)
                bulk_request = Bing::Ads::Utils.sort_keys(bulk_request_row, KEYS_ORDER)
                Bing::Ads::Utils.camelcase_keys(bulk_request)
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
                entities = levels.map(&:pluralize).map(&:camelcase)
                { download_entity: entities }
              end
            end
          end
        end
      end
    end
  end
end
