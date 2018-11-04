module Bing
  module Ads
    module API
      # Bing::Ads::API::V12
      module V12
        NAMESPACE_IDENTIFIER = :v12

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
