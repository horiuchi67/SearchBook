$(document).on('turbolinks:load', function(){
  $("#user_postal_code").jpostal({
    postcode : [ "#user_postal_code" ],
    address  : {
                  "#user_prefecture_code" : "%3",
                  "#user_address_city"            : "%4%5",
                  "#user_address_street"          : "%6%7"
                }
  });
});