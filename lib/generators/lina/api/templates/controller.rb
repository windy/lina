<% if namespaced? -%>
require_dependency "<%= namespaced_path %>/application_controller"

<% end -%>
<% module_namespacing do -%>
class <%= class_name %>Controller < Lina::ApplicationController
<% actions.each do |action| -%>
  # def <%= action %>
  define_action :<%= action %>, {
    name: '<%= action %>',
    description: '',
    params: {
      type: 'object',
      properties: {
      }
    },
    return: {
    }
  } do
    # write code here, It's the same as before
  end
<%= "\n" unless action == actions.last -%>
<% end -%>
end
<% end -%>
