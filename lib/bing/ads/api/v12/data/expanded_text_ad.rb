module Bing
  module Ads
    module API
      module V12
        module Data
          # Bing::Ads::API::V12::Data::ExpandedTextAd
          class ExpandedTextAd

            # @order
            # https://msdn.microsoft.com/en-us/library/bing-ads-campaign-management-ad.aspx
            KEYS_ORDER = [
              :ad_format_preference,
              :device_preference,
              :editorial_status,
              :final_app_urls,
              :final_mobile_urls,
              :final_urls,
              :forward_compatibility_map,
              :id,
              :status,
              :tracking_url_template,
              :url_custom_parameters,
              :path_1,
              :path_2,
              :text,
              :title_part_1,
              :title_part_2,
              :type
            ]

            def self.prepare(ad_raw)
              ad_raw['@xsi:type'] = "#{Bing::Ads::API::V12::NAMESPACE_IDENTIFIER}:#{ad_raw[:type]}"
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
