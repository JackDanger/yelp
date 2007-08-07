require 'pp'
require 'rubygems'
require 'test/unit'
require 'yelp'
require File.dirname(__FILE__) + '/yelp_helper'

class TestReviewSearch < Test::Unit::TestCase
  include YelpHelper

  def setup
    @client = Yelp::Client.new
    @yws_id = ENV['YWSID']
#    @client.debug = true
  end

  def test_bounding_box
    request = Yelp::Review::Request::BoundingBox.new(
                :bottom_right_latitude => 37.788022,
                :bottom_right_longitude => -122.399797,
                :top_left_latitude => 37.9,
                :top_left_longitude => -122.5,
#                :radius => 1,
#                :business_count => 3,
                :term => 'yelp',
                :yws_id => @yws_id)
    response = @client.search(request)
    validate_json_to_ruby_response(response)
  end

  def test_geo_point
    request = Yelp::Review::Request::GeoPoint.new(
                :latitude => 37.78022,
                :longitude => -122.399797,
                :radius => 2,
#                :business_count => 5,
                :term => 'yelp',
                :yws_id => @yws_id)
    response = @client.search(request)
    validate_json_to_ruby_response(response)
  end
  
  def test_location
    request = Yelp::Review::Request::Location.new(
                :address => '650 Mission St',
                :city => 'San Francisco',
                :state => 'CA',
                :radius => 2,
#                :business_count => 5,
                :term => 'cream puffs',
                :yws_id => @yws_id)
    response = @client.search(request)
    validate_json_to_ruby_response(response)
  end

  def test_json_response_format
    request = basic_request(:response_format => Yelp::ResponseFormat::JSON)
    response = @client.search(request)
    validate_json_response(response)
  end

  def test_json_to_ruby_response_format
    request = basic_request(:response_format => Yelp::ResponseFormat::JSON_TO_RUBY)
    response = @client.search(request)
    validate_json_to_ruby_response(response)
  end

  def test_pickle_response_format
    request = basic_request(:response_format => Yelp::ResponseFormat::PICKLE)
    @client.search(request)
    # TODO: validation
  end

  def test_php_response_format
    request = basic_request(:response_format => Yelp::ResponseFormat::PHP)
    response = @client.search(request)
    # TODO: validation
  end

  def test_compressed_response
    request = basic_request(:compress_response => true)
    response = @client.search(request)
    validate_json_to_ruby_response(response)
  end

  def test_uncompressed_response
    request = basic_request(:compress_response => false)
    response = @client.search(request)
    validate_json_to_ruby_response(response)
  end

  protected

    def basic_request (params = nil)
      default_params = {
        :city => 'San Francisco',
        :state => 'CA',
        :term => 'gordo',
        :yws_id => @yws_id
      }
      Yelp::Review::Request::Location.new(default_params.merge(params))
    end
end
