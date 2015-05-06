module ApplicationHelper
  def atttachment_form(item, attachment=Attachment.new)
    modal_dialog :id => attachment.new_record? ? "attach_to" : "attach_to_#{attachment.id}",
      :header => { :show_close => true, :dismiss => 'modal', :title => "Attach to #{item.title}" },
      :body => render(partial: "attachments/attach", locals: {item: item, attachment: attachment}),
      :footer =>  content_tag(:button, 'Cancel', :class => 'btn btn-primary', :data => { :dismiss => 'modal' })
  end

  def markdown(text)
    renderOptions = {hard_wrap: true, filter_html: true}
    markdownOptions = {autolink: true, no_intra_emphasis: true}
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new(renderOptions), markdownOptions)
    markdown.render(text).html_safe
  end

  def possible_images(item)
    possible_images = Resource.where('file_content_type like ?', '%image%')
    if item.image.present?
      possible_images = possible_images - [item.image]
    end
    possible_images
  end
end
