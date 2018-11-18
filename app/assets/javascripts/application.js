var Dashboard = function () {
    var global = {
        tooltipOptions: {
            placement: "right" },

        menuClass: ".c-menu" };


    var menuChangeActive = function menuChangeActive(el) {
        var hasSubmenu = $(el).hasClass("has-submenu");
        $(global.menuClass + " .is-active").removeClass("is-active");
        $(el).addClass("is-active");

        // if (hasSubmenu) {
        //  $(el).find("ul").slideDown();
        // }
    };

    var sidebarChangeWidth = function sidebarChangeWidth() {
        var $menuItemsTitle = $("li .menu-item__title");

        $("body").toggleClass("sidebar-is-reduced sidebar-is-expanded");
        $(".hamburger-toggle").toggleClass("is-opened");

        if ($("body").hasClass("sidebar-is-expanded")) {
            $('[data-toggle="tooltip"]').tooltip("destroy");
        } else {
            $('[data-toggle="tooltip"]').tooltip(global.tooltipOptions);
        }

    };

    return {
        init: function init() {
            $(".js-hamburger").on("click", sidebarChangeWidth);

            $(".js-menu li").on("click", function (e) {
                menuChangeActive(e.currentTarget);
            });

            $('[data-toggle="tooltip"]').tooltip(global.tooltipOptions);
        } };

}();

Dashboard.init();



$('#add-row').on 'click', (e) ->
  e.preventDefault()
  table_body = $(e.target).data().table
  if table_body
    add_row(table_body)

add_row = (table_body_element) ->
# Get some variables for the tbody and the row to clone.
  $tbody = $('#' + table_body_element)
  $rows = $($tbody.children('tr'))
  $cloner = $rows.eq(0)
  count = $rows.length

  # Clone the row and get an array of the inputs.
  $new_row = $cloner.clone()
  inputs = $new_row.find('.dyn-input')

  # Change the name and id for each input.
  $.each(inputs, (i, v) ->
    $input = $(v)

    # Find the label for input and adjust it.
    $label = $new_row.find("label[for='#{$input.attr('id')}']")
    $label.attr( {'for': $input.attr('id').replace(/\[.*\]/, "[#{count + 1}]")} )

    $input.attr({
      'name': $input.attr('name').replace(/\[.*\]/, "[#{count + 1}]"),
      'id': $input.attr('id').replace(/\[.*\]/, "[#{count + 1}]")
    })

    # Remove values and checks.
    $input.val('')
    checked = $input.prop('checked')
    if checked
      $input.prop('checked', false)
  )

  # Add the new row to the tbody.
  $tbody.append($new_row)
