# frozen_string_literal: true

module Bing
  module Ads
    module API
      # Bing::Ads::API::V12::Constants
      module Constants
        root_v12_path = File.expand_path('../', __FILE__)

        campaign_management_path = File.join(root_v12_path, 'constants', 'campaign_management.yml')
        languages_path = File.join(root_v12_path, 'constants', 'languages.yml')
        limits_path = File.join(root_v12_path, 'constants', 'limits.yml')
        time_zones_path = File.join(root_v12_path, 'constants', 'time_zones.yml')
        wsdl_path = File.join(root_v12_path, 'constants', 'wsdl.yml')

        Persey.init(:default) do
          source :yaml, campaign_management_path, :campaign_management
          source :yaml, languages_path, :languages
          source :yaml, limits_path, :limits
          source :yaml, time_zones_path, :time_zones
          source :yaml, wsdl_path, :wsdl
          env :default
        end

        Bing::Ads::API::V12.constants = Persey.config
      end
    end
  end
end
