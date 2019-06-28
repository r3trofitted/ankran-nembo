require "#{Rails.root}/app/models/ability"

ActiveRecord::Type.register(:ability, Ability::Type)
