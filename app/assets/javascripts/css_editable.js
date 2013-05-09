var css_editable = function() {

  $("#css-editor").text($(".user-in-page-css").html());

  var cssEditor = CodeMirror.fromTextArea(document.getElementById("css-editor"), {
    mode:  "css",
    lineWrapping: true,
    lineNumbers: true,
    viewportMargin: Infinity,
    tabSize: true,
    theme: "monokai"
  });

  var VALID_CSS_REGEX = /^((\/\*[^\/]*\*\/)*\s*(([.#]?([a-zA-Z_0-9-]+|>) *)+\{\s*(((([a-zA-Z-])+\ *\:[^;]+;)|(\/\*[^\/]*\*\/))*\s*)*\})+\s*)*\s*$/;

  var refreshCSS = function(event) {
    if (event) { event.preventDefault(); }
    if (VALID_CSS_REGEX.test(cssEditor.getValue()))
      $(".user-in-page-css").html(cssEditor.getValue());
    else
      alert('invalid css');
  };

  $(".css-refresh-btn").on('click', refreshCSS);

  $(".css-save-btn").on('click', function(event) {
    event.preventDefault();
    $(".css-editor-fixed").block({ message: '<i class="icon-spinner icon-spin"></i> One moment...' }); 
    if (VALID_CSS_REGEX.test(cssEditor.getValue())) {
      $.post("/css.json", {css: cssEditor.getValue()}, function() {
        $(".css-editor-fixed").unblock();
        refreshCSS();
        $(".edit-css-btn").show();
        $(".css-editor-fixed").addClass("css-editor-fixed-hidden");
        $(".profile-panel").removeClass("span9").removeClass("offset3").addClass("span12");
        $(document).trigger('resize');
      });
    }
  });

  $(".css-cancel-btn").on('click', function(event) {
    event.preventDefault();      
    $(".user-in-page-css").html($(".tmp-css-store").html());
    $(".edit-css-btn").show();
    $(".css-editor-fixed").addClass("css-editor-fixed-hidden");
    $(".profile-panel").removeClass("span9").removeClass("offset3").addClass("span12");
    $(document).trigger('resize');
  });

  $(".edit-css-btn").on('click', function(event) {
    event.preventDefault();
    $(".edit-css-btn").hide();
    $(".tmp-css-store").html($(".user-in-page-css").html());
    cssEditor.setValue($(".user-in-page-css").html());
    $(".css-editor-fixed").removeClass("css-editor-fixed-hidden");
    $(".profile-panel").addClass("span9").addClass("offset3").removeClass("span12");
    $(document).trigger('resize');
  });

  $(".css-template-li").on('click', function(event){
    event.preventDefault();
    $(".css-editor-fixed").block({ message: '<i class="icon-spinner icon-spin"></i> One moment...' }); 
    var $el = $(event.currentTarget);
    $.get("/css/" + $el.attr('data-template'), function(data){
      $(".css-editor-fixed").unblock();
      cssEditor.setValue(data);
      refreshCSS();
    });
  });

};