require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "securerandom"

require "yaml"

# before do
#   @contacts = YAML.load_file("contacts.yml")
# end

configure do
  enable :sessions
  set :session_secret, SecureRandom.hex(32)
end

# view all contacts in list
get "/" do
  redirect "/contacts"
end

helpers do
  def generate_id # generates unique user id
    contacts = YAML.load_file("contacts.yml")
    contacts.keys.max + 1
  end
end

get "/contacts" do
  @contacts = YAML.load_file("contacts.yml")

  erb :contacts, layout: :layout
end

# render new contact page
get "/contacts/new" do
  erb :new, layout: :layout
end

# view a single contact
get "/contacts/:id" do
  contacts = YAML.load_file("contacts.yml")
  @details = contacts.fetch(params[:id].to_i)

  erb :contact, layout: :layout
end

# create a new contact
post "/contacts/new" do
  contact_name = params[:contact_name]
  phone = params[:phone]
  email = params[:email]
  address = params[:address]
  category = params[:category]

  contacts = YAML.load_file("contacts.yml")
  contacts[generate_id] = {"name" => contact_name, "phone" => phone, "email" => email, "address" => address, "category" => category}
  File.open("contacts.yml", 'w') { |f| YAML.dump(contacts, f) }

  session[:message] = "#{contact_name} was created"
  redirect "/contacts"
end

# render the edit contact page
get "/contacts/:id/edit" do
  contacts = YAML.load_file("contacts.yml")
  @details = contacts.fetch(params[:id].to_i)
  @id = params[:id]

  erb :edit, layout: :layout
end

# edit a contact
post "/contacts/:id/edit" do
  contact_name = params[:contact_name]
  phone = params[:phone]
  email = params[:email]
  address = params[:address]
  category = params[:category]

  contacts = YAML.load_file("contacts.yml")
  contacts[params[:id].to_i] = {"name" => contact_name, "phone" => phone, "email" => email, "address" => address, "category" => category}
  File.open("contacts.yml", 'w') { |f| YAML.dump(contacts, f) }

  session[:message] = "#{contact_name} was updated"

  redirect "/contacts/#{params[:id]}"
end

# delete a contact
post "/contacts/:id/delete" do
  contacts = YAML.load_file("contacts.yml")
  contact_id = params[:id]

  contact_name = contacts.fetch(params[:id].to_i)["name"]

  contacts.delete(contact_id.to_i)
  File.open("contacts.yml", 'w') { |f| YAML.dump(contacts, f) }

  session[:message] = "#{contact_name} was deleted"

  redirect "/contacts"
end