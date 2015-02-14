$(document).ready(function(){
  $('.api-content').delegate('.name', 'click', function(){
    $(this).siblings('div').hide();
    $($(this).next('div')).toggle();
  })
})
