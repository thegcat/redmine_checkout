$(function() {
  /* update the checkout URL if clicked on a protocol */
  $('#checkout_protocols').select('a').each(function(e) {
    $(e).click(function(event) {
      $('#checkout_url').value = checkout_commands.get(this.id);
      $('#checkout_protocols').find('a').each(function(e) {
        e.removeClass("selected");
      });
      $(this).addClass("selected")
      
      var access = $('#checkout_access');
      if (access) {
        var value = window.checkout_access.get(this.id);
        access.innerHTML = value;
      }
      
      event.stopPropagation();
    });
  });
  /* select the text field contents if activated */
  $('#checkout_url').click(function(event) {
   this.activate();
  });

  if (typeof('ZeroClipboard') != 'undefined') {
    $('#clipboard_container').show();
    clipboard = new ZeroClipboard.Client();
    clipboard.setHandCursor( true );
    clipboard.glue('clipboard_button', 'clipboard_container');

    clipboard.addEventListener('mouseOver', function (client) {
      clipboard.setText( $('#checkout_url').val() );
    });
  }
});