module Bing
  module Ads
    module API
      module V13
        module Data
          # Bing::Ads::API::V13::Data::Campaign
          class Campaign

            # @order
            # https://msdn.microsoft.com/en-us/library/bing-ads-campaign-management-campaign.aspx
            KEYS_ORDER = [
              :audience_bid_adjustment,
              :bidding_scheme,
              :budget_type,
              :daily_budget,
              :experiment_id,
              :final_suffix_url,
              :forward_compatibility_map,
              :id,
              :name,
              :status,
              :sub_type,
              :time_zone,
              :tracking_url_template,
              :url_custom_parameters,
              # Alphabetical till here
              :campaign_type,
              :settings,
              :budget_id,
              :languages
            ].freeze

            def self.prepare(campaign_raw)
              if campaign_raw[:bidding_scheme]
                campaign_raw[:bidding_scheme] = {
                  # TODO support MaxClicksBiddingScheme, MaxConversionsBiddingScheme and TargetCpaBiddingScheme
                  type: campaign_raw[:bidding_scheme],
                  '@xsi:type' => "#{Bing::Ads::API::V13::NAMESPACE_IDENTIFIER}:#{campaign_raw[:bidding_scheme]}"
                }
              end
              # TODO UrlCustomParameters
              # TODO Settings
              campaign_raw = Bing::Ads::Utils.sort_keys(campaign_raw, KEYS_ORDER)
              Bing::Ads::Utils.camelcase_keys(campaign_raw)
            end
          end
        end
      end
    end
  end
end
