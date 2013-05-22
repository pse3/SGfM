# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#


# Create the admin account
admin = Admin.new
login = Login.new(:email => 'admin@domain.ch',
                  :password => 'test1234',
                  :password_confirmation => 'test1234')
login.account = admin
login.confirmed_at = Time.now
admin.save
login.save


# load sample data
scope_stats = WhitelistScope.new
scope_stats.key = :statistics
scope_stats.name_translations = { :en => 'private + statistics', :de => 'privat + statistik', :it => 'privato + statistiche', :fr => 'prive + statistique' }
scope_stats.list = [:Self, :Admin]
scope_stats.save

scope_public = BlacklistScope.new
scope_public.key = :public
scope_public.name_translations = { :en => 'public', :de => 'oeffentlich', :it => 'pubblico', :frc=> 'public' }
scope_public.list = []
scope_public.save

scope_private = WhitelistScope.new
scope_private.key = :private
scope_private.name_translations = { :en => 'private', :de => 'privat', :it => 'privato', :fr => 'prive' }
scope_private.list = [:Self]
scope_private.save

#create the information field types
information_field_text = InformationFieldText.new
information_field_text.key = :text
information_field_text.name_translations = { :en => 'Text field', :de => 'Textfeld', :it => '???', :fr => '???' }
information_field_text.save

information_field_email = InformationFieldEmail.new
information_field_email.key = :email
information_field_email.name_translations = { :en => 'Email field', :de => 'Emailfeld', :it => '???', :fr => '???' }
information_field_email.save

information_field_date = InformationFieldDate.new
information_field_date.key = :date
information_field_date.name_translations = { :en => 'Date field', :de => 'Datumsfeld', :it => '???', :fr => '???' }
information_field_date.save

information_field_single_select = InformationFieldSingleSelect.new
information_field_single_select.key = :single_select
information_field_single_select.name_translations = { :en => 'single selection', :de => 'Einzelauswahl', :it => '???', :fr => '???' }
information_field_single_select.save

information_field_multiple_select = InformationFieldMultipleSelect.new
information_field_multiple_select.key = :multiple_select
information_field_multiple_select.name_translations = { :en => 'multiple selection', :de => 'Mehrauswahl', :it => '???', :fr => '???' }
information_field_multiple_select.save


info_first_name = InformationType.new
info_first_name.key = :first_name
info_first_name.information_field_type = information_field_text
info_first_name.name_translations = { :en => 'First name', :de =>'Vorname', :it => '??', :fr => '??' }
info_first_name.scope = scope_public
info_first_name.save

info_last_name = InformationType.new
info_last_name.key = :last_name
info_last_name.information_field_type = information_field_text
info_last_name.name_translations = { :en => 'Last name', :de =>'Name', :it => '??', :fr => '??' }
info_last_name.scope = scope_public
info_last_name.save



info_email = InformationType.new
info_email.key = :email
info_email.information_field_type = information_field_text
info_email.name_translations = { :en => 'Email', :de =>'E-Mail', :it => 'Smalto', :fr => 'Email' }
info_email.save

# Create some RelationshipTypes
relation_works_with = RelationshipType.new
relation_works_with.key = :works_with
relation_works_with.name_translations = { :en => 'works with', :de =>'arbeitet mit', :it => '??', :fr => '??' }
relation_works_with.question_translations = {
    :en => 'With whom do you work?',
    :de => 'Mit wem arbeitet Ihr?',
    :it => '??',
    :fr => '??'
}
relation_works_with.save


# Create some ActorTypes
actor_doctor = ActorType.new
actor_doctor.key = :doctor
InformationTypeDecorator.create(info_first_name, actor_doctor,  true, true)
InformationTypeDecorator.create(info_last_name, actor_doctor, true, true)
InformationTypeDecorator.create(info_email, actor_doctor, false, true)
actor_doctor.name_translations = { :en => 'Doctor', :de =>'Arzt', :it => 'Dottore', :fr => 'Medecin' }
actor_doctor.to_string_pattern = '|:last_name| |:first_name|'
actor_doctor.predefined_questions.push(relation_works_with)
actor_doctor.save

# Dummy user
user = User.new
login = Login.new(:email => 'email@domain.ch',
                  :password => 'test1234',
                  :password_confirmation => 'test1234')
login.account = user
login.confirmed_at = Time.now
user.save

# Dummy doctor 'Karl Schürch'
dummy_actor_karl = Actor.new
dummy_actor_karl.actor_type = ActorType.find_by_key(:doctor)
dummy_actor_type = dummy_actor_karl.actor_type

karl_fname = Information.new
karl_fname.information_type_decorator = dummy_actor_type.decorator_by_key(:first_name)
karl_fname.value = 'Karl'
karl_fname.actor = dummy_actor_karl

karl_lname = Information.new
karl_lname.information_type_decorator = dummy_actor_type.decorator_by_key(:last_name)
karl_lname.value = 'Schuerch'
karl_lname.actor = dummy_actor_karl

karl_email = Information.new
karl_email.information_type_decorator = dummy_actor_type.decorator_by_key(:email)
karl_email.scope = scope_public
karl_email.value = 'karl@schuerch.ch'
karl_email.actor = dummy_actor_karl

user.actors.push(dummy_actor_karl)
dummy_actor_karl.save
user.save
