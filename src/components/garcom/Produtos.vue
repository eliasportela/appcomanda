<template>
  <div>
    <top-bar/>
    <menu-dash/>
    <div class="w3-main" style="margin-left:300px;margin-top:50px;">
      <header class="w3-container w3-cell-row" style="padding-top:22px">
        <button class="w3-button w3-round w3-red w3-right" @click="$router.push('produtos/cadastrar')"><i class="fa fa-plus"></i> Cadastrar</button>
        <button class="w3-button w3-red w3-right" style="margin-right: 12px" @click="limparSearch()">Limpar Filtros</button>
        <h6><b>Produtos</b></h6>
      </header>
      <div class="w3-panel">
        <div class="w3-row-padding" style="margin:0 -16px">
          <div class="w3-container w3-card w3-white w3-padding w3-padding-32">
            <div class="w3-row-padding w3-center">
              <div class="w3-col l2">
                <label class="w3-margin-top"><b>Referência</b></label>
                <input type="text" class="w3-input w3-border" placeholder="Ref Produto" v-model="referencia">
              </div>
              <div class="w3-col l3">
                <label class="w3-margin-top"><b>Nome</b></label>
                <input type="text" class="w3-input w3-border" placeholder="Nome do Produto" v-model="nomeProduto">
              </div>
              <div class="w3-col l3">
                <label class="w3-margin-top"><b>Tipo</b></label>
                <select class="w3-select w3-border w3-white" v-model="tipo">
                  <option value="0">Todas</option>
                  <option v-for="c in categorias" :value="c.id_categoria">{{c.nome_categoria}}</option>
                </select>
              </div>
              <div class="w3-col l2">
                <label class="w3-margin-top"><b>Ingrediente</b></label><br>
                <select class="w3-select w3-border w3-white" v-model="ingrediente">
                  <option value="false">Não</option>
                  <option value="true">Sim</option>
                </select>
              </div>
              <div class="w3-col l2">
                <label class="w3-margin-top"><b>Pesquisar</b></label>
                <button class="w3-button w3-block w3-red" @click="getProdutos(1)"><i class="fa fa-search"></i></button>
              </div>
            </div>
          </div>
          <br>
          <div class="w3-card">
            <div class="w3-responsive w3-white table-produto">
              <table class="w3-table w3-hoverable w3-bordered w3-centered">
                <thead>
                  <tr class="w3-red">
                    <th style='width:5%'><i class="fa fa-tag"></i></th>
                    <th style='width:15%'>Referência</th>
                    <th style='width:35%'>Nome</th>
                    <th style='width:15%'>Ingrediente</th>
                    <th style='width:30%'>Categoria</th>
                  </tr>
                </thead>
                <tbody>
                  <tr v-for="p in produtos" @click="$router.push('produtos/editar/' + p.id_produto)">
                    <td><i class="fa fa-tag"></i></td>
                    <td>{{p.ref_produto}}</td>
                    <td>{{p.nome_produto}}</td>
                    <td>{{p.ingrediente === "1" ? "Sim" : "Não"}}</td>
                    <td>{{p.nome_categoria}}</td>
                  </tr>
                </tbody>
              </table>
              <div class="w3-display-middle w3-center" v-show="naoEcontrado">
                <div>
                  <h2><i class="far fa-frown"></i></h2>
                  <span>Nenhum produto encotrado</span>
                </div>
              </div>
            </div>
            <div class="w3-bar w3-border">
              <button @click="getProdutos(--page)" class="w3-button" :disabled="!anterior">&#10094; Anterior</button>
              <button @click="getProdutos(++page)" class="w3-button w3-right" :disabled="!posterior">Próximo &#10095;</button>
            </div>
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
    components: {TopBar, MenuDash},
    data() {
      return {
        page: 1,
        produtos: [],
        categorias: [],
        naoEcontrado: false,

        //pesquisa
        nomeProduto: '',
        tipo: 0,
        referencia: '',
        ingrediente: 'false',
        anterior: false,
        posterior: true,
      }
    },
    methods: {
      getProdutos(page) {
        openLoading("Buscando Comandas");
        this.page = page;
        let url = base_url + 'produtos/' + this.page;

        this.$http.get(url + '?' +
          "nome=" + this.nomeProduto + '&' +
          "categoria=" + this.tipo + '&' +
          "referencia=" + this.referencia + '&' +
          "ingrediente=" + this.ingrediente

        ).then(response => {
          if (response.data) {
            this.produtos = response.data.result;
            this.anterior = response.data.page > 1;
            this.posterior = response.data.page < response.data.pages;
            this.naoEcontrado = false;
          } else {
            this.produtos = [];
            this.naoEcontrado = true;
          }

          closeLoading();
        });

      },

      buscarCategorias() {
        this.$http.get(base_url + 'categorias/' + localStorage.getItem('key'))
          .then(response => {
            this.categorias = response.data;
          });
      },

      limparSearch() {
        this.nomeProduto = '';
        this.tipo = 0;
        this.referencia = '';
        this.ingrediente = 'false';

        this.getProdutos(1);
      }
    },
    mounted() {
      this.buscarCategorias();
      this.getProdutos(1);
    }
  }
</script>

<style scoped>
  .table-produto {
    min-height: 200px;
    position: relative;
  }

  .w3-centered tr td {
    cursor: pointer;
    padding: 13px
  }

  .w3-table td {
    vertical-align: middle;
  }
</style>
