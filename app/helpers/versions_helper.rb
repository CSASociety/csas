module VersionsHelper
  def item(version)
    return version.item_type.classify.constantize.find(version.item_id)
  end

end
