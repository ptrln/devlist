var project_box_on_load = function(id, policy, signature) {  
    $("#edit-project-modal").on('show', function(){
      console.log('show')
      $("#edit-project-modal").css({
        'width': function () { 
          return ($(document).width() * .8) + 'px';  
        },
        'margin-left': function () { 
          return -($(this).width() / 2); 
        }
      });
    });

    $("#edit-project-modal").on('loaded', function(){
      new_project_form_load(id, policy, signature);
      console.log('wtf wtf wtf');
      console.log($(".project-form-cancel-btn"))
      $(".project-form-cancel-btn").on('click', function(e){
        e.preventDefault();
        console.log('clicked');
        $("#edit-project-modal").modal('hide');
      })
    });
    
    $("#projects-container").isotope({
        itemSelector : '.project',
        layoutMode : 'fitRows',
        getSortData : {
          created_at: function(el) {
            return el.find('.created_at').text();
          },
          updated_at: function(el) {
            return el.find('.updated_at').text();
          },
          followers: function(el) {
            return el.find('.followers').text();
          },
          creation_date: function(el) {
            return el.find('.creation_date').text();
          }
        }
      });

    $(".project-sort-option").on('click', function(event){
      event.preventDefault();

      $(".project-sorted-selected").html("Sort (" + $(event.target).html() + ")");

      $('#projects-container').isotope({
        sortBy : $(event.currentTarget).attr("data-sort"),
        sortAscending : $(event.currentTarget).attr("data-ascending") === 'true'
      });
    });

    $(".language-btn").on('click', function(event){
      event.preventDefault();

      if ($(event.target).hasClass('btn-blue')) { return; }
      $(".language-btn.btn-blue").removeClass('btn-blue').addClass('btn-gray');
      if ($(event.target).hasClass('button')) { 
        $(event.target).removeClass('btn-gray').addClass('btn-blue');
      } else {
        $(".language-btn.button[data-language='" + $(event.target).attr('data-language') + "']").removeClass('btn-gray').addClass('btn-blue');
      }

      $("#projects-container").isotope({filter: $(event.target).attr('data-language') });
    });

    $(document).trigger('resize');
}