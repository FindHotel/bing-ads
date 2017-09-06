module Bing
  module Ads
    module API
      module Errors
        # Bing::Ads::API::Errors::AuthenticationParamsMissing
        class AuthenticationParamsMissing < RuntimeError; end;

        # Bing::Ads::API::Errors::AuthenticationTokenExpired
        class AuthenticationTokenExpired < RuntimeError; end;

        # Bing::Ads::API::Errors::UnhandledSOAPFault
        class UnhandledSOAPFault < RuntimeError; end;

        # Bing::Ads::API::Errors::LimitError
        class LimitError < RuntimeError
          def initialize(operation, limit, type)
            super("can not #{operation} more than #{limit} #{type.to_s.humanize.downcase.pluralize} in a single call")
          end
        end
      end
    end
  end
end
