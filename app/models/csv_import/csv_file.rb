require 'FileUtils'

module CsvImport
  class CsvFile

    include Mongoid::Document

    before_destroy :remove_csv_file

    field :file_name, :type => String
    field :file_path, :type => String

    field :uploaded, :type => DateTime
    field :imported, :type => DateTime

    def initialize
      super
      self.uploaded = DateTime.now
    end

    def remove_csv_file
      begin
      FileUtils.rm(self.file_path)
      rescue
        #todo: proper log statement
        puts "file could not be deleted"
      end
    end

  end

end