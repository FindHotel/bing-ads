module Bing
  module Ads
    module API
      module V11
        module Data
          # Bing::Ads::API::V11::Data::Keyword
          class Keyword

            # @order
            # https://msdn.microsoft.com/en-us/library/bing-ads-campaign-management-keyword.aspx
            KEYS_ORDER = [
              :bidding_scheme,
              :bid,
              :destination_url,
              :editorial_status,
              :final_app_urls,
              :final_mobile_urls,
              :final_urls,
              :forward_compatibility_map,
              :id,
              :match_type,
              :param_1,
              :param_2,
              :param_3,
              :status,
              :text,
              :tracking_url_template,
              :url_custom_parameters
              # Alphabetical
            ]

            def self.prepare(keyword_raw)
              # To use the AdGroup default match type bid,
              # set the Amount element of the Bid object to null.
              keyword_raw[:bid] = { amount: keyword_raw[:bid] } if keyword_raw.has_key? :bid
              if keyword_raw[:bidding_scheme]
                # TODO support MaxClicksBiddingScheme, MaxConversionsBiddingScheme and TargetCpaBiddingScheme
                keyword_raw[:bidding_scheme] = {
                  type: keyword_raw[:bidding_scheme],
                  '@xsi:type' => "#{Bing::Ads::API::V11::NAMESPACE_IDENTIFIER}:#{keyword_raw[:bidding_scheme]}"
                }
              end
              keyword_raw[:final_mobile_urls] = { 'ins1:string' => keyword_raw[:final_mobile_urls] } if keyword_raw[:final_mobile_urls]
              keyword_raw[:final_urls] = { 'ins1:string' => keyword_raw[:final_urls] } if keyword_raw[:final_urls]
              # TODO FinalAppUrls
              
              keyword_raw = Bing::Ads::Utils.sort_keys(keyword_raw)
              Bing::Ads::Utils.camelcase_keys(keyword_raw)
              if keyword_raw.has_key? :url_custom_parameters
                keyword_raw['v11:UrlCustomParameters'] = { '@xmlns:e301' => "http://schemas.datacontract.org/2004/07/Microsoft.AdCenter.Advertiser.CampaignManagement.Api.DataContracts.V11", 'e301:Parameters' => {'e301:CustomParameter' => []} }
                keyword_raw[:url_custom_parameters].each do |k,v|
                  keyword_raw['v11:UrlCustomParameters']['e301:Parameters']['e301:CustomParameter'].push({ 'e301:Key' => k, 'e301:Value' => v})
                end
                keyword_raw.delete :url_custom_parameters
              end

              keyword_raw
            end
          end
        end
      end
    end
  end
end
