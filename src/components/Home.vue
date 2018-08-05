<template>
  <div class="container-home">
    <div class="w3-margin-bottom">
      <img src="/static/imgs/logo-white.png" class="w3-image"/>
      <h3><b>LeCARD</b></h3>
    </div>
    <div>
      <form>
        <div class="input-form">
          <input type="text" v-model="referencia" placeholder="Referência" autofocus>
          <i class="fa fa-qrcode w3-text-white"></i>
        </div>
        <p class="w3-left-align"><b>Referência da comanda</b></p>
        <button class="w3-button w3-border w3-round w3-block btn-comanda"><b>Buscar Comanda</b><i class="fa fa-search" style="float: right; line-height: 22px"></i></button>
      </form>
    </div>

  </div>
</template>

<script>
  import TopBar from "./commons/TopBar.vue"
  import Container from "./commons/Container.vue"

  export default {
    components: {Container, TopBar},
    name: 'Home',
    data() {
      return {
        referencia: ""
      }
    },
    methods: {
      selComanda() {
        if (this.referencia != "") {
          this.$http.get(base_url + 'admin/api/comanda/ref/' + this.referencia)
            .then(response => {
              if (response.data != "") {
                localStorage.setItem("comanda", response.data);
                this.$router.push("comanda");
              } else {
                alert("Nao encontrado")
              }
            });
        }
      }
    },
    beforeCreate() {
      document.getElementById("body").classList.add("home");
    }
  }
</script>

<style scoped>
  .container-home {
    margin: 25% 32px 0;
    text-align: center;
    color: #f1f1f1;
  }
  .input-form {
    margin-bottom: 16px;
    border-bottom: 2px solid #fff;
    position: relative;
  }
  .input-form input {
    border: none;
    width: 100%;
    padding: 12px;
    background-color: transparent;
    color: #fff;
  }
  .input-form i {
    position: absolute;
    right: 16px;
    top: 12px;
    font-size: 20px;
  }
  .btn-comanda {
    margin-top: 24px;
    padding: 10px;
  }
</style>

