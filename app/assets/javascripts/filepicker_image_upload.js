window.FilepickerImageUpload = {
  initialize: function(userId, $dropPane, $imgGallery, key, policy, signature, multi, renderImage, refreshCallback) {
    (function(a){if(window.filepicker){return}var b=a.createElement("script");b.type="text/javascript";b.async=!0;b.src=("https:"===a.location.protocol?"https:":"http:")+"//api.filepicker.io/v1/filepicker.js";var c=a.getElementsByTagName("script")[0];c.parentNode.insertBefore(b,c);var d={};d._queue=[];var e="pick,pickMultiple,pickAndStore,read,write,writeUrl,export,convert,store,storeUrl,remove,stat,setKey,constructWidget,makeDropPane".split(",");var f=function(a,b){return function(){b.push([a,arguments])}};
      for(var g=0;g<e.length;g++){
        d[e[g]]=f(e[g],d._queue)
      }
      window.filepicker=d;
      filepicker.setKey(key);
      filepicker.makeDropPane($dropPane[0], {
        multiple: multi,
        mimetypes: 'image/png, image/jpeg',
        maxSize: 1024 * 1024 * 3,
        signature: signature,
        policy: policy,
        path: (userId ? "/devlist/user_" + userId : null),
        dragEnter: function() {
          $dropPane.html("Drop to upload").css({
            'backgroundColor': "#E0E0E0",
            'border': "1px solid #000"
          });
        },
        dragLeave: function() {
          $dropPane.html("Drop files here").css({
            'backgroundColor': "#F6F6F6",
            'border': "1px dashed #666"
          });
        },
        onSuccess: function(fpfiles) {
          var i = fpfiles.length == 1 ? "image" : "images";
          $dropPane.text("Done! " + fpfiles.length + " " + i + " uploaded.");
          var existingCount = $imgGallery.children().length;
          _(fpfiles).each(function(img){
            $newImg = $(renderImage(img, existingCount));
            existingCount++;
            if (multi)
              $imgGallery.append($newImg);
            else 
              $imgGallery.html($newImg);
            var $img = $newImg.find('img');
            var img = new Image();
            img.onload = function() {
              $img.removeClass('img-loading');
              $img.attr('src', img.src);
            };
            img.src = $img.attr('data-src');
          });
          if (refreshCallback) { refreshCallback(); }
        },
        onError: function(type, message) {
          $dropPane.text('('+type+') '+ message);
        },
        onProgress: function(percentage) {
          $dropPane.text("Uploading ("+percentage+"%)");
        }
      });
    })(document);
  }
};