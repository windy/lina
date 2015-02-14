(function(){
  $(document).ready(function(){
    $('#tree').on('nodeSelected', function(event, node){
      if( ! node.values.length ){
        $('.api-content').hide();
        return;
      }
      $('.api-content').show();
      $('.api-content').empty();
      var api_content = $('.api-content');
      node.values.forEach( function(node_value, index){
        path = node_value.path;
        verb = node_value.verb;
        schema = node_value.schema;
        $('<h2 class="name" >').text(schema.name).appendTo(api_content);
        var api_sub_content = $('<div>').appendTo(api_content);
        if( index != 0 ) {
          api_sub_content.hide();
        }
        $('<p class="path" >').text(verb + " " + path).appendTo(api_sub_content);
        $('<p class="description" >').text(schema.description || "").appendTo(api_sub_content);

        var table = $('<table class="table"><thead><tr><th>Name</th><th>Type</th><th>Description</th></tr></thead><tbody></tbody></table>');
        table.appendTo(api_sub_content);
        var param;
        var tbody = table.children('tbody');
        for (param in schema.params){
          if( param == 'required' ){
            continue;
          }
          var value = schema.params[param];
          var tr = $('<tr>').append( $('<td>').text(param) ).append( $('<td>').text(value.type)).append( $('<td>').text(value.description));
          tr.appendTo(tbody);
        }
      }) // end of for
    });
  });
})();
