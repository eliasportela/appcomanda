<template>
  <div>
    <div class="w3-top">
      <div class="top-bar">
        <span>MEUS PEDIDOS</span>
      </div>
    </div>
    <div class="container-bottom">
      <div class="w3-center text-primary">
        <i class="fa fa-utensils w3-text-red"></i> Pedidos enviados -
        <i class="fa fa-check w3-text-green"></i> Pedidos Prontos <br>
      </div>
      <hr>
      <div v-for="(p, index) in pedidos" :key="p.id_produto_comanda" style="margin-top: 24px">
        <div class="card" :class="'card-' + (p.id_categoria === '1' ? 'palha' : 'verde') ">
          <div class="card-header">
            <i class="fa fa-utensils w3-text-red" v-show="p.status_pedido === '0'"></i>
            <i class="fa fa-check w3-text-green" v-show="p.status_pedido === '1'"></i>
            - Pedido {{index + 1}} - {{p.nome_categoria}}
            <span class="w3-right"><i class="fa fa-clock" style="font-size:1em"></i> {{p.horas}}</span>
          </div>
          <div class="card-body" style="min-height: 30px">
            <span>- {{p.nome_produto | nome}}</span><br>
            <span>- Quantidade:  {{p.quantidade | fixed}}</span><br>
            <span class="pedido-obs">
              <span style="display: block" v-for="(obs, index) in p.observacoes" :key="index">
                - {{obs}}
              </span>
            </span>
          </div>
        </div>
      </div>
    </div>
    <bottom-bar></bottom-bar>
  </div>
</template>

<script>

  import BottomBar from "../commons/BottomBar.vue"

  export default {
    beforeCreate: function () {
      document.body.className = 'cliente';
    },
    components: {BottomBar},
    data() {
      return {
        comanda: "",
        pedidos: [],
      }
    },
    methods: {
      buscarPedidosComanda() {
        openLoading("Carregadno os pedidos..");
        this.$http.get(base_url + 'pedidos/1/' + token + '/?comanda=' + this.comanda.id_comanda)
          .then(response => {
            console.log(response);
            this.pedidos = response.data;
            closeLoading();
          });
      },
    },
    created: function () {
      let comanda = localStorage.getItem("comanda");
      if (comanda !== undefined) {
        this.comanda = JSON.parse(localStorage.getItem("comanda"));
        this.buscarPedidosComanda();
      } else {
        this.$router.push("/");
      }
    },
    filters: {
      fixed(value) {
        if (value !== undefined) {
          let v = parseInt(value);
          return v.toFixed(0)
        }
      },
      nome(value) {
        if (value !== null || value !== undefined) {
          let p = value.split("||");
          value = "";
          p.forEach(obj => {
            value += (p.length > 1 ? "1/2 " : "") + obj + ", ";
          });
        }
        return value.substring(0, value.length - 2);
      }
    }
  }
</script>

<style scoped>
  .pedido-body {
    margin-top: 12px
  }

</style>
