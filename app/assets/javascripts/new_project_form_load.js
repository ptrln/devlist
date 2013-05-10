var new_project_form_load = function(projectId, policy, singature) {

  $(".datepicker").datepicker({"dateFormat": "yy-mm-dd", showButtonPanel: true});

    $('#technologies').tagsInput({
      'defaultText':'add a technology',
      'minChars' : 1        
    });

    var refreshOrder = function() {
      var order = 0;
      $(".project-image-ordering").each(function(index, elem){
        $(elem).val(order++);
      });
     };

    var bindRemoveCallback = function($buttons) {
      $buttons.on('click', function(event) {
        event.preventDefault();

        $.ajax({
          url: "/project/images/" + $(event.currentTarget).attr('data-id') + ".json",
          type: "delete"
        });

        $(event.currentTarget).parent().parent().remove();  // immediately remove, hopefully ajax worked
      });
    };

    bindRemoveCallback($(".remove-image-btn"));

    $("#projectImageEditGallery").sortable({
      update: refreshOrder
    });

    FilepickerImageUpload.initialize(
      null,
      $("#projectImageDropPane"),
      $("#projectImageEditGallery"),
      'AdLaitW2LTVWJIJTgtAGRz',
      policy,
      singature,
      true,
      function(img, existingCount) {
        var imgHTML = JST["project/image_upload"]({
          img: img,
          key: window.filepicker_view_query
        })

        var $img = $(imgHTML);
        $.post(
          "/project/images.json",
          {
            project_image: {
              project_id: projectId,
              url: img.url,
              ordering: existingCount
            }
          },
          function(response) {
            $img.find(".upload-image-id").attr("value", response.id);
            $img.find(".remove-image-btn").attr('data-id', response.id);
            console.log($img.find(".upload-image-id").val());
            console.log($img.find(".remove-image-btn").attr('data-id'));
            bindRemoveCallback($img.find(".remove-image-btn"));
          }
        );

        return $img;
      },
      refreshOrder
    );

}