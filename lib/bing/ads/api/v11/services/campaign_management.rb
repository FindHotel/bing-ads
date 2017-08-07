module Bing
  module Ads
    module API
      module V11
        module Services
          # Bing::Ads::API::V11::Services::CampaignManagement
          class CampaignManagement < Base
            def initialize(options = {})
              super(options)
            end

            def get_campaigns_by_account_id(account_id=nil)
              account_id ||= @account_id
              response = call(:get_campaigns_by_account_id, account_id: account_id)
              response_body = response_body(response, __method__)
              [response_body[:campaigns][:campaign]].flatten.compact
            end

            def add_campaigns(account_id, campaigns)
              validate_limits!(:campaign, :add, campaigns)
              campaigns = campaigns.map { |campaign| prepare_campaign(campaign) }
              payload = {
                account_id: account_id,
                campaigns: { campaign: campaigns }
              }
              response = call(:add_campaigns, payload)
              response_body(response, __method__)
            end

            def update_campaigns(account_id, campaigns)
              validate_limits!(:campaign, :update, campaigns)
              campaigns = campaigns.map { |campaign| prepare_campaign(campaign) }
              payload = {
                account_id: account_id,
                campaigns: { campaign: campaigns }
              }
              response = call(:update_campaigns, payload)
              response_body(response, __method__)
            end

            def delete_campaigns(account_id, campaign_ids)
              payload = {
                account_id: account_id,
                campaign_ids: { 'ins1:long' => campaign_ids }
              }
              response = call(:delete_campaigns, payload)
              response_body(response, __method__)
            end

            def get_ad_groups_by_campaign_id(campaign_id)
              response = call(:get_ad_groups_by_campaign_id,
                              campaign_id: campaign_id)
              response_body = response_body(response, __method__)
              [response_body[:ad_groups][:ad_group]].flatten.compact
            end

            def get_ad_groups_by_ids(campaign_id, ad_groups_ids)
              payload = {
                campaign_id: campaign_id,
                ad_group_ids: { 'ins1:long' => ad_groups_ids }
              }
              response = call(:get_ad_groups_by_ids, payload)
              response_body = response_body(response, __method__)
              [response_body[:ad_groups][:ad_group]].flatten
            end

            def add_ad_groups(campaign_id, ad_groups)
              validate_limits!(:ad_group, :add, ad_groups)
              ad_groups = ad_groups.map { |ad_group| prepare_ad_group(ad_group) }
              payload = {
                campaign_id: campaign_id,
                ad_groups: { ad_group: ad_groups }
              }
              response = call(:add_ad_groups, payload)
              response_body(response, __method__)
            end

            def update_ad_groups(campaign_id, ad_groups)
              validate_limits!(:ad_group, :update, ad_groups)
              ad_groups = ad_groups.map { |ad_group| prepare_ad_group(ad_group) }
              payload = {
                campaign_id: campaign_id,
                ad_groups: { ad_group: ad_groups }
              }
              response = call(:update_ad_groups, payload)
              response_body(response, __method__)
            end

            def get_ads_by_ad_group_id(ad_group_id)
              payload = {
                ad_group_id: ad_group_id,
                ad_types: all_ad_types
              }
              response = call(:get_ads_by_ad_group_id, payload)
              response_body = response_body(response, __method__)
              response_ads = [response_body[:ads][:ad]].flatten.compact
              response_ads.each_with_object({}) do |ad, obj|
                type = ad['@i:type'.to_sym]
                obj[type] ||= []
                obj[type] << ad
              end
            end

            def get_ads_by_ids(ad_group_id, ad_ids)
              # Order matters
              payload = {
                ad_group_id: ad_group_id,
                ad_ids: { 'ins1:long' => ad_ids },
                ad_types: all_ad_types
              }
              response = call(:get_ads_by_ids, payload)
              response_body = response_body(response, __method__)
              response_ads = [response_body[:ads][:ad]].flatten
              response_ads.each_with_object({}) do |ad, obj|
                type = ad['@i:type'.to_sym]
                obj[type] ||= []
                obj[type] << ad
              end
            end

            def add_ads(ad_group_id, ads)
              validate_limits!(:ad, :add, ads)
              ads = ads.map { |ad| prepare_ad(ad) }
              payload = {
                ad_group_id: ad_group_id,
                ads: { ad: ads }
              }
              response = call(:add_ads, payload)
              response_body(response, __method__)
            end

            def update_ads(ad_group_id, ads)
              validate_limits!(:ad, :update, ads)
              ads = ads.map { |ad| prepare_ad(ad) }
              payload = {
                ad_group_id: ad_group_id,
                ads: { ad: ads }
              }
              response = call(:update_ads, payload)
              response_body(response, __method__)
            end

            def get_keywords_by_ad_group_id(ad_group_id)
              response = call(:get_keywords_by_ad_group_id, ad_group_id: ad_group_id)
              response_body = response_body(response, __method__)
              [response_body[:keywords][:keyword]].flatten.compact
            end

            def get_keywords_by_ids(ad_group_id, keyword_ids)
              payload = {
                ad_group_id: ad_group_id,
                keyword_ids: { 'ins1:long' => keyword_ids }
              }
              response = call(:get_keywords_by_ids, payload)
              response_body = response_body(response, __method__)
              [response_body[:keywords][:keyword]].flatten
            end

            def add_keywords(ad_group_id, keywords)
              validate_limits!(:keyword, :add, keywords)
              keywords = keywords.map { |keyword| Bing::Ads::Utils.camelcase_keys(keyword) }
              payload = {
                ad_group_id: ad_group_id,
                keywords: { keyword: keywords }
              }
              response = call(:add_keywords, payload)
              response_body(response, __method__)
            end

            def update_keywords(ad_group_id, keywords)
              validate_limits!(:keyword, :update, keywords)
              keywords = keywords.map { |keyword| Bing::Ads::Utils.camelcase_keys(keyword) }
              payload = {
                ad_group_id: ad_group_id,
                keywords: { keyword: keywords }
              }
              response = call(:update_keywords, payload)
              response_body(response, __method__)
            end

            private

            def service_name
              'campaign_management'
            end

            def prepare_campaign(campaign)
              campaign = Bing::Ads::Utils.sort_keys(campaign)
              campaign[:bidding_scheme] = { type: campaign[:bidding_scheme] } if campaign[:bidding_scheme]
              campaign[:languages] = { 'ins1:string' => campaign[:languages] } if campaign[:languages]
              # TODO UrlCustomParameters
              # TODO Settings
              Bing::Ads::Utils.camelcase_keys(campaign)
            end

            def prepare_ad_group(ad_group)
              ad_group = Bing::Ads::Utils.sort_keys(ad_group)
              ad_group[:ad_rotation] = { type: ad_group[:ad_rotation] } if ad_group[:ad_rotation]
              ad_group[:bidding_scheme] = { type: ad_group[:bidding_scheme] } if ad_group[:bidding_scheme]
              ad_group[:content_match_bid] = { amount: ad_group[:content_match_bid] } if ad_group[:content_match_bid]
              ad_group[:end_date] = date_hash(ad_group[:end_date]) if ad_group[:end_date]
              ad_group[:search_bid] = { amount: ad_group[:search_bid] } if ad_group[:search_bid]
              ad_group[:start_date] = date_hash(ad_group[:start_date]) if ad_group[:start_date]
              # TODO UrlCustomParameters
              Bing::Ads::Utils.camelcase_keys(ad_group)
            end

            def prepare_ad(ad)
              ad = Bing::Ads::Utils.sort_keys(ad)
              ad['@xsi:type'] = "#{Bing::Ads::API::V11::NAMESPACE_IDENTIFIER}:#{ad[:type]}"
              ad[:final_mobile_urls] = { 'ins1:string' => ad[:final_mobile_urls] } if ad[:final_mobile_urls]
              ad[:final_urls] = { 'ins1:string' => ad[:final_urls] } if ad[:final_urls]
              # TODO FinalAppUrls
              Bing::Ads::Utils.camelcase_keys(ad)
            end

            def date_hash(date)
              date = Date.parse(date) if date.is_a?(String)
              { day: date.day, month: date.month, year: date.year }
            end

            def validate_limits!(type, operation, array)
              limit = Bing::Ads::API::V11.constants.limits.per_call.send(type)
              if array.size > limit
                raise Bing::Ads::API::Errors::LimitError.new(operation, limit, type)
              end
            end

            def all_ad_types
              {
                ad_type: [
                  Bing::Ads::API::V11.constants.campaign_management.ad_types_for_get.text,
                  Bing::Ads::API::V11.constants.campaign_management.ad_types_for_get.expanded_text,
                  Bing::Ads::API::V11.constants.campaign_management.ad_types_for_get.image,
                  Bing::Ads::API::V11.constants.campaign_management.ad_types_for_get.product,
                  Bing::Ads::API::V11.constants.campaign_management.ad_types_for_get.app_install
                ]
              }
            end
          end
        end
      end
    end
  end
end
