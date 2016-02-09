/* -------------------------------
 * jQuery UI variant hover
 */

(function($)
{
    $.widget("ui.varianthover",
    {
	_init: function()
        {
            var self = this;
            var target = self.element.find(".metaframe-placeholder img");
            var images = self.element.find(".variants img");
            images.mouseover(function() {
                                 target.attr("src", $(this).parents("li:first").attr("data-variantimage"));
                             });
        }
    });

})(jQuery);
