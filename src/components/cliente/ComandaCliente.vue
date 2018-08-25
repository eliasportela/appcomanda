<template>
  <div>
    <div class="w3-top top-bar">
      <span>COMANDA: {{comanda.ref_comanda}}</span>
      <span class="w3-right" @click="sair">Sair <i class="fa fa-sign-out-alt"></i></span>
    </div>
    <div class="container-bottom">
      <div class="title">
        PRODUTOS CONSUMIDOS
      </div>
      <hr>
      <div class="w3-cell-row list w3-border w3-padding-16" v-for="(p, index) in pedidos" :key="p.id"
           @click="buscarDetalhesProdutoComanda(p.id_comanda_produto)">
        <div class="w3-cell">
          <div class="comanda-produto">
            <span>{{p.nome_produto | nome}}</span>
          </div>
          <div class="obs-comanda">
            <span><b>QTD:</b> {{p.quantidade}}</span>
          </div>
        </div>
        <div class="w3-cell list-icon w3-text-red">
          <i class="fa fa-info-circle"></i><br>
          <span class="w3-tiny">Detalhes</span>
        </div>
      </div>
    </div>

    <div class="w3-modal" :class="{'show':modalProduto}">
      <div class="w3-modal-content modal-produtos">
        <div class="w3-top top-bar">
					<span @click="closeProduto">
						<i class="fa fa-chevron-left"></i>
						Voltar
					</span>
        </div>
        <div class="w3-padding">
          <div class="title-produtos">
            <span>DETALHES DO PRODUTO</span>
          </div>
          <hr>
          <div class="w3-margin-top">
            <ul class="w3-ul comanda-ul w3-large">
              <li v-for="p in produtos" :key="p">
                - {{produtos.length !== 1 ? "1/2" : ""}} {{p}}
              </li>
              <hr>
              <li>- Quantidade: {{produtoDetalhes.quantidade | fixed}}</li>
              <li v-show="produtoDetalhes.pizza === '1'">- Tamanho: {{produtoDetalhes.nome_tabela}}</li>
            </ul>
            <div class="w3-margin-top w3-center w3-border-bottom w3-padding" v-show="observacoes !== ''">
              OBSERVAÇÕES
            </div>
            <ul class="w3-ul comanda-ul">
              <li v-for="obs in observacoes" :key="obs">- {{obs}}</li>
            </ul>
            <div class="w3-margin-top w3-center w3-border-bottom w3-padding" v-show="adicionais !== ''">
              ADICIONAIS
            </div>
            <ul class="w3-ul comanda-ul">
              <li v-for="ads in adicionais">- {{ads.nome_produto}}</li>
            </ul>
            <div class="w3-padding w3-padding-32 w3-center w3-small" v-show="observacoes === ''">
              <img src="/static/imgs/pizza-caixa.svg" style="width: 80px"/>
              <h5>Nenhuma informação adicional para o produto selecionado</h5>
            </div>
          </div>
        </div>
      </div>
    </div>

    <bottom-bar></bottom-bar>

  </div>
</template>

<script>

  import BottomBar from "../commons/BottomBar.vue"
  import TopBar from "../commons/TopBar.vue"

  export default {
    beforeCreate: function () {
      document.body.className = 'cliente';
    },
    components: {BottomBar, TopBar},
    data() {
      return {
        modalProduto: false,
        comanda: "",
        produtoDetalhes: "",
        observacoes: "",
        adicionais: [],
        pedidos: [],
        produtos: [],

      }
    },
    methods: {
      buscarProdutosComanda() {
        openLoading("Buscando os produtos")
        this.$http.get(base_url + 'comandas/prudutos/'+ token +'/' + this.comanda.id_comanda)
          .then(response => {
            this.pedidos = response.data;
            closeLoading()
          });
      },
      buscarDetalhesProdutoComanda(id) {
        this.produtoDetalhes = '';
        openLoading("Buscando detalhes");
        this.$http.get(base_url + 'comandas/prudutos/'+ token +'/' + this.comanda.id_comanda + '/?id_pedido=' + id)
          .then(response => {
            this.observacoes = "";
            this.adicionais = "";
            this.produtoDetalhes = response.data[0];

            if (this.produtoDetalhes.nome_produto != null) {
              this.produtos = this.produtoDetalhes.nome_produto.split("||");
            }
            if (this.produtoDetalhes.observacao != null) {
              this.observacoes = this.produtoDetalhes.observacao.split("||");
            }
            if (this.produtoDetalhes.adicionais != null) {
              this.adicionais = this.produtoDetalhes.adicionais;
            }
            this.modalProduto = true;
            closeLoading();
          });
      },
      closeProduto() {
        this.modalProduto = false;
      },
      sair() {
        this.$router.push("/");
      }

    },

    created: function () {
      let jsoncomanda = localStorage.getItem("comanda");
      if (jsoncomanda !== undefined) {
        this.comanda = JSON.parse(jsoncomanda);
        this.buscarProdutosComanda();

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
  .list-icon {
    width: 15%;
    text-align: center;
  }
</style>
