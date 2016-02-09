/* -------------------------------
 * jQuery UI image magnifier
 *
 * Version: 1.0
 *
 * Copyright 2011, Arjan Scherpenisse <arjan@scherpenisse.net>
 *
 * Released under the MIT license
 */

(function($)
{
    $.widget("ui.imagemagnifier",
    {
	_init: function()
        {
            var self = this;

            self.target = self.element.find(".target");
            self.source = self.element.find(".source");

            self.loader = $("<div>")
                .addClass("loader")
                .appendTo(self.element)
                .hide()
                .append($("<img>").attr("src", "/lib/images/loader.gif"));

            self._load();
        },

        _load: function()
        {
            var self = this;
            // load image 
            if (self.indicator) self.indicator.remove();
            if (self.image) self.image.remove();
            self.loader.show();

            self.image = $("<img>")
                .attr("src", self.options.fullsize)
                .hide()
                .appendTo("body")
                .bind("load", function(){self._loaded();});
        },

        setImages: function(small, big) {
            var self = this;
            self.options.fullsize = big;
            self._load();
            self.source.attr("src", small);
        },

        _loaded: function()
        {
            var self = this;

            self.target.css({backgroundPosition: '50% 50%'});

            self.source
                .mouseover(function(e) {
                               self.active = true;
                               self._active(e);
                           })
                .mousemove(function(e) {
                               if (self.active) self._active(e);
                           })
                .mouseout(function(e) {
                             // self._inactive(e);
                          });
            self.indicator = $("<div>").css({'position': 'absolute',
                                             'top': 0,
                                             'left': 0,
                                             'background': 'white',
                                             'opacity': 0.5,
                                             width: 200,
                                             height: 200
                                             })
                .addClass("indicator")
                .mousemove(function(e) { self._active(e); })
                .mouseout(function(e) { self._inactive(e); })
                .appendTo("body");
            self.indicator.css({width: self.source.width()/self.image.width() * self.target.width(),
                                height: self.source.height()/self.image.height() * self.target.height()});
            self._inactive();
            self.loader.hide();
        },


        _inactive: function(e)
        {
            var self = this;
            self.active = false;
            self.target.hide();
            self.indicator.hide();
            self.target.css({background: ''});
        },

        _active: function(e) 
        {
            var self = this;
            var o = self.source.offset();
            o.top += parseInt(self.source.css("borderTopWidth"));
            o.left += parseInt(self.source.css("borderLeftWidth"));

            var iw = self.indicator.width()/2;
            var ih = self.indicator.height()/2;

            var x = e.pageX-o.left;
            var y = e.pageY-o.top;

            var horiz = Math.max(0, Math.min(1, (x-iw) / (self.source.width()-2*iw)));
            var vert = Math.max(0, Math.min(1, (y-ih) / (self.source.height()-2*ih)));

            self.target.css({backgroundImage: 'url('+self.options.fullsize+')'});
            self.target.css({backgroundPosition: horiz*100 + '% ' + vert*100 + '%'});

            self.target.show();

            self.indicator
                .show()
                .css({left: Math.min(Math.max(e.pageX - iw, o.left), o.left+self.source.width()-2*iw),
                      top: Math.min(Math.max(e.pageY - ih, o.top), o.top+self.source.height()-2*ih)
                      });
        }

    });
})(jQuery);
