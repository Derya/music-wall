$(document).ready(function() {

  $('#register-button').click(function() {
    event.preventDefault();
    $('#login-form').toggle(600);
    $('#register-form').toggle(600);
  });

  $('#register-cancel-button').click(function() {
    event.preventDefault();
    $('#login-form').toggle(600);
    $('#register-form').toggle(600);
  });

  $('#register-form-submitter').click(function() {
    if ($('#password_register').val() == $('#password_check').val())
    {

    }
    else
    {
      event.preventDefault();
      //TODO perhaps we can send error data about the form here
    }
  });


  $('.updownvotebutton').click(function() {

    button = $(this);
    span1 = button.children(":first");
    span2 = button.children(":nth-child(2)");
    send_url = button.attr('elephants');

    $.ajax({
      method: "GET",
      url: send_url,
      success: function() {
        span1.toggleClass('glyphicon-thumbs-down');
        span1.toggleClass('glyphicon-thumbs-up');
        button.toggleClass('btn-danger');
        button.toggleClass('btn-success');
        if (button.hasClass('btn-danger'))
        {
          new_send_url = send_url.replace("upvote","downvote");
          new_html = (parseInt(span2.html()) - 1).toString();
        }
        else
        {
          new_send_url = send_url.replace("downvote","upvote");
          new_html = (parseInt(span2.html()) + 1).toString();
        }
        button.attr('elephants', new_send_url);
        span2.html(new_html);
      }
    });
  });

  $('.nav li').hover(function() {
    $(this).toggleClass('active');
  });

  // so a lot of these are only for one page but idk if that is ok
  $('.track-right-box').bind('mouseenter', function(){
    var $this = $(this);

    if(!$this.attr('title')){
        $this.attr('title', $this.text());
    }
  });

  //TODO perhaps we can also have functionality on user login form error data here

});


$(document).on('ready', function(){
    $('#rating-display').rating({displayOnly: true, step: 0.5});
});




