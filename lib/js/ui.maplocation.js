/* -------------------------------
 * jQuery UI googlemap
 */

(function($)
{
    $.widget("ui.maplocation",
    {
	_init: function()
        {
            var self = this;
            console.log(this.element);
            console.log(this.options);

            var point = new google.maps.LatLng(this.options.lat, this.options.lon);
            var myOptions = {
                center: point,
                zoom: 12,
                mapTypeId: google.maps.MapTypeId.ROADMAP
            };
            var map = new google.maps.Map(this.element.get(0), myOptions);

            var marker = new google.maps.Marker(
		{
		    position:           point,
		    map: 		map,
		    title:		self.options.title,
		    icon:		'/lib/images/map_icon.png'
		});
        }
    });

})(jQuery);
