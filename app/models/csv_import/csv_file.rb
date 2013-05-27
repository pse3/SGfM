require 'fileutils'

# A CsvFile is a file of the format .csv that has been imported by an Admin.
# CsvFiles are used to import a list of multiple Actors at once.

module CsvImport
  class CsvFile

    include Mongoid::Document

    before_destroy :remove_csv_file

    field :file_name, :type => String
    field :file_path, :type => String
    field :encoding, :type => String
    field :delimiter, :type => String

    field :uploaded, :type => DateTime
    field :imported, :type => DateTime

    attr_accessor :actor_type, :infos

    def initialize
      super
      self.uploaded = DateTime.now
      # default separator if none given
      self.delimiter = "|"
    end

    def remove_csv_file
      begin
        FileUtils.rm(self.file_path)
      rescue Errno::ENOENT
        puts "file #{self.file_path} doesn't exist any more"
      end
    end

  end

end
