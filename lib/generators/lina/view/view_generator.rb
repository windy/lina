class Lina::ViewGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  argument :actions, type: :array, default: [], banner: "action1 action2"

  desc "Create lina view(s)"

  def copy_view_files
    base_path = File.join("app/views", class_path, file_name)
    empty_directory base_path

    actions.each do |action|
      @action = action
      @path = File.join(base_path, "#{action}.json.jbuilder")
      template 'view.json.jbuilder', @path
    end
  end
end
