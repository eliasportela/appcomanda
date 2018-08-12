<template>
  <div>
    <div class="w3-top top-bar">
      <span>COMANDA: {{comanda.ref_comanda}}</span>
    </div>
    <div class="container-bottom">
      <div class="title">
        PRODUTOS CONSUMIDOS
      </div>
      <hr>
      <div class="w3-cell-row list w3-border w3-padding-16" v-for="p in produtos" :key="p.id"
           @click="buscarDetalhesProdutoComanda(p.id_comanda_produto)">
        <div class="w3-cell">
          <div class="comanda-produto">
            <span>{{p.nome_produto}}</span>
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
      <div class="w3-modal-content w3-animate-opacity modal-produtos">
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
              <li>- Produto: {{produtoDetalhes.nome_produto}}</li>
              <li>- Quantidade: {{produtoDetalhes.quantidade}}</li>
              <li>- Tamanho: {{produtoDetalhes.nome_tabela}}</li>
            </ul>
            <div class="w3-margin-top w3-center w3-border-bottom w3-padding">
              ADICIONAIS E OBSERVAÇÕES
            </div>
            <ul class="w3-ul comanda-ul" v-show="observacoes !== ''">
              <li v-for="obs in observacoes" :key="obs">- {{obs}}</li>
            </ul>
            <div class="w3-padding-32 w3-center w3-small" v-show="observacoes === ''">
              <img src="/static/imgs/pizza-caixa.svg" style="width: 80px"/>
              <h5>Nenhuma informação para o produto selecionado</h5>
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
        produtos: [],

      }
    },
    methods: {
      buscarProdutosComanda() {
        openLoading("Buscando os produtos")
        this.$http.get(base_url + 'comandas/prudutos/'+ token +'/' + this.comanda.id_comanda)
          .then(response => {
            this.produtos = response.data;
            closeLoading()
          });
      },
      buscarDetalhesProdutoComanda(id) {
        this.produtoDetalhes = '';
        openLoading("Buscando detalhes");
        this.$http.get(base_url + 'comandas/prudutos/'+ token +'/' + this.comanda.id_comanda + '/?id_pedido=' + id)
          .then(response => {
            this.produtoDetalhes = response.data[0];
            if (this.produtoDetalhes.observacao != null) {
              this.observacoes = this.produtoDetalhes.observacao.split("||");
            }
            this.modalProduto = true;
            closeLoading();
          });
      },
      closeProduto() {
        this.modalProduto = false;
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
    }
  }
</script>

<style scoped>
  .list-icon {
    width: 15%;
    text-align: center;
  }
</style>
