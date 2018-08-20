<template>
  <div>
    <div>
      <top-bar voltar="comanda-garcom"></top-bar>
      <div class="container-bottom">
        <div class="w3-cell-row mesa-title">
          <div class="w3-cell w3-cell-middle" style="width: 80%">
            <div>
              <span>COMANDA: {{comanda.ref_comanda}}</span><br/>
              <span>MESA: {{comanda.mesa}}</span><br/>
              <span>OBS: {{comanda.observacao}}</span>
            </div>
          </div>
          <div class="w3-cell w3-center w3-cell-middle" @click="selEditarComanda">
            <i class="fa fa-edit fa-2x"></i><br>
            <span class="w3-small">EDITAR</span>
          </div>
        </div>
        <hr>
        <div class="w3-cell-row list w3-border" v-for="p in produtosComanda"
             @click="selProdutoDetalhes(p)">
          <div class="w3-cell">
            <div class="comanda-produto">
              <span>{{p.nome_categoria}} {{p.nome_tabela}}</span><br>
              <span>{{p.nome_produto | produto}}</span>
            </div>
            <div class="obs-comanda">
              <span><b>QTD:</b> {{p.quantidade | fixed}}</span>
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
    </div>

    <div class="w3-modal" :class="{'show':modalEditarComanda}">
      <div class="w3-modal-content">
        <div class="w3-top top-bar">
          <span @click="avancarModal(0)">
            Cancelar
          </span>
          <span class="w3-right" @click="editarComanda()">
            Editar Comanda
            <i class="fa fa-check"></i>
          </span>
        </div>
        <div class="title-garcom">
          EDITAR COMANDA
        </div>
        <div class="w3-container">
          <hr>
          <div class="w3-row">
            <div class="w3-col s12">
              <label><b>Mesa</b></label>
              <input type="number" class="w3-input w3-border" v-model="dadosComanda.mesa"/>
            </div>
            <div class="w3-col s12 w3-margin-top">
              <label><b>Observação</b></label>
              <textarea class="w3-input w3-border" rows="8" v-model="dadosComanda.observacao"></textarea>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="w3-modal" :class="{'show':modalDetalhesPedido}">
      <div class="w3-modal-content">
        <div class="w3-top top-bar">
          <span @click="avancarModal(0)">
            <i class="fa fa-chevron-left"></i>
            Voltar
          </span>
          <span class="w3-right" @click="selEditarPedido()">
            Editar Pedido
            <i class="fa fa-edit"></i>
          </span>
        </div>
        <div class="title-garcom">
          DADOS DO PEDIDO
        </div>
        <div class="w3-container" style="font-weight: bold">
          <div class="w3-margin-top w3-center w3-border-bottom w3-padding">
            PRODUTOS
          </div>
          <ul class="w3-ul comanda-ul">
            <li v-for="p in nomesprodutosDetalhes">
              - {{nomesprodutosDetalhes.length !== 1 ? "1/2" : "1"}}
              {{p}}
            </li>
          </ul>
          <div class="w3-margin-top w3-center w3-border-bottom w3-padding">
            ADICIONAIS
          </div>
          <ul class="w3-ul comanda-ul">
            <li v-for="ads in adicionaisDetalhes">- {{ads.nome_produto}}</li>
          </ul>
          <div class="w3-margin-top w3-center w3-border-bottom w3-padding">
            OBSERVAÇÕES
          </div>
          <ul class="w3-ul comanda-ul">
            <li v-for="obs in observacoes">- {{obs}}</li>
          </ul>
        </div>
        <div class="w3-bottom container-btn-garcom w3-center">
          <button class="w3-button w3-round w3-red btn-garcom w3-block" @click="">
            <i class="fa fa-trash"></i>
            DELETAR ITEM
          </button>
        </div>
      </div>
    </div>

    <div class="w3-modal" :class="{'show':modalInsercao}">
      <div class="w3-modal-content">
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
              <button class="w3-button w3-border w3-block" @click="confirmProdutos()" :disabled="!hideProdutos">
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
              <i class="fa fa-check"
                 v-show="adicionaisSelecionadosTemp.includes(a.id_produto+'||'+a.id_tabela_preco)"></i>
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
               @click="selRemocoes('S/ '+ i.nome_produto)">
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
          <span @click="avancarModal(0)">
            Cancelar
          </span>
          <span class="w3-right" @click="inserirOrEditarProduto()">
            Finalizar
            <i class="fa fa-check"></i>
          </span>
        </div>
        <div class="w3-container" style="padding-top: 75px">
          Informe a Quantidade
          <div class="w3-cell-row">
            <div class="w3-cel w3-margin-right">
              <div class="w3-input w3-border" style="font-weight: bold">{{dados.quantidade}}
              </div>
            </div>
            <div class="w3-cell" style="width:25%; padding: 0 6px">
              <button class="w3-button w3-red w3-block w3-round-small" @click="minusQtd()">
                <i class="fa fa-minus"></i>
              </button>
            </div>
            <div class="w3-cell" style="width:25%;padding: 0 6px">
              <button class="w3-button w3-red w3-block w3-round-small" @click="plusQtd()">
                <i class="fa fa-plus"></i>
              </button>
            </div>
          </div>
          <hr>
          <div class="w3-cell-row w3-center">
            <div class="w3-cell" style="width: 50%;padding: 8px">
              <div class="w3-button w3-red w3-block w3-margin-top w3-round-small w3-padding-24" style="padding:12px"
                   @click="avancarModal(2)">
                <div>
                  <i class="fa fa-th fa-2x"></i>
                </div>
                <b>Produtos</b>
              </div>
            </div>
            <div class="w3-cell" style="width: 50%;padding: 8px">
              <div class="w3-button w3-red w3-block w3-margin-top w3-round-small w3-padding-24" style="padding:12px"
                   @click="avancarModal(3)">
                <div>
                  <i class="fa fa-th fa-2x"></i>
                </div>
                <b>Adicionais</b>
              </div>
            </div>
          </div>
          <div class="w3-cell-row">
            <div class="w3-cell" style="width: 50%;padding: 8px">
              <div class="w3-button w3-red w3-block w3-margin-top w3-round-small w3-padding-24" style="padding:12px"
                   @click="avancarModal(4)">
                <div>
                  <i class="fa fa-th fa-2x"></i>
                </div>
                <b>Remoções</b>
              </div>
            </div>
            <div class="w3-cell" style="width: 50%;padding: 8px">
              <div class="w3-button w3-red w3-block w3-margin-top w3-round-small w3-padding-24" style="padding:12px"
                   @click="avancarModal(5)">
                <div>
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

        modalEditarComanda: false,
        modalEditarPedido: false,
        modalDetalhesPedido: false,
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
        nomesprodutosDetalhes: [],
        adicionaisDetalhes: [],

        editar: false,

        nomeProdutosSelecionado: "",
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
        },

        dadosComanda: {
          id_comanda: 0,
          mesa: 0,
          observacao: null
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
            closeLoading();
          });
      },

      buscarCategorias() {
        this.$http.get(base_url + 'categorias/' + this.token)
          .then(response => {
            this.categorias = response.data;
          });
      },

      buscarProdutos(id) {
        let nomeStorage = "produtos-categoria-" + id;
        if (localStorage.getItem(nomeStorage) === null) {
          openLoading("Buscando Produtos");
          this.$http.get(base_url + 'produtos/precos/1/' + this.token + '/?id_categoria=' + id + '&ingrediente=0')
            .then(response => {
              let produtosLocal = response.data;
              localStorage.setItem(nomeStorage, JSON.stringify(produtosLocal));
              this.produtos = produtosLocal;
              closeLoading();
            });
        } else {
          this.produtos = JSON.parse(localStorage.getItem(nomeStorage));
        }
      },

      buscarAdicionais(id) {
        let nomeStorage = "adicionais-categoria-" + id;
        if (localStorage.getItem(nomeStorage) === null) {
          openLoading("Buscando Adicionais");
          this.$http.get(base_url + 'produtos/precos/1/' + this.token + '/?id_categoria=' + id + '&ingrediente=1')
            .then(response => {
              let local = response.data;
              localStorage.setItem(nomeStorage, JSON.stringify(local));
              this.adicionais = local;
              closeLoading();
            });
        } else {
          this.adicionais = JSON.parse(localStorage.getItem(nomeStorage));
        }
      },

      buscarItensRemocoes() {
        let nomeStorage = "remocoes-produtos-";
        let par = {
          produtos: []
        };
        this.produtosSelecionados.forEach(p => {
          par.produtos.push(p.id_produto);
          nomeStorage += p.id_produto;
        });

        if (localStorage.getItem(nomeStorage) === null) {
          openLoading("Buscando Produtos");
          this.$http.get(base_url + 'produtos/itens/' + this.token, {params: par})
            .then(response => {
              let local = response.data;
              localStorage.setItem(nomeStorage, JSON.stringify(local));
              this.itensRemocoes = local;
              closeLoading();
            });
        } else {
          this.itensRemocoes = JSON.parse(localStorage.getItem(nomeStorage));
        }
      },

      inserirOrEditarProduto(id) {

        let base = base_url;

        //inserir
        if (!this.editar) {
          base += "comandas/inserir/produtos/";
          openLoading("Inserindo as informações");

        } else { //editar
          base += "comandas/editar/produtos/" + this.produtoDetalhes.id_comanda_produto + "/";
          openLoading("Editando as informações");

        }

        if (this.dados.produtos.length === 0) {
          this.produtosSelecionados.forEach(p => {
            this.dados.produtos.push(p.id_produto);
            this.dados.gerar_pedido = p.gerar_pedido === '1';
          });
        }
        this.dados.id_tabela = this.id_tabela;

        let options = {emulateJSON: true};
        this.$http.post(base + this.token, this.dados, options)
          .then(response => {
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
      },

      selRemocoes(nome) {
        if (!this.remocoesSelecionadosTemp.includes(nome)) {
          this.remocoesSelecionadosTemp.push(nome);
        } else {
          let index = this.remocoesSelecionadosTemp.indexOf(nome);
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

      confirmAdicionais(confirm) {
        if (confirm === true) {
          this.dados.adicionais = [];
          Object.assign(this.dados.adicionais, this.adicionaisSelecionadosTemp);
        } else {
          this.adicionaisSelecionadosTemp = [];
          Object.assign(this.adicionaisSelecionadosTemp, this.dados.adicionais);
        }

        this.avancarModal(6);
      },

      confirmRemocoes(confirm) {
        if (confirm === true) {
          this.dados.remocoes = [];
          Object.assign(this.dados.remocoes, this.remocoesSelecionadosTemp);
        } else {
          this.remocoesSelecionadosTemp = [];
          Object.assign(this.remocoesSelecionadosTemp, this.dados.remocoes);
        }

        this.avancarModal(6);
      },

      confirmObservacao(confirm) {
        if (confirm === false) {
          this.dados.observacao = null;
        }

        this.avancarModal(6);
      },

      confirmProdutos() {
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

      selProdutoDetalhes(p) {
        this.modalDetalhesPedido = true;
        this.produtoDetalhes = p;
        this.observacoes = p.observacao !== null ? p.observacao.split("||") : "";
        this.nomesprodutosDetalhes = p.nome_produto !== null ? p.nome_produto.split("||") : "";
        this.adicionaisDetalhes = p.adicionais;
      },

      selEditarPedido() {
        this.editar = true;
        let p = this.produtoDetalhes;

        //quantidade
        this.dados.quantidade = p.quantidade;

        //insercao
        this.selCategoria(p.id_categoria, p.pizza);
        let id_produto = p.id_produto.split("||");
        this.tipoPizza = id_produto.length === 1 ? 2 : 1;

        //produtos
        this.buscarProdutos(p.id_categoria);
        let nomeStorage = "produtos-categoria-" + p.id_categoria;
        let prodLocal = JSON.parse(localStorage.getItem(nomeStorage));
        prodLocal.forEach(res => {
          id_produto.forEach(id => {
            if (res.id_produto === id && res.id_tabela === p.id_tabela) {
              this.selProduto(res);
            }
          });
        });

        //adicionais
        let adicionais = p.adicionais;
        if (adicionais !== null) {
          adicionais.forEach(ads => {//qauntidade
            this.selAdicionais(ads.id_produto, ads.id_tabela_preco);
          });
          console.log(this.adicionaisSelecionadosTemp);
          this.confirmAdicionais(true);
        }

        //remocoes e observacoes
        let observacao = p.observacao;
        if (observacao !== null) {
          observacao = observacao.split("||");
          observacao.forEach(obs => {
            //remocoes
            if (obs.includes("Remoções:")) {
              obs = obs.replace("Remoções: ", "").split(",");
              obs.forEach(o => {
                this.selRemocoes(o.trim());
              });
            } else { //observacoes
              this.dados.observacao = obs.trim();
            }
          });
          console.log(this.remocoesSelecionadosTemp);
          this.confirmRemocoes(true);
        }

        this.avancarModal(6);
      },

      selEditarComanda() {
        this.dadosComanda.id_comanda = this.comanda.id_comanda;
        this.dadosComanda.mesa = this.comanda.mesa;
        this.dadosComanda.observacao = this.comanda.observacao;
        this.modalEditarComanda = true;
      },

      editarComanda() {
        openLoading("Editando informações");
        let options = {emulateJSON: true};
        this.$http.post(base_url + 'comandas/editar/' + this.token, this.dadosComanda, options)
          .then(response => {
              closeLoading();
              this.avancarModal(0);
              this.buscarComanda();
            },
            response => {
              closeLoading();
              let dados = response.data.result;
              openModalMsg("Acesso Negado", dados);
            });
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
          this.clearDados();
          this.fecharModais();
          //modal de Insercao
        } else if (modal === 1) {
          this.fecharModais();
          this.modalInsercao = true;
        } else if (modal === 2) {
          //modal de Produtos
          let tamanho = this.tipoPizza === 1 ? 2 : 1;
          this.hideProdutos = this.produtosSelecionados.length >= tamanho;
          this.buscarProdutos(this.categoriaSelecionada);

          this.fecharModais();
          this.modalProduto = true;
        } else if (modal === 3) {
          //modal de Adcionais
          this.buscarAdicionais(this.categoriaSelecionada);

          this.fecharModais();
          this.modalAdicionais = true;
        } else if (modal === 4) {
          //modal de Remocao
          this.fecharModais();
          this.modalRemocoes = true;
        } else if (modal === 5) {
          //modal de Observacoes
          this.fecharModais();
          this.modalObservacoes = true;
        } else if (modal === 6) {
          //modal Finalizar
          this.fecharModais();
          this.buscarItensRemocoes();
          this.modalFinalizar = true;
        }
      },

      fecharModais() {
        this.modalDetalhesPedido = false;
        this.modalEditarPedido = false;
        this.modalEditarComanda = false;
        this.modalInsercao = false;
        this.modalProduto = false;
        this.modalAdicionais = false;
        this.modalRemocoes = false;
        this.modalObservacoes = false;
        this.modalFinalizar = false;
      },

      clearDados() {
        this.editar = false;
        this.categoriaSelecionada = 0;
        this.tipoPizza = 2;
        this.showPizza = false;
        this.produtosSelecionados = [];
        this.adicionaisSelecionadosTemp = [];
        this.remocoesSelecionadosTemp = [];
        this.dados = {
          id_comanda: this.comanda.id_comanda,
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
        this.buscarCategorias();

      } else {
        this.$router.push("/")
      }
    },

    filters: {
      fixed(value) {
        if (value !== undefined) {
          let v = parseInt(value);
          return v.toFixed(0)
        }
      },
      produto(value) {
        let p = value.split("||");
        let res = "";
        let qtd = p.length !== 1 ? "1/2 " : "1 ";
        p.forEach(function (r) {
          res += qtd + r + " ";
        });
        return res
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
