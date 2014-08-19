class VersionsController < ApplicationController
  load_and_authorize_resource

  include VersionsHelper
  def index
    @versions = Version.all
  end
end
