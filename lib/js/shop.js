$(function()
{
    $("a.view-variant-image").click(
        function() {
            console.log(this);
            var small = $(this).attr("data-smallimage");
            var big = $(this).attr("data-bigimage");
            $(".main-image .do_imagemagnifier").imagemagnifier("setImages", small, big);

        });


    $(function()
      {
          var overlay = null;
          var lightbox = null;
          var loader;

          function allImages()
          {
              var result = [];
              $("div.variant-thumbs a.view-variant-image").each(function(){result.push($(this).attr("data-bigimage"));});
              return result;
          }
          
          function lightboxPrev()
          {
              var img = lightbox.find("img.source");
              var current = img.attr("src");
              var all = allImages();
              var next = all[($.inArray(current, all)+all.length-1)%all.length];
              loader.show();
              img.attr("src", next).load(function(){loader.hide();});
          }

          function lightboxNext()
          {
              var img = lightbox.find("img.source");
              var current = img.attr("src");
              var all = allImages();
              var next = all[($.inArray(current, all)+1)%all.length];
              loader.show();
              img.attr("src", next).load(function(){loader.hide();});
          }
          
          function productLightbox()
          {
              if (overlay) return;
              $("body").css({overflow: 'hidden'});
              overlay = $("<div>").addClass("overlay").appendTo("body").click(hideLightbox);
              var src = $(".main-image .do_imagemagnifier").data("imagemagnifier").options.fullsize;

              var o = $(".main-image .do_imagemagnifier").offset();
              var w = $(".main-image .do_imagemagnifier").width();
              if (o.left+w > 1040)
                  o.left = 1040-w;

              lightbox = $("<div>")
                  .addClass("lightbox")
                  .append(
                      $("<img>")
                          .addClass("source")
                          .attr("src", src)
                  )
                  .append(
                      $("<a>").attr("href", "javascript:;")
                          .addClass("close")
                          .click(hideLightbox))
                  .appendTo("body")
                  .css({left: o.left+"px", top: o.top+"px"})
                  .hide()
                  .fadeIn();

              if (allImages().length)
              {
                      lightbox.append(
                          $("<a>").attr("href", "javascript:;")
                              .addClass("right")
                              .click(lightboxNext)
                      )
                      .append(
                          $("<a>").attr("href", "javascript:;")
                              .addClass("left")
                              .click(lightboxPrev)
                      );
              }

              loader = $("<div>")
                .addClass("loader")
                .appendTo(lightbox)
                .hide()
                .append($("<img>").attr("src", "/lib/images/loader.gif"));

          }
          function hideLightbox()
          {
              $("body").css({overflow: ''});
              lightbox.remove();
              overlay.remove();
              overlay = null;
          }
          $("body").delegate("div.indicator", "click", productLightbox);
      });

});
