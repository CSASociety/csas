module ApplicationHelper
  def atttachment_form(item)
    modal_dialog :id => "attach_to",
      :header => { :show_close => true, :dismiss => 'modal', :title => "Attach to #{item.title}" },
      :body => render(partial: "attachments/attach", locals: {item: item, attachment: Attachment.new}),
      :footer =>  content_tag(:button, 'Cancel', :class => 'btn btn-primary', :data => { :dismiss => 'modal' })
  end
end
