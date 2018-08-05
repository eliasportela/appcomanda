<template>
  <div>
    <div class="w3-top top-bar">
      <span><b>CARDÁPIO</b></span>
    </div>
    <div class="container-cardapio" v-show="showCategorias">
      <div class="title w3-text-white w3-margin-bottom" style="font-weight: bold; padding: 12px 24px 0">
        <div style="font-size: 1.6em">
          <span style="color: #009246">NAPOLI.</span><span style="color: #f44336">TCHELLO</span>
        </div>
      </div>
      <div class="w3-center w3-margin-bottom w3-text-red">ESCOLHA A CATEGORIA</div>
      <div class="w3-cell-row list-cardapio w3-center" v-for="c in categorias" :key="c.id_categoria"
           @click="toogleCardapio(c.id_categoria,c.nome_categoria,c.url_image)">
        <div class="w3-cell list-img">
          <img :src="'/static/imgs/categorias/' + c.url_image" class="w3-image">
        </div>
        <div class="w3-cell list-text" style="width:33%">
          <span>{{c.nome_categoria}}</span>
        </div>
        <div class="w3-cell list-icon" style="width:33%">
          <i class="fa fa-angle-right"></i>
        </div>
      </div>
    </div>
    <bottom-bar></bottom-bar>
    <div class="w3-modal modal-cardapio" :class="{'show':cardapio}">
      <div class="w3-modal-content w3-animate-opacity">
        <div class="w3-container">
          <div class="w3-text-white w3-padding-16 title-modal">
						<span class="w3-large">
							<b>{{nome_categoria}}</b>
						</span>
            <i class="fa fa-times w3-right w3-xlarge" @click="toogleCardapio(false)"></i>
          </div>
        </div>
        <div class="cardapio">
          <div class="w3-center">
            <img :src="'/static/imgs/categorias/' + imagem_categoria" class="cardapio-image">
          </div>
          <hr>
          <div class="w3-cell-row cardapio-item" v-for="p in produtos" v-show="p.valores !== ''">
            <div class="w3-cell">
              <span class="cardapio-produto">{{p.ref_produto}} - {{p.nome_produto}}</span><br>
              <span class="cardapio-ingredientes">({{p.ingredientes}})</span>
            </div>
            <div class="w3-cell cardapio-preco">
              <div class="w3-red w3-round">
                <div v-for="v in p.valores">
                  <span class="info-icon">{{v.nome_tabela.substring(0, 1)}}:</span>
                  <span>{{v.valor}}</span>
                </div>
              </div>
            </div>
          </div>
          <hr>
          <div class="w3-red w3-round w3-center">
            <span class="info-icon">E</span>: ESFIHA -
            <span class="info-icon">B</span>: BROTO -
            <span class="info-icon">G</span>: GRANDE
          </div>
          <div class="w3-red w3-round info-list">
            <ul class="w3-ul">
              <li>
                <i class="fa fa-asterisk w3-small info-icon"></i>
                Pizzas 1/2 a 1/2 será cobrado pelo valor maior
              </li>
              <li>
                <i class="fa fa-asterisk w3-small info-icon"></i>
                Todas as pizzas levam molho de tomate e azeitonas
              </li>
            </ul>
          </div>
        </div>

      </div>
    </div>
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
        showCategorias: false,
        categorias: [],
        cardapio: false,
        nome_categoria: '',
        imagem_categoria: '',
        produtos: [],
      }
    },
    methods: {
      buscarCategorias() {
        this.$http.get(base_url + 'categorias/' + token)
          .then(response => {
            this.categorias = response.data;
            this.showCategorias = true;
            closeLoading();
          });
      },
      buscarProdutosCategoria(id) {
        this.produtos = [];
        openLoading("Buscando produtos");
        this.$http.get(base_url + 'cardapio/' + token + '/?categoria=' + id)
          .then(response => {
            console.log(response);
            this.produtos = response.data;
            this.cardapio = true;
            closeLoading()
          });
      },
      toogleCardapio(id, nome, img) {
        if (id) {
          this.nome_categoria = nome;
          this.imagem_categoria = img;
          this.buscarProdutosCategoria(id);
        } else {
          this.cardapio = false;
        }
      },
    },
    created: function () {
      openLoading("Carregando o Cardápio");
      this.buscarCategorias();
    }
  }
</script>

<style scoped>
  .w3-modal-content {
    background-image: url("/static/imgs/cardapio.jpg");
  }
</style>
