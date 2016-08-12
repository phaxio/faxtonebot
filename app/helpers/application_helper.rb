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

  def render_flashes
    html = ""
    flash.each do |name, msg|
      className = name

      if name == "alert"
        className = "danger"
      elsif name == "notice"
        className = 'success'
      end

      html << content_tag(:div, class: "flash alert alert-dismissible alert-#{className}") do
        content_tag(:button, '×', type: "button", class: "close", "data-dismiss": "alert") + msg
      end
    end

    html.html_safe
  end

end
