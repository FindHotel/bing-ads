module Bing
  module Ads
    class Utils
      class << self
        def camelcase_keys(object)
          object.each_with_object({}) do |(k, v), obj|
            obj[k.to_s.camelcase] = v
          end
        end
      end
    end
  end
end
