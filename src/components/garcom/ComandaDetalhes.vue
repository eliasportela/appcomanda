<template>
  <div>
    <top-bar voltar="comanda-garcom"></top-bar>
    <div class="title-garcom mesa-title">
      <div class="w3-cell-row">
        <div class="w3-cell w3-cell-middle">
          <div>
            <span>COMANDA: {{comanda.ref_comanda}}</span>
          </div>
          <div>
            <span>OBS: {{comanda.observacao}}</span>
          </div>
        </div>
        <div class="w3-cell w3-center w3-cell-middle">
          <i class="fa fa-edit fa-2x"></i><br>
          <span class="w3-small">EDITAR</span>
        </div>
      </div>
    </div>
    <div class="container-garcom">
      <div class="w3-cell-row list" v-for="p in produtosComanda" @click="selProdutoDetalhes(p.id_comanda_produto)">
        <div class="w3-cell">
          <div class="comanda-produto">
            <span>{{p.nome_produto}}</span><br>
            <span>{{p.nome_categoria}} {{p.nome_tabela}}</span>
          </div>
          <div class="obs-comanda">
            <span><b>QTD:</b> {{p.quantidade}}</span>
          </div>
        </div>
        <div class="w3-cell list-icon">
          <i class="fa fa-chevron-right"></i><br>
          <span class="w3-small">EDITAR</span>
        </div>
      </div>
    </div>
    <div class="w3-bottom container-btn-garcom">
      <button class="w3-button w3-round w3-block w3-red btn-garcom" @click="avancarModal(1)">
        ADICIONAR
      </button>
    </div>

    <div class="w3-modal" :class="{'show':modalComanda}">
      <div class="w3-modal-content w3-animate-opacity">
        <top-bar></top-bar>
        <div class="title-garcom">
          <button class="w3-button w3-round w3-block w3-red">
            <i class="fa fa-trash"></i>
            DELETAR ITEM
          </button>
        </div>
        <div class="container-garcom garcom-produto">
          <div class="w3-center w3-border-bottom w3-padding">
            PRODUTO
          </div>
          <ul class="w3-ul comanda-ul">
            <li>{{produtoDetalhes.quantidade}} - {{produtoDetalhes.nome_produto}}</li>
          </ul>
          <div class="w3-margin-top w3-center w3-border-bottom w3-padding">
            ADICIONAIS E OBSERVAÇÕES
          </div>
          <ul class="w3-ul comanda-ul">
            <li v-for="obs in observacoes">- {{obs}}</li>
          </ul>
        </div>
        <div class="w3-bottom container-btn-garcom w3-center">
          <button class="w3-button w3-round w3-red btn-garcom" style="width:49%" @click="avancarModal(0)">
            <i class="fa fa-chevron-left"></i>
            VOLTAR
          </button>
          <button class="w3-button w3-round w3-red btn-garcom" style="width:49%">
            <i class="fa fa-edit"></i>
            EDITAR
          </button>
        </div>
      </div>
    </div>

    <div class="w3-modal" :class="{'show':modalInsercao}">
      <div class="w3-modal-content w3-animate-opacity">
        <top-bar></top-bar>
        <div class="title-garcom">
          <div class="w3-cell-row">
            <div class="w3-cell" style="width:50%;padding-right:4px">
              <button class="w3-button w3-border w3-block" @click="avancarModal(0)">
                <i class="fa fa-times"></i>
                Cancelar
              </button>
            </div>
            <div class="w3-cell" style="width:50%;padding-left:4px">
              <button class="w3-button w3-border w3-block" @click="avancarModal(0)">
                <i class="fa fa-times"></i>
                Avançar
              </button>
            </div>
          </div>
        </div>
        <div class="container-garcom garcom-tipo-produto">
          <div class="w3-cell-row comanda-tipo" v-for="c in categorias" @click="selCategoria(c.id_categoria,c.pizza)">
            <div class="w3-cell list-text">
              {{c.nome_categoria}}
            </div>
            <div class="w3-cell list-icon">
              <i class="fa fa-check" v-show="categoriaSelecionada == c.id_categoria"></i>
            </div>
          </div>
        </div>
        <div class="garcom-tipo-container w3-margin-top" v-show="showPizza">
          <hr class="garcom-hr">
          <div class="w3-cell-row">
            <div class="w3-cell cell-garcom-tipo">
              <button class="w3-button w3-border btn-garcom-tipo" @click="selTipoPizza(1)">
                <i :class="[tipoPizza == 1 ? 'fas fa-check-circle' : 'far fa-circle']"></i><br>
                1/2
              </button>
            </div>
            <div class="w3-cell cell-garcom-tipo">
              <button class="w3-button w3-border w3-round btn-garcom-tipo" @click="selTipoPizza(2)">
                <i :class="[tipoPizza == 2 ? 'fas fa-check-circle' : 'far fa-circle']"></i><br>
                INTEIRA
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="w3-modal" :class="{'show':modalProduto}">
      <div class="w3-modal-content">
        <top-bar></top-bar>
        <div class="title-garcom">
          <div class="w3-cell-row">
            <div class="w3-cell" style="width:50%;padding-right:4px">
              <button class="w3-button w3-border w3-block" @click="avancarModal(1)">
                <i class="fa fa-chevron-left"></i>
                Voltar
              </button>
            </div>
            <div class="w3-cell" style="width:50%;padding-left:4px">
              <button class="w3-button w3-border w3-block" @click="avancarModal(0)">
                <i class="fa fa-times"></i>
                Cancelar
              </button>
            </div>
          </div>
        </div>
        <div class="container-garcom">
          <div class="w3-cell-row comanda-tipo" v-for="p in produtos"
               @click="selProduto(p.id_produto, p.id_tabela_produto, p.gerar_pedido)">
            <div class="w3-cell list-text">
              {{p.ref_produto}} - ({{p.nome_tabela}}) {{p.nome_produto}}
            </div>
            <div class="w3-cell list-icon">
              <i class="fa fa-check"
                 v-show="(dados.id_produto == p.id_produto) && (dados.id_tabela_produto == p.id_tabela_produto)"></i>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="w3-modal" :class="{'show':modalAdicionais}">
      <div class="w3-modal-content">
        <top-bar></top-bar>
        <div class="title-garcom">
          <div class="w3-cell-row">
            <div class="w3-cell" style="width:50%;padding-right:4px">
              <button class="w3-button w3-border w3-block" @click="avancarModal(6)">
                <i class="fa fa-chevron-left"></i>
                Voltar
              </button>
            </div>
            <div class="w3-cell" style="width:50%;padding-left:4px">
              <button class="w3-button w3-border w3-block" @click="avancarModal(0)">
                <i class="fa fa-times"></i>
                Cancelar
              </button>
            </div>
          </div>
        </div>
        <div class="container-garcom">
          <div class="w3-cell-row comanda-tipo" v-for="a in adicionais"
               @click="selAdicionais(a.id_produto,a.id_tabela_produto)">
            <div class="w3-cell list-text">
              {{a.nome_produto}}
            </div>
            <div class="w3-cell list-icon">
              <i class="fa fa-check" v-show="dados.adicionais.includes(a.id_produto+'||'+a.id_tabela_produto)"></i>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="w3-modal" :class="{'show':modalRemocoes}">
      <div class="w3-modal-content">
        <top-bar></top-bar>
        <div class="title-garcom">
          <div class="w3-cell-row">
            <div class="w3-cell" style="width:50%;padding-right:4px">
              <button class="w3-button w3-border w3-block" @click="avancarModal(6)">
                <i class="fa fa-chevron-left"></i>
                Voltar
              </button>
            </div>
            <div class="w3-cell" style="width:50%;padding-left:4px">
              <button class="w3-button w3-border w3-block" @click="avancarModal(0)">
                <i class="fa fa-times"></i>
                Cancelar
              </button>
            </div>
          </div>
        </div>
        <div class="container-garcom">
          <div class="w3-cell-row comanda-tipo" v-for="i in itens" @click="selRemocoes(i.id_produto,i.nome_produto)">
            <div class="w3-cell list-text">
              {{i.nome_produto}}
            </div>
            <div class="w3-cell list-icon">
              <i class="fa fa-check" v-show="dados.remocoes.includes('S/ '+i.nome_produto)"></i>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="w3-modal" :class="{'show':modalObservacoes}">
      <div class="w3-modal-content">
        <top-bar></top-bar>
        <div class="title-garcom">
          <div class="w3-cell-row">
            <div class="w3-cell" style="width:50%;padding-right:4px">
              <button class="w3-button w3-border w3-block" @click="avancarModal(6)">
                <i class="fa fa-chevron-left"></i>
                Voltar
              </button>
            </div>
            <div class="w3-cell" style="width:50%;padding-left:4px">
              <button class="w3-button w3-border w3-block" @click="avancarModal(0)">
                <i class="fa fa-times"></i>
                Cancelar
              </button>
            </div>
          </div>
        </div>
        <div class="container-garcom">
          <textarea class="w3-input w3-border" rows="10" v-model="dados.observacao"></textarea>
        </div>
      </div>
    </div>

    <div class="w3-modal" :class="{'show':modalFinalizar}">
      <div class="w3-modal-content">
        <top-bar></top-bar>
        <div class="title-garcom">
          <div class="w3-cell-row">
            <div class="w3-cell">
              <button class="w3-button w3-border w3-block" @click="avancarModal(0)">
                <i class="fa fa-times"></i>
                Cancelar
              </button>
            </div>
          </div>
        </div>
        <hr>
        <div class="w3-container">
          Informe a Quantidade
          <div class="w3-cell-row">
            <div class="w3-cel w3-margin-right">
              <input type="number" class="w3-input w3-border" placeholder="Quantidade" v-model="dados.quantidade">
            </div>
            <div class="w3-cell" style="width:15%">
              <button class="w3-button w3-red" @click="minusQtd()">
                <i class="fa fa-minus"></i>
              </button>
            </div>
            <div class="w3-cell" style="width:15%">
              <button class="w3-button w3-red" @click="plusQtd()">
                <i class="fa fa-plus"></i>
              </button>
            </div>
          </div>
          <hr>
          <button class="w3-button w3-red w3-block w3-margin-top" style="padding:12px" @click="avancarModal(1)">
            Produtos
          </button>
          <button class="w3-button w3-red w3-block w3-margin-top" style="padding:12px" @click="avancarModal(3)">
            Adicionais
          </button>
          <button class="w3-button w3-red w3-block w3-margin-top" style="padding:12px" @click="avancarModal(4)">
            Remoções
          </button>
          <button class="w3-button w3-red w3-block w3-margin-top" style="padding:12px" @click="avancarModal(5)">
            Observações
          </button>
        </div>
        <div class="w3-bottom container-btn-garcom">
          <button class="w3-button w3-red w3-block w3-margin-top" style="padding:12px" @click="inserirProduto()">
            Finalizar
          </button>
        </div>
      </div>
    </div>

  </div>
</template>

<script>

  import TopBar from "../commons/TopBar.vue"
  //import ModalProduto from "../commons/Modal.vue"
  export default {
    beforeCreate: function () {
      document.body.className = 'cliente';
    },
    components: {TopBar/*,ModalProduto*/},
    data() {
      return {
        token: '',

        modalComanda: false,
        modalInsercao: false,
        modalProduto: false,
        modalAdicionais: false,
        modalFinalizar: false,
        modalRemocoes: false,
        modalObservacoes: false,

        comanda: "",
        produtosComanda: [],
        produtoDetalhes: "",
        categorias: [],
        produtos: [],
        adicionais: [],
        itens: [],
        categoriaSelecionada: 0,
        tipoPizza: 0,
        showPizza: false,
        observacoes: [],

        dados: {
          id_comanda: 0,
          id_produto: 0,
          id_tabela_produto: 0,
          quantidade: 1,
          gerar_pedido: 0,
          observacao: "",
          adicionais: [],
          remocoes: []
        }
      }
    },
    methods: {
      buscarComanda() {
        openLoading("Buscando dados da comanda");
        this.$http.get(base_url + 'comandas/1/' + this.token + '?id_comanda=' + this.$route.params.id)
          .then(response => {
            this.comanda = response.data[0];
            this.dados.id_comanda = this.comanda.id_comanda;

            this.buscarProdutosComanda();
            closeLoading();
          });
      },
      buscarCategorias() {
        this.$http.get(base_url + 'admin/api/categoria-produtos')
          .then(response => {
            this.categorias = response.data;
          });
      },
      buscarProdutosComanda() {
        openLoading("Buscando os produtos")
        this.$http.get(base_url + 'comandas/prudutos/'+ this.token +'/' + this.comanda.id_comanda)
          .then(response => {
            this.produtosComanda = response.data;
            this.avancarModal(0);
          });
      },
      buscarDetalhesProdutoComanda(id) {
        this.$http.get(base_url + 'admin/api/comanda-pruduto/' + id)
          .then(response => {
            this.produtoDetalhes = response.data;
            this.observacoes = this.produtoDetalhes.observacao.split("||");
            console.log(this.observacoes);
          });
      },
      buscarProdutos(id) {
        this.$http.get(base_url + 'admin/api/produtos-categoria-tabela/' + id)
          .then(response => {
            this.produtos = response.data;
          });
      },
      buscarAdicionais(id) {
        this.$http.get(base_url + 'admin/api/produtos-categoria-tabela/' + id)
          .then(response => {
            this.adicionais = response.data;
          });
      },
      buscarItensRemocoes(id) {
        this.$http.get(base_url + 'admin/api/produto/id/' + id)
          .then(response => {
            this.itens = response.data.itens;
          });
      },
      inserirProduto() {
        let options = {emulateJSON: true};
        console.log(this.dados);
        this.$http.post(base_url + 'admin/api/comanda/inserir-produto', this.dados, options)
          .then(response => {
            console.log(response);
            this.buscarProdutosComanda();
            this.dados.id_produto = 0;
            this.dados.id_tabela_produto = 0;
            this.dados.quantidade = 1;
            this.dados.gerar_pedido = 0;
            this.dados.observacao = "";
            this.dados.adicionais = [];
            this.dados.remocoes = [];
            this.categoriaSelecionada = 0;
            this.tipoPizza = 0;
            this.showPizza = false;
          });
      },

      selAdicionais(id, tabela) {
        var ads = id + '||' + tabela;
        if (!this.dados.adicionais.includes(ads)) {
          this.dados.adicionais.push(ads);
        } else {
          var index = this.dados.adicionais.indexOf(ads);
          if (index !== -1) this.dados.adicionais.splice(index, 1);
        }
        console.log(this.dados.adicionais);
      },
      selRemocoes(id, nome) {
        if (!this.dados.remocoes.includes('S/ ' + nome)) {
          this.dados.remocoes.push('S/ ' + nome);
        } else {
          var index = this.dados.remocoes.indexOf('S/ ' + nome);
          if (index !== -1) this.dados.remocoes.splice(index, 1);
        }
        console.log(this.dados.remocoes);
      },
      selCategoria(id, tipo) {
        this.categoriaSelecionada = id;
        if (tipo == 1) {
          this.showPizza = true;
        }
      },
      selTipoPizza(id) {
        this.tipoPizza = id;
        this.avancarModal(2);
      },
      selProduto(id, tabela, pedido) {
        this.dados.id_produto = id;
        this.dados.id_tabela_produto = tabela;
        this.dados.gerar_pedido = pedido;
        this.avancarModal(6);
      },
      selProdutoDetalhes(id) {
        this.modalComanda = true;
        this.buscarDetalhesProdutoComanda(id);
      },

      plusQtd() {
        this.dados.quantidade++;
      },
      minusQtd() {
        if (this.dados.quantidade > 1) {
          this.dados.quantidade--;
        }
      },
      avancarModal(modal) {
        if (modal == 0) {
          //tela incial
          this.modalComanda = false;
          this.modalInsercao = false;
          this.modalProduto = false;
          this.modalAdicionais = false;
          this.modalRemocoes = false;
          this.modalObservacoes = false;
          this.modalFinalizar = false;
          //modal de Insercao
        } else if (modal == 1) {
          this.modalInsercao = true;
          this.modalProduto = false;
          this.modalAdicionais = false;
          this.modalRemocoes = false;
          this.modalObservacoes = false;
          this.modalFinalizar = false;
        } else if (modal == 2) {
          //modal de Produtos
          this.buscarProdutos(this.categoriaSelecionada);
          this.modalInsercao = false;
          this.modalProduto = true;
          this.modalAdicionais = false;
          this.modalRemocoes = false;
          this.modalObservacoes = false;
          this.modalFinalizar = false;
        } else if (modal == 3) {
          //modal de Adcionais
          this.buscarAdicionais(1);
          this.modalInsercao = false;
          this.modalProduto = false;
          this.modalAdicionais = true;
          this.modalRemocoes = false;
          this.modalObservacoes = false;
          this.modalFinalizar = false;
        } else if (modal == 4) {
          //modal de Remocao
          this.buscarItensRemocoes(this.dados.id_produto);
          this.modalInsercao = false;
          this.modalProduto = false;
          this.modalAdicionais = false;
          this.modalRemocoes = true;
          this.modalObservacoes = false;
          this.modalFinalizar = false;
        } else if (modal == 5) {
          //modal de Observacoes
          this.modalInsercao = false;
          this.modalProduto = false;
          this.modalAdicionais = false;
          this.modalRemocoes = false;
          this.modalObservacoes = true;
          this.modalFinalizar = false;
        } else if (modal == 6) {
          //modal Finalizar
          this.modalInsercao = false;
          this.modalProduto = false;
          this.modalAdicionais = false;
          this.modalRemocoes = false;
          this.modalObservacoes = false;
          this.modalFinalizar = true;
        }
      }

    },
    created: function () {

      if (localStorage.getItem('key') !== undefined) {
        this.token = localStorage.getItem('key');
        this.buscarComanda();
        //this.buscarCategorias();

      } else {
        this.$router.push("/")
      }

    }

  }
</script>

<style scoped>
  .list-icon {
    width: 20%;
    text-align: center;
  }

  .w3-button:hover {
    background-color: #fff !important;
    color: #000 !important;
  }

</style>
