require 'yelp/request'

class Yelp
  module Review
    module Request
      class Base < Yelp::Request
        # specifies the number of businesses to return in the result set.
        # default is 10.  minimum value is 1 and maximum value is 20.
        attr_reader :business_count

        # string representing the name of business or search term being
        # requested.
        attr_reader :term

        def base_url
          'http://api.yelp.com/business_review_search'
        end

        def to_yelp_params
          super.merge(:term => term,
                      :num_biz_requested => business_count)
        end
      end
    end
  end
end
