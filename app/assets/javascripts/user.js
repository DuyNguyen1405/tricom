// init search table
$(function() {
    oTable = $('#user_table').DataTable({
        "pagingType": "full_numbers"
        , "oLanguage": {
            "sUrl": "../../assets/resource/dataTable_"+$('#language').text()+".txt"
        },
        "aoColumnDefs": [
            { "bSortable": false, "aTargets": [ 3,4 ]},
            {
                "targets": [3,4],
                "width": '5%'
            }
        ],
        "columnDefs": [ {
            "targets"  : 'no-sort',
            "orderable": false
        }]
        ,"oSearch": {"sSearch": queryParameters().search}
    });
});
