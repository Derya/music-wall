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

  $('.nav li').hover(function() {
    $(this).toggleClass('active');
  });

  //TODO perhaps we can also have functionality on user login form error data here

});
