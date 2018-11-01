module Bing
  module Ads
    module API
      module V12
        module Services
          # Bing::Ads::API::V12::Services::CampaignManagement
          class CampaignManagement < Base
            def initialize(options = {})
              super(options)
            end

            def get_campaigns_by_account_id(account_id=nil, campaign_type: "Search")
              account_id ||= @account_id
              response = call(:get_campaigns_by_account_id, account_id: account_id, campaign_type: campaign_type)
              response_body = response_body(response, __method__)
              [response_body[:campaigns][:campaign]].flatten.compact
            end

            def get_campaigns_by_ids(account_id, campaign_ids)
              account_id ||= @account_id
              payload = {
               account_id: account_id,
               campaign_ids: { 'ins1:long' => campaign_ids }
              }
              response = call(:get_campaigns_by_ids, payload)
              response_body = response_body(response, __method__)
              [response_body[:campaigns][:campaign]].flatten.compact
            end

            def add_campaigns(account_id, campaigns)
              validate_limits!(:campaign, :add, campaigns)
              campaigns = campaigns.map { |campaign| Bing::Ads::API::V12::Data::Campaign.prepare(campaign) }
              payload = {
                account_id: account_id,
                campaigns: { campaign: campaigns }
              }
              response = call(:add_campaigns, payload)
              response_body(response, __method__)
            end

            def update_campaigns(account_id, campaigns)
              validate_limits!(:campaign, :update, campaigns)
              campaigns = campaigns.map { |campaign| Bing::Ads::API::V12::Data::Campaign.prepare(campaign) }
              payload = {
                account_id: account_id,
                campaigns: { campaign: campaigns }
              }
              response = call(:update_campaigns, payload)
              response_body(response, __method__)
            end

            def delete_campaigns(account_id, campaign_ids)
              validate_limits!(:campaign, :delete, campaign_ids)
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
              ad_groups = ad_groups.map { |ad_group| Bing::Ads::API::V12::Data::AdGroup.prepare(ad_group) }
              payload = {
                campaign_id: campaign_id,
                ad_groups: { ad_group: ad_groups }
              }
              response = call(:add_ad_groups, payload)
              response_body(response, __method__)
            end

            def update_ad_groups(campaign_id, ad_groups)
              validate_limits!(:ad_group, :update, ad_groups)
              ad_groups = ad_groups.map { |ad_group| Bing::Ads::API::V12::Data::AdGroup.prepare(ad_group) }
              payload = {
                campaign_id: campaign_id,
                ad_groups: { ad_group: ad_groups }
              }
              response = call(:update_ad_groups, payload)
              response_body(response, __method__)
            end

            def delete_ad_groups(campaign_id, ad_group_ids)
              validate_limits!(:ad_group, :delete, ad_group_ids)
              payload = {
                campaign_id: campaign_id,
                ad_group_ids: { 'ins1:long' => ad_group_ids }
              }
              response = call(:delete_ad_groups, payload)
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
              ads = ads.map { |ad| Bing::Ads::API::V12::Data::ExpandedTextAd.prepare(ad) }
              payload = {
                ad_group_id: ad_group_id,
                ads: { ad: ads }
              }
              response = call(:add_ads, payload)
              response_body(response, __method__)
            end

            def update_ads(ad_group_id, ads)
              validate_limits!(:ad, :update, ads)
              ads = ads.map { |ad| Bing::Ads::API::V12::Data::ExpandedTextAd.prepare(ad) }
              payload = {
                ad_group_id: ad_group_id,
                ads: { ad: ads }
              }
              response = call(:update_ads, payload)
              response_body(response, __method__)
            end

            def delete_ads(ad_group_id, ad_ids)
              validate_limits!(:ad, :delete, ad_ids)
              payload = {
                ad_group_id: ad_group_id,
                ad_ids: { 'ins1:long' => ad_ids }
              }
              response = call(:delete_ads, payload)
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
              keywords = keywords.map { |keyword| Bing::Ads::API::V12::Data::Keyword.prepare(keyword) }
              payload = {
                ad_group_id: ad_group_id,
                keywords: { keyword: keywords }
              }
              response = call(:add_keywords, payload)
              response_body(response, __method__)
            end

            def update_keywords(ad_group_id, keywords)
              validate_limits!(:keyword, :update, keywords)
              keywords = keywords.map { |keyword| Bing::Ads::API::V12::Data::Keyword.prepare(keyword) }
              payload = {
                ad_group_id: ad_group_id,
                keywords: { keyword: keywords }
              }
              response = call(:update_keywords, payload)
              response_body(response, __method__)
            end

            def delete_keywords(ad_group_id, keyword_ids)
              validate_limits!(:keyword, :delete, keyword_ids)
              payload = {
                ad_group_id: ad_group_id,
                keyword_ids: { 'ins1:long' => keyword_ids }
              }
              response = call(:delete_keywords, payload)
              response_body(response, __method__)
            end

            # TODO add_ad_extensions
            # TODO add_ad_group_criterions
            # TODO add_audiences
            # TODO add_budgets
            # TODO add_campaign_criterions
            # TODO add_conversion_goals
            # TODO add_labels
            # TODO add_list_items_to_shared_list
            # TODO add_media
            # TODO add_negative_keywords_to_entities
            # TODO add_shared_entity
            # TODO add_uet_tags
            # TODO appeal_editorial_rejections
            # TODO apply_offline_conversions
            # TODO apply_product_partition_actions
            # TODO delete_ad_extensions
            # TODO delete_ad_group_criterions
            # TODO delete_audiences
            # TODO delete_budgets
            # TODO delete_campaign_criterions
            # TODO delete_conversion_goals
            # TODO delete_keywords
            # TODO delete_labels
            # TODO delete_list_items_to_shared_list
            # TODO delete_media
            # TODO delete_negative_keywords_to_entities
            # TODO delete_shared_entity
            # TODO delete_shared_entity_associations
            # TODO get_account_migration_statuses
            # TODO get_account_properties
            # TODO get_ad_extension_ids_by_account_id
            # TODO get_ad_extensions_associations
            # TODO get_ad_extensions_by_ids
            # TODO get_ad_extensions_editorial_reasons
            # TODO get_ad_group_criterions_by_ids
            # TODO get_ads_by_editorial_status
            # TODO get_audiences_by_ids
            # TODO get_bmc_stores_by_customer_id
            # TODO get_bsc_countries
            # TODO get_budgets_by_ids
            # TODO get_campaign_criterions_by_ids
            # TODO get_campaign_ids_by_budget_ids
            # TODO get_campaign_sizes_by_account_id
            # TODO get_config_value
            # TODO get_conversion_goals_by_ids
            # TODO get_conversion_goals_by_tag_ids
            # TODO get_editorial_reasons_by_ids
            # TODO get_geo_locations_file_url
            # TODO get_keywords_by_editorial_status
            # TODO get_label_associations_by_entity_ids
            # TODO get_label_associations_by_label_ids
            # TODO get_labels_by_ids
            # TODO get_list_items_by_shared_list
            # TODO get_media_associations
            # TODO get_media_by_ids
            # TODO get_media_meta_data_by_account_id
            # TODO get_media_meta_data_by_ids
            # TODO get_negative_keywords_by_entity_ids
            # TODO get_negative_sites_by_ad_group_ids
            # TODO get_negative_sites_by_campaign_ids
            # TODO get_shared_entities_by_account_id
            # TODO get_shared_entity_associations_by_entity_ids
            # TODO get_shared_entity_associations_by_shared_entity_ids
            # TODO get_uet_tags_by_ids
            # TODO set_account_properties
            # TODO set_ad_extensions_associations
            # TODO set_label_associations
            # TODO set_negative_sites_to_ad_groups
            # TODO set_negative_sites_to_campaigns
            # TODO set_shared_entity_associations
            # TODO update_ad_extensions
            # TODO update_ad_group_criterions
            # TODO update_audiences
            # TODO update_budgets
            # TODO update_campaign_criterions
            # TODO update_conversion_goals
            # TODO update_labels
            # TODO update_list_items_to_shared_list
            # TODO update_media
            # TODO update_negative_keywords_to_entities
            # TODO update_shared_entity
            # TODO update_uet_tags

            private

            def service_name
              'campaign_management'
            end

            def validate_limits!(type, operation, array)
              limit = Bing::Ads::API::V12.constants.limits.per_call.send(type)
              if array.size > limit
                raise Bing::Ads::API::Errors::LimitError.new(operation, limit, type)
              end
            end

            def all_ad_types
              {
                ad_type: [
                  Bing::Ads::API::V12.constants.campaign_management.ad_types_for_get.text,
                  Bing::Ads::API::V12.constants.campaign_management.ad_types_for_get.expanded_text,
                  Bing::Ads::API::V12.constants.campaign_management.ad_types_for_get.image,
                  Bing::Ads::API::V12.constants.campaign_management.ad_types_for_get.product,
                  Bing::Ads::API::V12.constants.campaign_management.ad_types_for_get.app_install
                ]
              }
            end
          end
        end
      end
    end
  end
end
