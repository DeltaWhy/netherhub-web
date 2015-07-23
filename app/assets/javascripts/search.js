$(function() {
  $('#search-form').submit(function(e) {
    var query = $('#search-form').serialize();
    $('#search-results').load("/search?"+query+" #search-results");
    e.preventDefault();
  });
  $('#search-form input[name=q]').keyup(function(e) {
    var q = $(this).val();
    if (q.length <= 3) return;
    var query = $('#search-form').serialize();
    $('#search-results').load("/search?"+query+" #search-results");
  });
});
