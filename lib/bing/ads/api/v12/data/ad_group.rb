module Bing
  module Ads
    module API
      module V12
        module Data
          # Bing::Ads::API::V12::Data::AdGroup
          class AdGroup

            # @order
            # https://msdn.microsoft.com/en-us/library/bing-ads-campaign-management-adgroup.aspx
            KEYS_ORDER = [
              :ad_distribution,
              :ad_rotation,
              :bidding_scheme,
              :content_match_bid,
              :end_date,
              :forward_compatibility_map,
              :id,
              :language,
              :name,
              :native_bid_adjustment,
              :network,
              :pricing_model,
              :remarketing_targeting_setting,
              :search_bid,
              :settings,
              :start_date,
              :status,
              :tracking_url_template,
              :url_custom_parameters
              # Alphabetical
            ]

            def self.prepare(ad_group_raw)
              ad_group_raw[:ad_rotation] = { type: ad_group_raw[:ad_rotation] } if ad_group_raw[:ad_rotation]
              if ad_group_raw[:bidding_scheme]
                # TODO support MaxClicksBiddingScheme, MaxConversionsBiddingScheme and TargetCpaBiddingScheme
                ad_group_raw[:bidding_scheme] = {
                  type: ad_group_raw[:bidding_scheme],
                  '@xsi:type' => "#{Bing::Ads::API::V12::NAMESPACE_IDENTIFIER}:#{ad_group_raw[:bidding_scheme]}"
                }
              end
              ad_group_raw[:content_match_bid] = { amount: ad_group_raw[:content_match_bid] } if ad_group_raw[:content_match_bid]
              ad_group_raw[:end_date] = Bing::Ads::Utils.date_hash(ad_group_raw[:end_date]) if ad_group_raw[:end_date]
              ad_group_raw[:search_bid] = { amount: ad_group_raw[:search_bid] } if ad_group_raw[:search_bid]
              ad_group_raw[:start_date] = Bing::Ads::Utils.date_hash(ad_group_raw[:start_date]) if ad_group_raw[:start_date]
              # TODO UrlCustomParameters
              ad_group_raw = Bing::Ads::Utils.sort_keys(ad_group_raw)
              Bing::Ads::Utils.camelcase_keys(ad_group_raw)
            end
          end
        end
      end
    end
  end
end
