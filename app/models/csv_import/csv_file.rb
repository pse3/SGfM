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
      FileUtils.rm(self.file_path)
    end

  end

end