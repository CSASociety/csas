class Game < ActiveRecord::Base
  belongs_to :image, class_name: 'Resource'
end
