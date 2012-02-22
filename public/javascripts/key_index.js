function page_go()
{
	window.location.href="/page/"+ $F("page_search")+"/keys"
}
function checkEnter(event)
{     
    var code = 0;
    
    code = event.keyCode;
    if (code==13)
        page_go();
}

function start()
{
	var page_search_auto_completer = new Ajax.Autocompleter('page_search', 'page_search_auto_complete', '/keys/auto_complete_for_page_search', {})
}
Event.observe(window,"load",start);