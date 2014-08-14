module VersionsHelper
  def item(version)
    item = version.item_type.classify.constantize.find_by(id: version.item_id)
     if item.present?
       return item
     else
       return '(Item Deleted)'
     end
  end

end
