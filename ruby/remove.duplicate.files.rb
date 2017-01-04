#!/usr/bin/env ruby

## USAGE: ruby remove.duplicate.files
#
## Scanning all files in current folder (and subfolders?)
## and based on the files md5 sum, deletes duplicates.
#

require 'digest/md5'
 
hash = {}
 
Dir.glob("**/*", File::FNM_DOTMATCH).each do |filename|
  next if File.directory?(filename)
  #puts 'Checking ' + filename
 
  key = Digest::MD5.hexdigest(IO.read(filename)).to_sym
  #puts "key #{key}"
  if hash.has_key? key
    hash[key].push filename
    #puts "same file #{filename}"
    puts "duplicate #{filename}"
    File.delete(filename)
  else
    hash[key] = [filename]
  end
end
 
hash.each_value do |filename_array|
  if filename_array.length > 1
    puts "=== Identical Files ===\n"
    filename_array.each { |filename| puts '  '+filename }
  end
end
