function val(id_select){
    var service_id = id_select.split('_')[2];
    var id_quantity_input  = 'quantity_input_' + service_id;
    var id_quantity_select = 'quantity_select_' + service_id;

    select = document.getElementById(id_select);

    if ( (select.options[select.selectedIndex].value == '5') ||
         (select.options[select.selectedIndex].value == '2') ){

        document.getElementById(id_quantity_input).style.display = "block";

        if (document.getElementById(id_quantity_select) != null) {
          document.getElementById(id_quantity_select).style.display = "none";
        }

    } else {

        document.getElementById(id_quantity_input).style.display = "none";
        document.getElementById(id_quantity_select).style.display = "block";
    }
}

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
                  '[customer][mobile]',
                  '[address][phone_number]',
                  '[address][street]',
                  '[address][apartment]',
                  '[address][number]',
                  '[address][floor]',
                  '[address][tower]',
                  '[customer][id]'];

    for(i = 0; i < field_list.length; i++) {
        fillField( field_list[i], customer, service_id );
    }

    document.getElementById(div_id).style.display = "none";
    return customer;
}

function completeAddressInfo(address_id, service_id){

    address = customer['addresses'].filter(function(a){
        return a['id'] == address_id;})[0];

    var street =  document.getElementById('reservation[address][street]_' + service_id);
    var number = document.getElementById('reservation[address][number]_' + service_id);
    var tower =  document.getElementById('reservation[address][tower]_' + service_id);
    var apartment =  document.getElementById('reservation[address][apartment]_' + service_id);
    var id  =  document.getElementById('reservation[address][id]_' + service_id)

    street.value = address['street'];
    number.value = address['number'];
    tower.value  = address['tower'];
    apartment.value = address['apartment'];
    id.value = address['id'];
    document.getElementById('livesearch_street_' + service_id).style.display = "none";


}

function showAddressResult(str, customer, service_id) {
    var re;
    div = document.getElementById('livesearch_street_' + service_id)

    addresses = customer['addresses'];

    filtered_list = addresses.filter( function(a){
        re = new RegExp(str, 'gi');
        return a['street'].match(re);
    } )


    div.style.display = "block";
    div.innerHTML = '';
    document.getElementById('reservation[address][id]_' + service_id).value = '';

    if (filtered_list == '') {
      div.innerHTML = 'No hay coincidencias...';
    }


    for(i = 0; i < filtered_list.length; i++) {
        div.innerHTML += "<a class='suggestion' href='#servicio_" + service_id + "' " +
            "onclick='completeAddressInfo(" + filtered_list[i]['id'] +
            "," + service_id + ")'>" + filtered_list[i]['street'] + "</a><br />";
    }
}

function showResult(str, div, service_id) {
    if (str.length > 1) {
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

                  innerHTML += "<a class='suggestion' href='#servicio_" + service_id + "' onclick='customer = completeMakeForm(&#39;" +
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

function closeDiv(div) {
  div.style.display = 'none';
}
