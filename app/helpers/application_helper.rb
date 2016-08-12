module ApplicationHelper
  def error_for_field(builder, fieldName, overrideName=nil)
    if not builder.object.errors[fieldName].empty?
      if overrideName.nil?
        message = builder.object.errors.full_messages_for(fieldName)[0]
      else
        message = overrideName + ' ' + builder.object.errors[fieldName][0]
      end
      html = <<-HTML
        <div class='text-danger'>#{message}</div>
      HTML
      html.html_safe
    end
  end

  def resource_errors(resource)
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:div, msg) }.join

    html = <<-HTML
    <div class="alert alert-danger">
      #{messages}
    </div>
    HTML

    html.html_safe
  end
end
