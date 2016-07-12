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
      // CHANGE BOOTSTRAP FORM THING
    }
  });

});
