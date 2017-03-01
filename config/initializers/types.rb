require "ability"

ActiveRecord::Type.register(:ability, Ability::Type)
