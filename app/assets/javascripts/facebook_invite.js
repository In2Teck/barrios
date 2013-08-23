$(document).on("ready", init);

function init(){
  $("#invite-friends").on("click", sendInvites); 
  loadFB();
  ids = getFriendsParticipating(app_key, access_token);
}

function getFriendsParticipating(app_key, access_token){
  ids = [];
  $.getJSON('https://api.facebook.com/method/fql.query?query=SELECT uid, name FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1=me()) AND is_app_user='+app_key+' LIMIT 8&access_token='+access_token+'&format=json', function(data) {
    var items = [];
    $.each(data, function(key, val) {
      ids.push(val.uid);
      items.push('<img class="alreadyfriends" src="https://graph.facebook.com/' + val.uid + '/picture?width=50&height=50"/>');
      
    });
    for (var i = 0; i <= items.length ; i++) {
      $( "#friends" ).append( items[i] );
    };
  });
  return ids;
}

function sendInvites() {
  FB.ui({method: 'apprequests',
    message: 'Yo ya estoy corriendo por '+ hood_name +'. Te reto a que corras por tu barrio.',
    exclude_ids: ids
    }, function(){
    // termino
    });
}

function loadFB() {
  window.fbAsyncInit = function() {
    // init the FB JS SDK
    FB.init({
      appId      : app_key, // App ID from the App Dashboard
      channelUrl : 'http://werunmexico.com/channel.html', // Channel File for x-domain communication
      status     : true, // check the login status upon init?
      cookie     : true, // set sessions cookies to allow your server to access the session?
      xfbml      : true  // parse XFBML tags on this page?
    });

    FB.getLoginStatus(function(response) {
      if (response.status === 'connected') {
        if ($('#ruby-session').data("session")) {
          $(document).trigger('fbLoaded');
        }
        else {
          $.ajax({
            beforeSend: function( xhr ) {
              var token = $('meta[name="csrf-token"]').attr('content');
              if (token) xhr.setRequestHeader('X-CSRF-Token', token);
            }, 
            type: "GET",
            url: "/users/auth/facebook/callback?signed_request=" + $('#ruby-values').data("signed-request"),
            success: function(data, textStatus, jqXHR) {
              $(document).trigger('updateData', data);   
            },
            error: function() {
            } 
          });
          //window.location.href = '/users/auth/facebook/callback?signed_request=' + $('#ruby-values').data("signed-request");
        }
      } else if (response.status === 'not_authorized') {
        login();
      } else {
        login();
      }
     });
    };
  // Load the SDK's source Asynchronously
  // Note that the debug version is being actively developed and might 
  // contain some type checks that are overly strict. 
  // Please report such bugs using the bugs tool.
  (function(d, debug){
     var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
     if (d.getElementById(id)) {return;}
     js = d.createElement('script'); js.id = id; js.async = true;
     js.src = "//connect.facebook.net/es_LA/all" + (debug ? "/debug" : "") + ".js";
     ref.parentNode.insertBefore(js, ref);
   }(document, /*debug*/ false));
}
