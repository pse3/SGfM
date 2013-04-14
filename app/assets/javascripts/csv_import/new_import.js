$(document).ready(function() {

    var id = 0;

    $('#add_row').click( function(){

        $.get("/en/csv_import/import/add_row/" + id, function(data) {
            id++;
            $('#information_table').append(data);

            // Clicking on the remove column will delete the row.
            $('.delete').click( function(){
                $(this).parent().remove();
            });
        });


    });

});