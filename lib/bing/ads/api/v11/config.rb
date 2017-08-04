# frozen_string_literal: true

module Bing
  module Ads
    module API
      module V11
        # Bing::Ads::API::V11::Config
        module Config
          root_v11_path = File.expand_path('../', __FILE__)

          campaign_management_constants_path = File.join(root_v11_path, 'config', 'campaign_management.yml')
          time_zones_path = File.join(root_v11_path, 'config', 'time_zones.yml')
          languages_path = File.join(root_v11_path, 'config', 'languages.yml')
          wsdl_path = File.join(root_v11_path, 'config', 'wsdl.yml')

          Persey.init(:default) do
            source :yaml, campaign_management_constants_path, :campaign_management
            source :yaml, time_zones_path, :time_zones
            source :yaml, languages_path, :languages
            source :yaml, wsdl_path, :wsdl
            env :default
          end
        end
      end
    end
  end
end
