class WelcomeController < ApplicationController
  def index

  end

  def constitution
    @constitution = Content.find_by_title("Constitution")
    if @constitution.nil?
      @constitution = Content.new(title: "Constitution")
    end
  end
end
