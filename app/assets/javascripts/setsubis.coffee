# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  oTable = $('.shonin-table').DataTable({
    "pagingType": "full_numbers",
    "oLanguage":{
      "sUrl": "../../assets/resource/dataTable_"+$('#language').text()+".txt"
    },
    "aoColumnDefs": [
      { "bSortable": false, "aTargets": [ 3,4 ]},
      {"targets": [3,4],"width": '5%'}
    ],
    "columnDefs": [{
      "targets"  : 'no-sort',
      "orderable": false
    }]
    ,"oSearch": {"sSearch": queryParameters().search}
  })