module Bing
  module Ads
    module API
      # Bing::Ads::API::V13
      module V13
        NAMESPACE_IDENTIFIER = :v13

        def self.constants
          @_config || fail('Error loading bing ads gem')
        end

        def self.constants=(config)
          @_config = config
        end
      end
    end
  end
end
