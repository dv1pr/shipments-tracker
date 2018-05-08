$(document).on('turbolinks:load', function() {
  if ($('body').is('#locations')){
    // Google Maps
    var l_map = new GMaps({
      div: '#locations_map',
      lat: -12.043333,
      lng: -77.028333,
      zoom: 1
    });

    var locations = JSON.parse(document.querySelector('#locations_map').dataset.locations);
    locations.forEach(function(location) {
      l_map.addMarker({
        lat: location.latitude,
        lng: location.longitude,
        title: location.name,
      });
    })
  }
})
