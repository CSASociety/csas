class VersionsController < ApplicationController
  include VersionsHelper
  def index
    @versions = Version.all
  end
end
