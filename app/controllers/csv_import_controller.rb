require 'csv'
require_relative '../models/csv_import/csv_file'

# controller for CSV file import by admins
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
    csv_file.save

    flash[:notice] = t('csv_import.file.upload.success_message', :file_name => filename)
    redirect_to list_csv_files_path
  end

  #lists all uploaded files
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
      name, titel, adresse, email, telefon1, telefon2, kanton, spez = row
      actor = Actor.new()
      actor.actor_type = ActorType.find_by_key(:doctor)
      actor.informations.push information(:first_name, name.split(' ')[-1])
      actor.informations.push information(:last_name, name.split(' ')[0...-1].join(' '))
      actor.informations.push information(:email, email)
      actor.informations.push information(:phone, telefon1)
      actor.save!
    end

    csv_file.imported = DateTime.now
    csv_file.save

    render :nothing => true
  end

  def information(key,value)
    info = Information.new
    info.information_type = InformationType.find_by_key(key)
    info.scope = Scope.find_by(:key => :public)
    info.value = value
    info
  end

end