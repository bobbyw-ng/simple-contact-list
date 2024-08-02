require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

require "yaml"

# before do
#   @contacts = YAML.load_file("contacts.yml")
# end

# view all contacts in list
get "/" do
  redirect "/contacts"
end 

get "/contacts" do
  contacts = YAML.load_file("contacts.yml")
  @contact_names = contacts.keys
  erb :contacts, layout: :layout
end

# render new contact page
get "/contacts/new" do
  erb :new, layout: :layout
end

# view a single contact
get "/contacts/:name" do
  @contacts = YAML.load_file("contacts.yml")
  @contact_name = params[:name]
  @details = @contacts[@contact_name]

  erb :contact, layout: :layout
end

# create a new contact
post "/contacts" do
  contact_name = params[:contact_name]
  phone = params[:phone]
  email = params[:email]
  address = params[:address]
  category = params[:category]

  contacts = YAML.load_file("contacts.yml")
  contacts[contact_name] = {"phone" => phone, "email" => email, "address" => address, "category" => category}
  File.open("contacts.yml", 'w') { |f| YAML.dump(contacts, f) }

  redirect "/contacts"
end

# render the edit contact page
get "/contacts/:name/edit" do
  @contacts = YAML.load_file("contacts.yml")
  @contact_name = params[:name]
  @details = @contacts[@contact_name]

  erb :edit, layout: :layout
end

# edit a contact
post "/contacts/:name/edit" do
  contact_name = params[:contact_name]
  phone = params[:phone]
  email = params[:email]
  address = params[:address]
  category = params[:category]

  contacts = YAML.load_file("contacts.yml")
  contacts[contact_name] = {"phone" => phone, "email" => email, "address" => address, "category" => category}
  File.open("contacts.yml", 'w') { |f| YAML.dump(contacts, f) }

  redirect "/contacts"
end

# delete a contact
post "/contacts/:name/delete" do
  contacts = YAML.load_file("contacts.yml")
  contact_name = params[:name]

  contacts.delete(contact_name)
  File.open("contacts.yml", 'w') { |f| YAML.dump(contacts, f) }

  redirect "/contacts"
end