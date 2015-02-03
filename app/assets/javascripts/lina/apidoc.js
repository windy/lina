(function(){
  $(document).ready(function(){
    $('#tree').on('nodeSelected', function(event, node){
      $('#name').text(node.value.path);
    });
  });
})();
