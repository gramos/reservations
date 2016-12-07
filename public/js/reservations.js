function fillField(name, customer, service_id) {
    var field_id   = 'reservation' + name + '_' + service_id;

    if(name.split('[customer]').length > 1) {
        customer_value = name.split('[customer]')[1];
    } else {
        customer_value = name.split('[customer]')[0];
    }

    customer_value = customer_value.replace(/\[/g, "['");
    customer_value = customer_value.replace(/\]/g, "']");

    if( eval("customer" + customer_value) != "undefined") {
        document.getElementById( field_id ).value = eval("customer" + customer_value) ;
    }
}

function completeMakeForm(customer_json, service_id, div_id) {
    var customer = JSON.parse(customer_json);

    field_list = ['[customer][first_name]',
                  '[customer][last_name]',
                  '[address][phone_number]',
                  '[address][street]',
                  '[address][apartment]',
                  '[address][number]',
                  '[address][tower]',
                  '[customer][id]'];

    for(i = 0; i < field_list.length; i++) {
        fillField( field_list[i], customer, service_id );
    }

    document.getElementById(div_id).style.display = "none";
    preloadAddress(customer, service_id);
}

function preloadAddress(customer, service_id){
    var div_id = 'livesearch_street_hidden_' + service_id;
    var div = document.getElementById(div_id);
    div.innerHTML = '';

    for(i = 0; i < customer['addresses'].length; i++) {
        div.innerHTML += customer['addresses'][i]['street'] + '<br/> ';
    }
}

function showAddressResult(str, service_id) {
    div_hidden = document.getElementById('livesearch_street_hidden_' + service_id)
    div = document.getElementById('livesearch_street_' + service_id)

    address_list = div_hidden.innerHTML.split("<br>");

    filtered_list = address_list.filter( function(val){
        var re = new RegExp(str, 'gi');
        return val.match(re);
    } )

    div.innerHTML = '';
    for(i = 0; i < filtered_list.length; i++) {
        div.innerHTML += "<a class='sugesstion' href='#'>" +
                          filtered_list[i] + "</a><br />";
    }
}

function showResult(str, div, service_id) {
    if (str.length > 2) {
      document.getElementById(div).style.display = "block";
      str    = str.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');

      var re = new RegExp("(" + str.split(' ').join('|') + ")", "gi");
      var hidden_customer_id = 'reservation[customer][id]_' + service_id;

      if (window.XMLHttpRequest) {
          xmlhttp = new XMLHttpRequest();
      } else {
          xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
      }

      xmlhttp.onreadystatechange = function() {

          if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
              results = JSON.parse( xmlhttp.response.replace(re, "<b>$1</b>") );
              var plain_results = JSON.parse( xmlhttp.response);
              document.getElementById( div ).innerHTML = '';
              document.getElementById(hidden_customer_id).value = '';

              if (plain_results == '') {
                 document.getElementById( div ).innerHTML = 'No hay coincidencias...';              }

              for(i = 0; i < results.length; i++) {
                  document.getElementById( div ).

                  innerHTML += "<a class='suggestion' href='#' onclick='completeMakeForm(&#39;" +
                      JSON.stringify( plain_results[i] ) + "&#39;, " +
                      service_id + ",&#39" + div + "&#39)'>" +

                results[i]['last_name'] + " " + results[i]['first_name'] + "</a><br />";
            }

            document.getElementById( div ).style.border = "1px solid #A5ACB2";
        }
    }

    xmlhttp.open("GET","/customers?q=" + str, true);
    xmlhttp.send();

 }
}
