<template>
<div>
  <top-bar/>
  <div class="w3-main" style="margin-top:70px;">
    <div class="w3-panel">
      <div class="w3-container w3-white w3-padding-16 w3-center" style="min-height: 85vh;">
        <div class="w3-row-padding">

          <div class="w3-col l3 m6 w3-left-align w3-margin-top" v-for="p in pedidos">
            <div class="card card-palha">
              <div class="card-header">
                <button class="w3-button w3-block" @click="donePedido(p.id_comanda_produto)"><i class="fa fa-check"></i></button>
              </div>
              <div class="card-body">
                <h5><b>Mesa: {{p.mesa}}</b></h5>
                <span v-for="nome in normalizarNome(p.nome_produto)">
                  {{nome}}<br/>
                </span>
                <div class="ads">
                  <span>- QTD: {{parseFloat(p.quantidade).toFixed(0)}}</span><br/>
                  <span>- Tamanho: {{p.nome_tabela }}</span><br/>
                  <span>- Produto: {{p.nome_categoria}}</span><br/>
                  <span v-show="p.observacao">- Obs: {{p.observacao}}</span><br/>
                  <span v-for="a in p.adicionais">
                    - C/ {{a.nome_produto}} <br/>
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</template>

<script>
    import TopBar from "../commons/TopBar.vue"
    export default {
      components: {TopBar},
      name: "pedidos",
      data() {
        return {
          pedidos: []
        }
      },

      methods: {
        buscarPedidos() {
          this.$http.get(base_url + 'pedidos/1/' + localStorage.getItem('key'))
            .then(response => {
              this.pedidos = response.data;
            })
        },

        donePedido(id) {
          let pedido = {'id_pedido': id, 'status': 1};
          this.$http.post(base_url + 'pedidos/editar/' + localStorage.getItem('key'), pedido, {emulateJSON: true})
            .then(response => {
              this.buscarPedidos();
            })
        },

        normalizarNome(n) {
          n = n.split("||");
          let nome = [];
          n.forEach(function (value) {
            nome.push((n.length > 1 ? '1/2 ' : '') + value);
          });

          return nome;
        },

        adicionais(a) {
          console.log(a)
        }

      },
      mounted() {
        this.buscarPedidos();

        setInterval(() => {
          this.buscarPedidos();
        }, 15000);
      }
    }
</script>

<style scoped>
  .card {
    color: #000;
    box-shadow: 3px 18px 5px 0px rgba(222,222,222,1);
  }
  .card-header{
    padding: 8px;
    text-align: center;
  }
  .card-body{
    font-size: 0.92em;
    padding: 0px 16px 16px;
    font-weight: bold;
    height: 200px;
  }
  .card-body .ads{
    margin-top: 8px
  }
  .card-azul {
    background-color: #88E3F8;
    transform: rotate(-2deg);
  }
  .card-palha {
    transform: rotate(-1deg);
    background-color: #FEE882;
  }
  .card-verde {
    transform: rotate(2deg);
    background-color: #99ECBE;
  }
  .card-azul .card-header {
    background-color: #6DCCE5;
  }
  .card-palha .card-header {
    background-color: #EBD367;
  }
  .card-verde .card-header {
    background-color: #7FD6A4;
  }

</style>
