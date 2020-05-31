module Bing
  module Ads
    module API
      module V13
        module Data
          # Bing::Ads::API::V13::Data::ExpandedTextAd
          class ExpandedTextAd

            # @order
            # https://msdn.microsoft.com/en-us/library/bing-ads-campaign-management-ad.aspx
            KEYS_ORDER = %i[
              ad_format_preference
              device_preference
              editorial_status
              final_app_urls
              final_mobile_urls
              final_urls
              forward_compatibility_map
              id
              status
              tracking_url_template
              type
              url_custom_parameters
            ].freeze

            def self.prepare(ad_raw)
              ad_raw['@xsi:type'] = "#{Bing::Ads::API::V13::NAMESPACE_IDENTIFIER}:#{ad_raw[:type]}"
              # TODO FinalAppUrls
              ad_raw[:final_mobile_urls] = { 'ins1:string' => ad_raw[:final_mobile_urls] } if ad_raw[:final_mobile_urls]
              ad_raw[:final_urls] = { 'ins1:string' => ad_raw[:final_urls] } if ad_raw[:final_urls]
              ad_raw.delete(:type)
              ad_raw = Bing::Ads::Utils.sort_keys(ad_raw, KEYS_ORDER)
              Bing::Ads::Utils.camelcase_keys(ad_raw)
            end
          end
        end
      end
    end
  end
end
