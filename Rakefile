require 'rubygems'
require 'hoe'
$:.unshift(File.dirname(__FILE__) + "/lib")
require 'yelp'

Hoe.new('yelp', Yelp::VERSION) do |p|
  p.rubyforge_name = 'yelp'
  p.author = 'Walter Korman'
  p.email = 'shaper@wgks.org'
  p.extra_deps << [ 'json', '>= 1.1.1' ]
  p.summary = 'An object-oriented interface to the Yelp Developer API.'
  p.description = 'An object-oriented interface to the Yelp Developer API.'
  p.url = 'http://rubyforge.org/projects/yelp'
  p.changes = p.paragraphs_of('History.txt', 0..1).join("\n\n")
  p.remote_rdoc_dir = '' # Release to root
end
