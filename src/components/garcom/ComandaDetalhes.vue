<template>
  <div>
    <top-bar voltar="comanda-garcom"></top-bar>
    <div class="container-bottom">
      <div class="w3-cell-row mesa-title">
        <div class="w3-cell w3-cell-middle" style="width: 80%">
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
      <hr>
      <div class="w3-cell-row list w3-border" v-for="p in produtosComanda"
           @click="selProdutoDetalhes(p.id_comanda_produto)">
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
    <div class="w3-bottom container-btn-garcom w3-white">
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
              <button class="w3-button w3-border w3-block" @click="avancarModal(2)"
                      :disabled="categoriaSelecionada === 0">
                Avançar
                <i class="fa fa-chevron-right"></i>
              </button>
            </div>
          </div>
        </div>
        <div class="w3-center w3-opacity w3-margin"><b>Escolha uma categoria</b></div>
        <div class="container-garcom garcom-tipo-produto">
          <div class="w3-cell-row comanda-tipo" v-for="c in categorias" @click="selCategoria(c.id_categoria,c.pizza)">
            <div class="w3-cell list-text">
              {{c.nome_categoria}}
            </div>
            <div class="w3-cell list-icon">
              <i class="fa fa-check" v-show="categoriaSelecionada === c.id_categoria"></i>
            </div>
          </div>
        </div>
        <div class="garcom-tipo-container w3-margin-top" v-show="showPizza">
          <hr class="garcom-hr">
          <div class="w3-cell-row">
            <div class="w3-cell cell-garcom-tipo">
              <button class="w3-button w3-border btn-garcom-tipo" @click="tipoPizza = 1">
                <i :class="[tipoPizza === 1 ? 'fas fa-check-circle' : 'far fa-circle']"></i><br>
                1/2 a 1/2
              </button>
            </div>
            <div class="w3-cell cell-garcom-tipo">
              <button class="w3-button w3-border w3-round btn-garcom-tipo" @click="tipoPizza = 2">
                <i :class="[tipoPizza === 2 ? 'fas fa-check-circle' : 'far fa-circle']"></i><br>
                Inteira
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
              <button class="w3-button w3-border w3-block" @click="avancarModal(6)">
                Avançar
                <i class="fa fa-chevron-right"></i>
              </button>
            </div>
          </div>
        </div>
        <div class="container-garcom garcom-tipo-produto w3-margin-top"
             :style="tipoPizza === 1 ? 'height: 20vh' : 'height: 10vh'">
          <div class="w3-cell-row comanda-tipo" v-for="p in produtosSelecionados">
            <div class="w3-cell list-text">
              ({{p.nome_tabela}}) {{p.nome_produto}}
            </div>
            <div class="w3-cell list-icon" @click="removerProdutosSel(p)">
              <i class="fa fa-times"></i>
            </div>
          </div>
        </div>
        <div class="w3-center w3-border-bottom w3-padding-16" style="margin: 0 16px"><b>Escolha o Produto</b></div>
        <div class="container-garcom" :class="{'disabled': hideProdutos}"
             :style="tipoPizza === 1 ? 'height: 45vh' : 'height: 55vh'">
          <div class="w3-cell-row comanda-tipo" v-for="p in produtos"
               v-show="(id_tabela === 0 || p.id_tabela === id_tabela)"
               @click="selProduto(p)">
            <div class="w3-cell">
              {{p.ref_produto}} - ({{p.nome_tabela}}) {{p.nome_produto}}
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
              <button class="w3-button w3-border w3-block" @click="confirmAdicionais(false)">
                <i class="fa fa-chevron-left"></i>
                Voltar
              </button>
            </div>
            <div class="w3-cell" style="width:50%;padding-left:4px">
              <button class="w3-button w3-border w3-block" @click="confirmAdicionais(true)">
                <i class="fa fa-check"></i>
                Confirmar
              </button>
            </div>
          </div>
        </div>
        <div class="w3-center w3-border-bottom w3-padding-16" style="margin: 0 16px"><b>Escolha o Adicional</b></div>
        <div class="container-garcom">
          <div class="w3-cell-row comanda-tipo" v-for="a in adicionais"
               @click="selAdicionais(a.id_produto,a.id_tabela_preco)">
            <div class="w3-cell list-text">
              {{a.nome_produto}}
            </div>
            <div class="w3-cell list-icon">
              <i class="fa fa-check" v-show="adicionaisSelecionadosTemp.includes(a.id_produto+'||'+a.id_tabela_preco)"></i>
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
              <button class="w3-button w3-border w3-block" @click="confirmRemocoes(false)">
                <i class="fa fa-chevron-left"></i>
                Voltar
              </button>
            </div>
            <div class="w3-cell" style="width:50%;padding-left:4px">
              <button class="w3-button w3-border w3-block" @click="confirmRemocoes(true)">
                <i class="fa fa-check"></i>
                Confirmar
              </button>
            </div>
          </div>
        </div>
        <div class="w3-center w3-border-bottom w3-padding-16" style="margin: 0 16px"><b>Selecione a Remoção</b></div>
        <div class="container-garcom">
          <div class="w3-cell-row comanda-tipo" v-for="i in itensRemocoes"
               @click="selRemocoes(i.id_produto,i.nome_produto)">
            <div class="w3-cell list-text">
              {{i.nome_produto}}
            </div>
            <div class="w3-cell list-icon">
              <i class="fa fa-check" v-show="remocoesSelecionadosTemp.includes('S/ '+i.nome_produto)"></i>
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
              <button class="w3-button w3-border w3-block" @click="confirmObservacao(false)">
                <i class="fa fa-chevron-left"></i>
                Voltar
              </button>
            </div>
            <div class="w3-cell" style="width:50%;padding-left:4px">
              <button class="w3-button w3-border w3-block" @click="confirmObservacao(true)">
                <i class="fa fa-check"></i>
                Confirmar
              </button>
            </div>
          </div>
        </div>
        <div class="w3-margin">
          <textarea class="w3-input w3-border" v-model="dados.observacao" style="height: 70vh;"
                    placeholder="Observações sobre o pedido"></textarea>
        </div>
      </div>
    </div>

    <div class="w3-modal" :class="{'show':modalFinalizar}">
      <div class="w3-modal-content">
        <div class="w3-top top-bar">
          <span>
            LeCard
          </span>
          <span class="w3-right" @click="inserirProduto()">
            Finalizar Pedido
            <i class="fa fa-check"></i>
          </span>
        </div>
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
              <div class="w3-input w3-border" placeholder="Quantidade" style="font-weight: bold">{{dados.quantidade}}
              </div>
            </div>
            <div class="w3-cell" style="width:25%; padding: 0 6px">
              <button class="w3-button w3-red w3-block" @click="minusQtd()">
                <i class="fa fa-minus"></i>
              </button>
            </div>
            <div class="w3-cell" style="width:25%;padding: 0 6px">
              <button class="w3-button w3-red w3-block" @click="plusQtd()">
                <i class="fa fa-plus"></i>
              </button>
            </div>
          </div>
          <hr>
          <div class="w3-cell-row w3-center">
            <div class="w3-cell" style="width: 50%;padding: 8px">
              <div class="w3-button w3-red w3-block w3-margin-top" style="padding:12px" @click="avancarModal(2)">
                <div class="w3-margin-bottom">
                  <i class="fa fa-th fa-2x"></i>
                </div>
                <b>Produtos</b>
              </div>
            </div>
            <div class="w3-cell" style="width: 50%;padding: 8px">
              <div class="w3-button w3-red w3-block w3-margin-top" style="padding:12px" @click="avancarModal(3)">
                <div class="w3-margin-bottom">
                  <i class="fa fa-th fa-2x"></i>
                </div>
                <b>Adicionais</b>
              </div>
            </div>
          </div>
          <div class="w3-cell-row">
            <div class="w3-cell" style="width: 50%;padding: 8px">
              <div class="w3-button w3-red w3-block w3-margin-top" style="padding:12px" @click="avancarModal(4)">
                <div class="w3-margin-bottom">
                  <i class="fa fa-th fa-2x"></i>
                </div>
                <b>Remoções</b>
              </div>
            </div>
            <div class="w3-cell" style="width: 50%;padding: 8px">
              <div class="w3-button w3-red w3-block w3-margin-top" style="padding:12px" @click="avancarModal(5)">
                <div class="w3-margin-bottom">
                  <i class="fa fa-th fa-2x"></i>
                </div>
                <b>Observações</b>
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
        itensRemocoes: [],
        categoriaSelecionada: 0,
        tipoPizza: 2,
        showPizza: false,
        hideProdutos: false,
        observacoes: [],

        produtosSelecionados: [],
        adicionaisSelecionadosTemp: [],
        remocoesSelecionadosTemp: [],

        id_tabela: 0,

        dados: {
          id_comanda: 0,
          produtos: [],
          id_tabela: null,
          quantidade: 1,
          gerar_pedido: false,
          observacao: null,
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
          });
      },

      buscarProdutosComanda() {
        this.$http.get(base_url + 'comandas/prudutos/' + this.token + '/' + this.comanda.id_comanda)
          .then(response => {
            this.produtosComanda = response.data;
            this.buscarCategorias();
            this.avancarModal(0);
          });
      },

      buscarCategorias() {
        this.$http.get(base_url + 'categorias/' + this.token)
          .then(response => {
            this.categorias = response.data;
            closeLoading();
          });
      },

      buscarDetalhesProdutoComanda(id) {
        this.$http.get(base_url + 'admin/api/comanda-pruduto/' + id)
          .then(response => {
            this.produtoDetalhes = response.data;
            this.observacoes = this.produtoDetalhes.observacao.split("||");
          });
      },

      buscarProdutos(id) {
        openLoading("Buscando Produtos");
        this.$http.get(base_url + 'produtos/precos/1/' + this.token + '/?id_categoria=' + id + '&ingrediente=0')
          .then(response => {
            this.produtos = response.data;
            closeLoading();
          });
      },

      buscarAdicionais(id) {
        openLoading("Buscando Adicionais");
        this.$http.get(base_url + 'produtos/precos/1/' + this.token + '/?id_categoria=' + id + '&ingrediente=1')
          .then(response => {
            this.adicionais = response.data;
            closeLoading();
          });
      },

      buscarItensRemocoes() {
        openLoading("Buscando Produtos");

        let par = {
          produtos: []
        };
        this.produtosSelecionados.forEach(p => {
          par.produtos.push(p.id_produto);
        });

        this.$http.get(base_url + 'produtos/itens/' + this.token, {params: par})
          .then(response => {
            this.itensRemocoes = response.data;
            closeLoading();
          });
      },

      inserirProduto() {
        openLoading("Inserindo as informações");
        if (this.dados.produtos.length === 0) {
          this.produtosSelecionados.forEach(p => {
            this.dados.produtos.push(p.id_produto);
            this.dados.gerar_pedido = p.gerar_pedido === '1';
          });
        }
        this.dados.id_tabela = this.id_tabela;

        let options = {emulateJSON: true};

        this.$http.post(base_url + 'comandas/inserir/produtos/' + this.token, this.dados, options)
          .then(response => {
            this.clearDados();
            this.avancarModal(0);
            this.buscarProdutosComanda();

          });

      },

      selAdicionais(id, tabela) {
        let ads = id + '||' + tabela;
        if (!this.adicionaisSelecionadosTemp.includes(ads)) {
          this.adicionaisSelecionadosTemp.push(ads);
        } else {
          let index = this.adicionaisSelecionadosTemp.indexOf(ads);
          if (index !== -1) this.adicionaisSelecionadosTemp.splice(index, 1);
        }
        console.log(this.dados.adicionais,this.adicionaisSelecionadosTemp);
      },

      selRemocoes(id, nome) {
        if (!this.remocoesSelecionadosTemp.includes('S/ ' + nome)) {
          this.remocoesSelecionadosTemp.push('S/ ' + nome);
        } else {
          let index = this.remocoesSelecionadosTemp.indexOf('S/ ' + nome);
          if (index !== -1) this.remocoesSelecionadosTemp.splice(index, 1);
        }
      },

      selCategoria(id, tipo) {
        this.categoriaSelecionada = id;
        if (tipo === '1') {
          this.showPizza = true;
          return;
        }
        this.showPizza = false;
      },

      confirmAdicionais(confirm){
        if(confirm === true){
          this.dados.adicionais = [];
          Object.assign(this.dados.adicionais, this.adicionaisSelecionadosTemp);
        }else {
          this.adicionaisSelecionadosTemp = [];
          Object.assign(this.adicionaisSelecionadosTemp, this.dados.adicionais);
        }

        console.log(this.dados.adicionais,this.adicionaisSelecionadosTemp);
        this.avancarModal(6);
      },

      confirmRemocoes(confirm){
        if(confirm === true){
          this.dados.remocoes = [];
          Object.assign(this.dados.remocoes, this.remocoesSelecionadosTemp);
        }else {
          this.remocoesSelecionadosTemp = [];
          Object.assign(this.remocoesSelecionadosTemp, this.dados.remocoes);
        }

        this.avancarModal(6);
      },

      confirmObservacao(confirm){
        if(confirm === false){
          this.dados.observacao = null;
        }

        console.log(this.dados.observacao)
        this.avancarModal(6);
      },

      selProduto(p) {
        let tamanho = this.tipoPizza === 1 ? 2 : 1;
        if (this.produtosSelecionados.length < tamanho && (p.id_tabela === this.id_tabela || this.id_tabela === 0)) {
          this.id_tabela = p.id_tabela;
          this.produtosSelecionados.push(p);
        }

        this.hideProdutos = this.produtosSelecionados.length >= tamanho;
      },

      removerProdutosSel(p) {
        let index = this.produtosSelecionados.indexOf(p);

        if (index !== -1) this.produtosSelecionados.splice(index, 1);
        if (this.produtosSelecionados.length === 0) {

          this.id_tabela = 0;
        }

        let tamanho = this.tipoPizza === 1 ? 2 : 1;
        this.hideProdutos = this.produtosSelecionados.length >= tamanho;

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
        if (modal === 0) {
          //tela incial
          this.modalComanda = false;
          this.modalInsercao = false;
          this.modalProduto = false;
          this.modalAdicionais = false;
          this.modalRemocoes = false;
          this.modalObservacoes = false;
          this.modalFinalizar = false;
          //modal de Insercao
        } else if (modal === 1) {
          this.modalInsercao = true;
          this.modalProduto = false;
          this.modalAdicionais = false;
          this.modalRemocoes = false;
          this.modalObservacoes = false;
          this.modalFinalizar = false;
        } else if (modal === 2) {
          //modal de Produtos
          let tamanho = this.tipoPizza === 1 ? 2 : 1;
          this.hideProdutos = this.produtosSelecionados.length >= tamanho;
          this.buscarProdutos(this.categoriaSelecionada);

          this.modalInsercao = false;
          this.modalProduto = true;
          this.modalAdicionais = false;
          this.modalRemocoes = false;
          this.modalObservacoes = false;
          this.modalFinalizar = false;
        } else if (modal === 3) {
          //modal de Adcionais
          this.buscarAdicionais(this.categoriaSelecionada);
          this.modalInsercao = false;
          this.modalProduto = false;
          this.modalAdicionais = true;
          this.modalRemocoes = false;
          this.modalObservacoes = false;
          this.modalFinalizar = false;
        } else if (modal === 4) {
          //modal de Remocao
          this.buscarItensRemocoes();
          this.modalInsercao = false;
          this.modalProduto = false;
          this.modalAdicionais = false;
          this.modalRemocoes = true;
          this.modalObservacoes = false;
          this.modalFinalizar = false;
        } else if (modal === 5) {
          //modal de Observacoes
          this.modalInsercao = false;
          this.modalProduto = false;
          this.modalAdicionais = false;
          this.modalRemocoes = false;
          this.modalObservacoes = true;
          this.modalFinalizar = false;
        } else if (modal === 6) {
          //modal Finalizar
          this.modalInsercao = false;
          this.modalProduto = false;
          this.modalAdicionais = false;
          this.modalRemocoes = false;
          this.modalObservacoes = false;
          this.modalFinalizar = true;
        }
      },

      clearDados() {
        this.categoriaSelecionada = 0;
        this.tipoPizza = 2;
        this.showPizza = false;
        this.produtosSelecionados = [];
        this.dados = {
          id_comanda: 0,
          produtos: [],
          id_tabela: null,
          quantidade: 1,
          gerar_pedido: false,
          observacao: null,
          adicionais: [],
          remocoes: []
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
    color: #aaa !important;
  }
</style>
