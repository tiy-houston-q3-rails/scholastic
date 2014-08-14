$(window).ready(function(){

  var scholasticBooks = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.obj.whitespace('value'),
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: '/?query=%QUERY'
  });

  scholasticBooks.initialize();

  $('.typeahead').typeahead(null, {
    name: 'query',
    displayKey: 'title',
    source: scholasticBooks.ttAdapter()
  }).on("typeahead:selected", function (event, data, dataset) {
      // console.log("data", data);
      window.location.href = "/?query=" + encodeURIComponent(data.title);
    });


	$('.fancybox-media').fancybox({
		openEffect  : 'none',
		closeEffect : 'none',
		helpers : {
			media : {}
		}
	});

  $('.fancybox').fancybox({
    openEffect  : 'none',
    closeEffect : 'none',
  });
});
