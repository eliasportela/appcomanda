<template>
  <div>
    <top-bar></top-bar>
    <div class="container-login">
      <div class="w3-margin-bottom">
        <img src="/static/imgs/logo.png" class="w3-image"/>
        <h5>Login</h5>
      </div>
      <form>
        <div class="input-form">
          <input type="text" class="w3-light-gray" v-model="dados.usuario" placeholder="Informe seu usuário"/>
          <i class="fa fa-user w3-text-red"></i>
        </div>
        <div class="input-form">
          <input type="password" class="w3-light-gray" v-model="dados.senha" placeholder="Informe sua senha"/>
          <i class="fa fa-lock w3-text-red"></i>
        </div>
        <button type="button" class="w3-button w3-red w3-block w3-round login-btn" :disabled="(dados.usuario === '') || (dados.senha === '')" @click="logar(true)">
          Login
        </button>
      </form>
    </div>
  </div>
</template>

<script>
  import TopBar from "../commons/TopBar.vue"

  export default {
    components: {TopBar},
    name: 'Home',
    data() {
      return {
        dados: {
          usuario: '',
          senha: ''
        }
      }
    },
    methods: {
      logar(p) {
        openLoading("Por favor aguarde..");
        let chave = localStorage.getItem("key");
        let options = {emulateJSON: true};

        this.$http.post(base_url + 'autenticar?chave=' + chave, this.dados, options)
          .then(response => {
            localStorage.clear();
            let data = response.data;

            if (data.chave != null) {
              localStorage.setItem("key",data.chave);

              setTimeout(() => {
                closeLoading();
                this.$router.push("comanda-garcom")
              },2000);

            } else {
              closeLoading();
              if (p) {
                openModalMsg("Ops!", data.result);
              }
            }
          });
      }
    },
    created() {
      if (localStorage.getItem("key")) {
        this.logar();
      }
    }
  }
</script>

<style scoped>
  .container-login{
    margin: 26% 32px 0;
    text-align: center;
  }
  .input-form {
    margin: 12px 0 16px;
    border-bottom: 1px solid #f44336;
    position: relative;
  }
  .input-form input{
    border: none;
    width: 100%;
    padding: 12px;
    font-size: 1.1em;
  }
  .input-form i {
    position: absolute;
    right: 16px;
    top: 12px;
    font-size: 20px;
  }
  .login-btn {
    margin-top: 32px;
    font-size: 1.1em;
  }
</style>

