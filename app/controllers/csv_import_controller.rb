require 'csv'
require_relative '../models/csv_import/csv_file'

# Controller for importing CsvFiles by an Admin.
class CsvImportController < ApplicationController

  before_filter :authenticate_login!, :authenticate_admin!

  def new_csv_file
     @supported_encodings = ['UTF-8','ISO-8859-1']
     @supported_delimiters = ['|',',',';']
  end

  def upload_csv_file
    csv_file_io = params[:csv_file][:csv]
    filename = csv_file_io.original_filename
    file_path = Rails.root.join('data', 'csv_import', filename)

    # save the file on filesystem
    File.open(file_path, 'wb') do |file|
      file.write(csv_file_io.read)
    end

    # create csv file object
    csv_file = CsvImport::CsvFile.new
    csv_file.file_name = filename
    csv_file.file_path = file_path
    csv_file.encoding = params[:csv_file][:encoding]
    csv_file.delimiter = params[:csv_file][:delimiter]

    if csv_file.save
      flash[:success] = t('csv_import.file.upload.success', :file_name => filename)
      redirect_to list_csv_files_path
    else
      flash[:error] = t('csv_import.file.upload.failure')
      redirect_to list_csv_files_path
    end
  end

  # Lists all uploaded CsvFiles.
  def list_csv_files
    @csv_files = CsvImport::CsvFile.all
  end

  def delete_csv_file
    csv_file = CsvImport::CsvFile.find(params[:id])
    csv_file.destroy
    render :json => { :success => true}
  end

  def import
    csv_file = CsvImport::CsvFile.find(params[:id])

    CSV.foreach(csv_file.file_path, {:col_sep => csv_file.delimiter, :encoding => csv_file.encoding}) do |row|

      actor = Actor.new()
      actor_type = ActorType.find_by_key(params[:csv_import_csv_file][:actor_type])
      actor.actor_type = actor_type

      params[:infos].each_value do |info|
        info_type_decorator = actor_type.decorator_by_key(info[:key].to_sym)
        information = Information.new
        information.information_type_decorator = info_type_decorator
        information.scope = Scope.find_by(key: :public)
        value = row[info[:index].to_i]
        #todo: other than simple values...
        unless value.nil?
          information.value=(value)
          actor.informations.push information
        end
      end

      # don't check for valid inputs!
      actor.save(:validate => false)
    end

    csv_file.imported = DateTime.now
    csv_file.save

    flash[:success] = t('csv_import.import.success', :file_name => csv_file.file_name)
    redirect_to list_csv_files_path
  end

  def information(key,value)
    info = Information.new
    info.information_type = InformationType.find_by_key(key)
    info.scope = Scope.find_by(:key => :public)
    info.value = value
    info
  end

  # Displays the form to create a new import.
  def new_import
    @csv_file = CsvImport::CsvFile.find(params[:id])
    @actor_types = ActorType.all
  end

  def add_row
    @information_types = InformationType.all
    render(:partial => 'csv_import/add_row', :locals => { :id => params[:id]})
  end

end