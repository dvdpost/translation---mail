function go()
{
	window.location.href="/mails/"+ document.getElementById("search").value
}
function checkEnter(event)
{     
    var code = 0;
    code = event.keyCode;
    if (code==13)
        go();
}

