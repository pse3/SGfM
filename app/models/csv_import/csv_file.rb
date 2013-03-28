require 'FileUtils'

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
        #todo use logger?
        puts "file #{self.file_path} doesn't exist any more"
      end
    end

  end

end