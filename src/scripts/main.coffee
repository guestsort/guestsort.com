`
//= require /../../bower_modules/modernizr/modernizr.js
//= require /../../node_modules/jquery/dist/jquery.js
`

# $(window).load ->
#   if window.location.host == "guestsort.com" and window.location.protocol != "https:"
#     window.location.protocol = "https"

$(document).ready ->

  $("section")
    .addClass('animated fadeInDown')
    .show()

  $("footer")
    .addClass('animated fadeInUp')
    .show()

  $("input[type=email]").focus()

  setInterval ->
    $("form").addClass("animated pulse")
  , 700