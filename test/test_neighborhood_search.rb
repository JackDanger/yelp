require 'pp'
require 'rubygems'
require 'test/unit'
require 'yelp'
require File.dirname(__FILE__) + '/yelp_helper'

class TestNeighborhoodSearch < Test::Unit::TestCase
  include YelpHelper

  def setup
    @client = Yelp::Client.new
    @yws_id = ENV['YWSID']
#    @client.debug = true
  end

  GORDO_LAT = 37.782093
  GORDO_LON = -122.483230
  GORDO_NEIGHBORHOOD = { "city" => "San Francisco", "name" => "Outer Richmond", "url" => "http://yelp.com/search?find_loc=Outer+Richmond%2C+San+Francisco%2C+CA", "state" => "CA" }

  def test_geo_point_search
    request = Yelp::Neighborhood::Request::GeoPoint.new(:latitude => GORDO_LAT,
                                                        :longitude => GORDO_LON,
                                                        :yws_id => @yws_id)
    response = @client.search(request)
    validate_json_to_ruby_response(response)
    assert_equal response['neighborhoods'].first, GORDO_NEIGHBORHOOD
  end

  GORDO_ADDRESS = '2252 Clement Street'

  def test_location_search
    request = Yelp::Neighborhood::Request::Location.new(:address => GORDO_ADDRESS,
                                                        :city => 'San Francisco',
                                                        :state => 'CA',
                                                        :zipcode => 94121,
                                                        :yws_id => @yws_id)
    response = @client.search(request)
    validate_json_to_ruby_response(response)
    assert_equal response['neighborhoods'].first, GORDO_NEIGHBORHOOD
  end
end
