module Bing
  module Ads
    class Utils
      class << self
        def camelcase_keys(object)
          object.each_with_object({}) do |(k, v), obj|
            obj[k.to_s.camelcase] = v
          end
        end

        def sort_keys(object, ordered_keys_array=nil)
          if ordered_keys_array
            object = sort_by_ordered_keys(object, ordered_keys_array)
          else
            object = sort_alphabetically(object)
          end
          object.symbolize_keys!
        end

        def date_hash(date)
          date = Date.parse(date) if date.is_a?(String)
          { day: date.day, month: date.month, year: date.year }
        end

        private

        def sort_by_ordered_keys(object, ordered_keys_array)
          Hash[ object.sort_by { |k, _| ordered_keys_array.index(k.to_sym) || (10000 + k.to_s.ord) } ]
        end

        def sort_alphabetically(object)
          Hash[ object.sort_by { |key, val| key.to_s } ]
        end
      end
    end
  end
end
