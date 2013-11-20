#!/usr/bin/env ruby
ENV['RAILS_ENV'] = "development"
require File.dirname(__FILE__) + "/../config/environment"
require 'csv'

add_km_log = Logger.new(File.join(Rails.root, 'log', 'add_km.log'))
csv_text = File.read(ARGV[0])
csv = CSV.parse(csv_text, :headers => true)

role_external = Role.find_by_name("external")
email_regex = /^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$/i

def get_name name_array
  if name_array.size == 0
    raise 'Nombres invalidos: sin nombre'
  elsif name_array.size == 1
    return [name_array[0], ""]
  elsif name_array.size == 2
    return [name_array[0], name_array[1]]
  elsif name_array.size > 2
    return [name_array[0], name_array[1..name_array.size].join(" ")]
  end
end


csv.each do |row|
  user_hash = row.to_hash

  begin

    email = user_hash["Email"] || "no tiene"
    first_name, last_name = get_name(user_hash["Nombre"].split(" "))
    km = user_hash["km"].to_f
    hood_id = Neighborhood.find_by_name(user_hash["Barrio"]).id

    #revisar todas las variables
    if email and first_name and last_name and km and hood_id

      if email =~ email_regex
        user = User.find_by_email(email)
        if user
          user.update_attribute(:kilometers, user.kilometers + km)
        else
          user = User.create(first_name: first_name, last_name: last_name, email: email, roles: [role_external], neighborhood_id: hood_id, kilometers: km)
        end
      else
        User.create(first_name: first_name, last_name: last_name, email: email, roles: [role_external], neighborhood_id: hood_id, kilometers: km) 
      end

    else
      raise "Parametros incompletos: #{user_hash}"
    end

  rescue => error
    add_km_log.error("#{Time.now.in_time_zone('Central Time (US & Canada)').to_formatted_s(:short)} ERROR'd: \n #{error.backtrace}")
  end

end

add_km_log.info("#{Time.now.in_time_zone('Central Time (US & Canada)').to_formatted_s(:short)} completed")
