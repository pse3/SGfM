require 'csv'

# controller for CSV file import by admins
class CsvImportController < ApplicationController

  before_filter :authenticate_login!, :authenticate_admin!

  def new

  end

  def import
     csv_file_io = params[:csv]

     File.open(Rails.root.join('public', 'uploads', 'csv_import.csv'), 'wb') do |file|
       file.write(csv_file_io.read)
     end

       CSV.foreach(Rails.root.join("public/uploads/csv_import.csv"), {:col_sep => "|", :encoding => "ISO-8859-1"}) do |row|
          name, titel, adresse, email, telefon1, telefon2, kanton, spez = row
          puts "name: #{name}"
          actor = Actor.new()
          actor.actor_type = ActorType.find_by_key(:doctor)
          actor.informations.push information(:last_name, name)
          #actor.informations.push information(:email, email)
          actor.save
       end
     puts "done"

    redirect_to new_csv_import_path
  end

  def information(key,value)
    info = Information.new
    info.value = value
    if value.nil?
      info.value = "x"
    end
    info.information_type = InformationType.find_by_key(key)
    info
  end

end