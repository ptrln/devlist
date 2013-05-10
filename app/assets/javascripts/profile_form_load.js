var profile_form_load = function(screen_name, policy, signature) {
  var bindSlider = function(index, el) {
    $(el).removeClass('ranged-slider-ui');
    $(el).slider({
      range: "min",
      min: 0,
      max: 100,
      step: 10,
      value: $(el).attr('data-value'),
      slide: function(event, ui) {
        $(event.target).parent().prev().find("input").val(ui.value);
        $(event.target).parent().prev().find("span").html(ui.value);
      }
    });
  }
 
  $(".add-contact-btn").on('click', function(event) {
    event.preventDefault();
    $ul = $(event.target).parent().prev();
    var render = JST['user/additional_contact']({
      count: $ul.find("li").length
    });
    $ul.append(render);
  });
  $(".add-skill-btn").on('click', function(event) {
    event.preventDefault();
    $ul = $(event.target).parent().prev();
    var render = JST['user/additional_skill']({
      count: $ul.find("li").length
    });
    $ul.append(render);
    $(".ranged-slider-ui").each(bindSlider);
  });

  $(".ranged-slider-ui").each(bindSlider);
  
  $('.verified-contacts-delete-btn').click(function(event){
    event.preventDefault();
    $el = $(event.currentTarget);
    $.ajax({
      url: "/profile/verified_contacts/" + $el.attr('data-id') + ".json",
      type: "delete",
      success: function() {
        $el.parent().parent().remove();
      }
    });
  });

  FilepickerImageUpload.initialize(
    screen_name,
    $("#userPhotoDropPane"),
    $("#userPhotoGallery"),
    'AdLaitW2LTVWJIJTgtAGRz',
    policy,
    signature,
    false,
    function(img) {
      var imgHTML = JST["user/photo_upload"]({
        img: img,
        key: window.filepicker_view_query
      });

      $.post(
        "/user/photo.json",
        {
          user_photo: {
            url: img.url
          }
        },
        function(response) {
          $(imgHTML).find(".upload-image-id").val(response.id);
        }
      );

      return imgHTML;
    }
  );

}