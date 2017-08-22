module Bing
  module Ads
    module API
      module V11
        module Data
          # Bing::Ads::API::V11::Data::ExpandedTextAd
          class ExpandedTextAd

            # @order
            # https://msdn.microsoft.com/en-us/library/bing-ads-campaign-management-ad.aspx
            KEYS_ORDER = [
              :device_preference,
              :editorial_status,
              :forward_compatibility_map,
              :id,
              :status,
              :final_urls,
              :path_1,
              :path_2,
              :text,
              :title_part_1,
              :title_part_2
            ]

            def self.prepare(ad_raw)
              ad_raw['@xsi:type'] = "#{Bing::Ads::API::V11::NAMESPACE_IDENTIFIER}:#{ad_raw[:type]}"
              ad_raw[:final_mobile_urls] = { 'ins1:string' => ad_raw[:final_mobile_urls] } if ad_raw[:final_mobile_urls]
              ad_raw[:final_urls] = { 'ins1:string' => ad_raw[:final_urls] } if ad_raw[:final_urls]
              # TODO FinalAppUrls
              ad_raw = Bing::Ads::Utils.sort_keys(ad_raw, KEYS_ORDER)
              Bing::Ads::Utils.camelcase_keys(ad_raw)
            end
          end
        end
      end
    end
  end
end
