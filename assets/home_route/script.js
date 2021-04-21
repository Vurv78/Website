function updCharCount()
{
    let CharC = document.getElementById("webhooktext").value.length.toString();
    document.getElementById("charcountwbtext").innerHTML = CharC;
}
function submitDiscWebhook()
{
    document.getElementById("charcountwbtext").innerHTML = "Sent!";
    let URL = document.getElementById("webhooklink").value;
    let Str = document.getElementById("webhooktext").value;
    if(URL.length<1 || Str.length<1){
        alert("You need to input both a valid URL and a string.")
        return;
    }
    let request = new XMLHttpRequest();
    request.open("POST", URL);
    request.setRequestHeader('Content-type', 'application/json');
    request.send("{\"content\":\""+Str+"\"}");
}