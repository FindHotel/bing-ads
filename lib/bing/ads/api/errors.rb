module Bing
  module Ads
    module API
      module Errors
        # Bing::Ads::API::Errors::AuthenticationParamsMissing
        class AuthenticationParamsMissing < RuntimeError; end;
        # Bing::Ads::API::Errors::AuthenticationTokenExpired
        class AuthenticationTokenExpired < RuntimeError; end;
      end
    end
  end
end
