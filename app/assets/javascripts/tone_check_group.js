// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){
    $('.delete_group').click(function(el){
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
});

