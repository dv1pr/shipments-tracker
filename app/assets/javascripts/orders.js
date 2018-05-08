$(document).on('turbolinks:load', function() {
  if ($('body').is('#orders')){
    // Window redirect to new customer location
    $('#location-selector').change(function() {
      window.location.href = '/customers/' + $(this).find(":selected").data("customer") + '/locations/' + $(this).find(":selected").data("location") + "/orders"
    });

    // Buttons
    $('#attention-btn').click(function() {
      $('#all-row').hide()
      $('#attention-row').show()
      $(this).removeClass().addClass('btn btn-primary')
      $('#all-btn').removeClass().addClass('btn btn-default')
    });
    $('#all-btn').click(function() {
      $('#all-row').show()
      $('#attention-row').hide()
      $(this).removeClass().addClass('btn btn-primary')
      $('#attention-btn').removeClass().addClass('btn btn-default')
    });

    // Google Maps
    var location = JSON.parse(document.querySelector('#map').dataset.location);

    var map = new GMaps({
      div: '#map',
      lat: location.latitude,
      lng: location.longitude
    });

    map.addMarker({
      lat: location.latitude,
      lng: location.longitude,
      title: location.name
    });
  }
})
