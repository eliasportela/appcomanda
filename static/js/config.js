//const base_url = "http://localhost/comanda-server/api/";
//const base_url = "http://192.168.0.31/comanda-server/api/";
const base_url = "http://192.168.1.7/comanda-server/api/";
//const base_url = "http://10.0.6.142/comanda-server/api/";
const token = "26901dc4fb95fda80f7427b53f4136ca";

function openLoading(text) {
    document.getElementById("loading").style.display="block";
    document.getElementById("loading-text").innerHTML=text;
}

function closeLoading() {
    document.getElementById("loading").style.display='none';
}

function openModalMsg(title,text) {
  document.getElementById("modal-msg").style.display="block";
  document.getElementById("titulo-modal-msg").innerHTML=title;
  document.getElementById("msg-modal-msg").innerHTML=text;
}

function closeOnload() {
  document.getElementById("modal-onload").style.display='none';
}


