// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
    $('a.delete_group').click(function(el){
        $('#delete_confirm_modal .name').html($(this).attr('data_name'));
        $('#delete_confirm_modal').modal('show');
        $('#delete_confirm_modal .btn-danger').unbind('click');
        var that = this;
        $('#delete_confirm_modal .btn-danger').click(function(){
           var form = $("<form method='post'>").attr('action', '/tone_check_groups/' + $(that).attr('data_id'));
            form.append($("<input type='hidden' name='_method' value='delete'>"));
            form.append($("<input type='hidden' name='authenticity_token'>").val($('meta[name=csrf-token]').attr('content')));
            form.submit();
        });
    });

    $('a.recheck_group').click(function(el){
        $('#recheck_confirm_modal').modal('show');
        var that = this;
        $('#recheck_confirm_modal .btn-danger').click(function(){
            var form = $("<form method='post'>").attr('action', $(that).attr('href'));
            form.append($("<input type='hidden' name='_method' value='post'>"));
            form.append($("<input type='hidden' name='authenticity_token'>").val($('meta[name=csrf-token]').attr('content')));
            form.submit();
        });

        return false;
    });

    $('a.download_report').click(function(el){
        $('#download_report_modal').modal('show');
    });

    $('a.edit_check').click(function(el){
        var that = this;
        $.get($(this).attr('href'), function(data){
            $('#edit_check_modal .number').text(data.number);
            $('#edit_check_modal form').attr('action', $(that).attr('href'));

            for( var key in data) {
                $('#edit_check_modal input.' + key).val(data[key]);
                $('#edit_check_modal textarea.' + key).val(data[key]);
            }

            $('#edit_check_modal .btn-success').click(function(){
                $("#edit_check_modal form").submit();
            });
            $('#edit_check_modal').modal('show');
        });

        return false;
    });

});

