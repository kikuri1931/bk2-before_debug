$ ->
  $("#address_zipcode").jpostal({
    postcode : [ "#address_zipcode" ],
    address  : {
                  "#user_prefecture_code" : "%3",
                  "#user_address_city"            : "%4%5", 
                  "#user_address_street"          : "%6%7" 
                }
  })