<template>
  <div>
    <top-bar voltar="comanda-garcom"/>
    <menu-dash/>
    <div class="w3-main" style="margin-left:300px;margin-top:50px;">
      <header class="w3-container" style="padding-top:24px">
        <button class="w3-button w3-center w3-text-red w3-right" @click="selEditarComanda">
          <i class="fa fa-edit fa-2x"></i><br>
          <span class="w3-small">EDITAR</span>
        </button>
        <span><b>COMANDA: </b>{{comanda.ref_comanda}}</span><br/>
        <span><b>MESA:</b> {{comanda.mesa}}</span><br/>
        <span><b>OBS:</b> {{comanda.observacao}}</span>
      </header>
      <div class="w3-container">
        <h6 class="w3-center"><b>Produtos</b></h6>
        <div class="w3-cell-row w3-padding w3-white pointer comanda" v-for="p in produtosComanda" @click="selProdutoDetalhes(p)">
          <div class="w3-cell">
            <div class="comanda-produto">
              <span><b>{{p.nome_categoria}} - {{p.nome_tabela}}</b></span><br>
              <span>{{p.nome_produto | produto}}</span>
            </div>
            <div class="obs-comanda">
              <span><b>QTD:</b> {{p.quantidade | fixed}}</span>
            </div>
          </div>
          <div class="w3-cell list-icon w3-text-red">
            <i class="fa fa-chevron-right"></i><br>
            <span class="w3-small">EDITAR</span>
          </div>
        </div>

      </div>
    </div>

    <div class="w3-bottom w3-red">
      <button class="w3-button w3-padding-16 w3-round w3-red w3-block btn-garcom" @click="avancarModal(1)">
        Adicionar Produto
      </button>
    </div>

    <div class="w3-modal" :class="{'show':modalEditarComanda}">
      <div class="w3-modal-content">
        <div class="top-bar">
          <button class="w3-button" style="margin:6px" @click="avancarModal(0)">
            Cancelar
          </button>
          <button class="w3-button w3-right" style="margin:6px" @click="editarComanda()">
            Editar Comanda
            <i class="fa fa-check"></i>
          </button>
        </div>
        <div class="title-garcom">
          EDITAR COMANDA
        </div>
        <div class="w3-container">
          <div class="w3-row">
            <div class="w3-col s12">
              <label for="mesa"><b>Mesa</b></label>
              <input id="mesa" type="number" class="w3-input w3-border" v-model="dadosComanda.mesa"/>
            </div>
            <div class="w3-col s12 w3-margin-top w3-margin-bottom">
              <label for="observacao"><b>Observação</b></label>
              <textarea id="observacao" placeholder="Observações da comanda" class="w3-input w3-border" rows="5" v-model="dadosComanda.observacao"></textarea>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="w3-modal" :class="{'show':modalDetalhesPedido}">
      <div class="w3-modal-content">
        <div class="top-bar">
          <button class="w3-button" style="margin:6px 2px" @click="avancarModal(0)">
						<i class="fa fa-chevron-left"></i>
            Voltar
					</button>
          <button class="w3-button w3-right" style="margin:6px 0" @click="selEditarPedido()">
            Editar Pedido
            <i class="fa fa-edit"></i>
          </button>
        </div>
        <div style="padding: 16px 24px 0 24px">
          <span><b>Informações do Produto</b></span>
          <ul class="w3-ul comanda-ul">
            <li>
              <span class="ul-titile w3-text-red" style="padding-bottom: 0">
                Quantidade: <span>{{produtoDetalhes.quantidade | fixed}}</span>
              </span>
            </li>
            <li>
              <span class="ul-titile w3-text-red">Produto</span>
              <span class="ul-body" v-for="p in nomesprodutosDetalhes" :key="p">
              - {{nomesprodutosDetalhes.length !== 1 ? "1/2" : ""}} {{p}}
              </span>
            </li>
            <li v-show="produtoDetalhes.pizza === '1'">
              <span class="ul-titile w3-text-red">Tamanho</span>
              {{produtoDetalhes.nome_tabela}}
            </li>
          </ul>
          <div class="w3-text-red" v-show="observacoes !== ''">
            <b>Observações</b>
          </div>
          <ul class="w3-ul comanda-ul">
            <li v-show="observacoes !== ''">
              <span class="ul-body" v-for="obs in observacoes" :key="obs">
              - {{obs}}
              </span>
            </li>
            <li v-show="adicionaisDetalhes !== ''">
              <span class="ul-titile w3-text-red">Adicionais</span>
              <span v-for="ads in adicionaisDetalhes">- c/ {{ads.nome_produto}}</span>
            </li>
          </ul>
          <div class="w3-margin-top">
            <div class="w3-padding w3-padding-16 w3-center" v-show="observacoes === '' && adicionaisDetalhes === ''">
              <img src="/static/imgs/pizza-caixa.svg" style="width: 80px"/>
              <h5>Nenhuma informação adicional para o produto selecionado</h5>
            </div>
          </div>
        </div>
        <div class="bottom-bar w3-red">
          <button class="w3-button w3-padding-16 w3-round w3-red w3-block btn-garcom" @click="modalConfirm = true">
            Deletar Pedido
          </button>
        </div>
      </div>
    </div>

    <div class="w3-modal" :class="{'show':modalInsercao}">
      <div class="w3-modal-content">
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
        <br>
      </div>
    </div>

    <div class="w3-modal" :class="{'show':modalProduto}">
      <div class="w3-modal-content">
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
          <button class="w3-button" style="margin: 6px" @click="avancarModal(0)">
            Cancelar
          </button>
          <button class="w3-button w3-right" style="margin: 6px" @click="inserirOrEditarProduto()">
            Finalizar
            <i class="fa fa-check"></i>
          </button>
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

    <!--modal confirm-->
    <div class="w3-modal modal-msg" :class="{'show':modalConfirm}">
      <div class="w3-modal-content w3-center w3-round w3-padding-16" style="min-height: inherit">
        <div style="padding: 20px 20px;color: #353535">
          <b id="confirm-text" class="w3-large">Deseja remover o produto?</b><br>
        </div>
        <div class="w3-cell-row w3-margin-top w3-padding">
          <div class="w3-cell">
            <button class="w3-button w3-block w3-text-red" @click="modalConfirm = false">Não</button>
          </div>
          <div class="w3-cell">
            <button class="w3-button w3-block w3-red w3-round" @click="removerPedido">Sim</button>
          </div>
        </div>
      </div>
    </div>

  </div>
</template>

<script>

  import TopBar from "../commons/TopBar.vue"
  import MenuDash from "../commons/MenuDash.vue"

  export default {
    components: {TopBar,MenuDash},
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
        modalConfirm: false,

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
        adicionaisDetalhes: '',

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
        console.log(base_url + 'produtos/precos/1/' + this.token + '/?id_categoria=' + id + '&ingrediente=0');
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
          this.confirmRemocoes(true);
        }

        this.avancarModal(6);
      },

      removerPedido(){

        this.modalConfirm = false;

        let p = this.produtoDetalhes.id_comanda_produto;
        openLoading("Removendo o produto");

        let options = {emulateJSON: true};
        this.$http.post(base_url + 'comandas/remover/produtos/' + this.token, {id_comanda_produto: p}, options)
          .then(response => {
              closeLoading();
              this.avancarModal(0);
              this.buscarComanda();
            },
            response => {
              let dados = response.data.result;
              console.log(response);
              openModalMsg("Acesso Negado", dados);
            });
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
  .comanda {
    margin: 8px 0;
  }
  .list-icon {
    width: 20%;
    text-align: center;
  }

  .w3-button:hover {
    background-color: #fff !important;
    color: #aaa !important;
  }

  .w3-red:hover {
    background-color: #F44336 !important;
    color: #fff !important;
  }
</style>
