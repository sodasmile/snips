#!/usr/bin/ruby -w

# Script to read a document on a specified url and return the matching xpath elements.

require 'net/http'
require 'rexml/document'
include REXML

if (ARGV.length != 2) then
	puts "USAGE:\n#{__FILE__} <xpath> <url>"
	puts "    xpath: xpath to use to search url for, for instance ""//enclosure/@url"""
	puts "    url: url to load, for instance http://podkast.nrk.no/program/20_spoersmaal.rss"
	exit 1
end

expression = ARGV[0]
url = ARGV[1]

responseBody = Net::HTTP.get_response(URI.parse(url)).body

# extract event information
doc = Document.new(responseBody)

XPath.each(doc, expression) { |u| puts u }
