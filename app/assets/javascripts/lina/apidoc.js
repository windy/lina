(function(){
  $(document).ready(function(){
    $('#tree').on('nodeSelected', function(event, node){
      if( ! node.value ){
        $('.api-content').hide();
        return;
      }
      $('.api-content').show();
      path = node.value.path;
      verb = node.value.verb;
      schema = node.value.schema;
      $('#path').text(verb + " " + path);
      $('#name').text(schema.name);
      $('#description').text(schema.description || "");
      var param;
      var tbody = $('#arguments tbody');
      tbody.empty();
      for (param in schema.params){
        if( param == 'required' ){
          continue;
        }
        var value = schema.params[param];
        var tr = $('<tr>').append( $('<td>').text(param) ).append( $('<td>').text(value.type)).append( $('<td>').text(value.description));
        tr.appendTo(tbody);
      }
    });
  });
})();
