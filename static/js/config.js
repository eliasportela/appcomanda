var base_url = "http://192.168.1.7/comanda-server/api/";

function openLoading(text) {
    document.getElementById("loading").style.display="block";
    document.getElementById("loading-text").innerHTML=text;
}

function closeLoading() {
    document.getElementById("loading").style.display='none';
}
