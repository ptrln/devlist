window.ProjectImageUploadFP = {
  initialize: function(projectId, $dropPane, $imgGallery, key, policy, signature) {
    var tokenValue = $("meta[name='csrf-token']").attr('content');
    $.ajaxSetup({
      headers: {'X-CSRF-Token': tokenValue}
    });
    (function(a){if(window.filepicker){return}var b=a.createElement("script");b.type="text/javascript";b.async=!0;b.src=("https:"===a.location.protocol?"https:":"http:")+"//api.filepicker.io/v1/filepicker.js";var c=a.getElementsByTagName("script")[0];c.parentNode.insertBefore(b,c);var d={};d._queue=[];var e="pick,pickMultiple,pickAndStore,read,write,writeUrl,export,convert,store,storeUrl,remove,stat,setKey,constructWidget,makeDropPane".split(",");var f=function(a,b){return function(){b.push([a,arguments])}};
      for(var g=0;g<e.length;g++){
        d[e[g]]=f(e[g],d._queue)
      }

      var refreshOrder = function() {
        var order = 0;
        $(".project-image-ordering").each(function(index, elem){
          $(elem).val(order++);
        });
      };

      $imgGallery.sortable({
        update: refreshOrder
      });
      
      window.filepicker=d;
      filepicker.setKey(key);
      filepicker.makeDropPane($dropPane[0], {
        multiple: true,
        mimetypes: 'image/png, image/jpeg',
        maxSize: 1024*1024*3,
        signature: signature,
        policy: policy,
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
            var existingCount = $(".project-image-ordering").length;
            _(fpfiles).each(function(img){

              $newImg = $(JST["project/image_upload"]({
                img: img,
                key: window.filepicker_view_query
              }));
              $.post(
                "/project_images.json",
                {
                  project_image: {
                    project_id: projectId,
                    url: img.url,
                    ordering: existingCount
                  }
                },
                function(response) {
                  $newImg.find(".project-image-id").val(response.id);
                }
              );
              existingCount++;
              $imgGallery.append($newImg);
              var $img = $newImg.find('img');
              var img = new Image();
              img.onload = function() {
                $img.removeClass('img-loading');
                $img.attr('src', img.src);
              };
              img.src = $img.attr('data-src');
            });
            refreshOrder();
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