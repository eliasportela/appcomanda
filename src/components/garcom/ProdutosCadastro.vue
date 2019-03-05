<template>
  <div>
    <top-bar/>
    <menu-dash/>
    <div class="w3-main" style="margin-left:300px;margin-top:50px;">
      <header class="w3-container" style="padding-top:14px">
        <h6><b>Produtos</b></h6>
      </header>
      <div style="margin: 0 16px">
        <form @submit.prevent="cadastrar">
          <div class="w3-padding" style="margin:0 -16px">
            <div>
              <router-link to="/produtos" class="w3-button w3-red">
                <i class="fa fa-chevron-left"></i> Voltar
              </router-link>
              <button class="w3-button w3-red w3-right" type="submit" style="margin-left: 12px; width: 150px"><i
                class="fa fa-check"></i> Salvar
              </button>
              <a href="/produtos/cadastrar" class="w3-button w3-red w3-right" ><i class="fa fa-plus"></i> Novo Produto</a>
            </div>
            <br>
            <div class="w3-responsive w3-card w3-white w3-padding-32">
              <div class="w3-row-padding">
                <div class="w3-col m2 w3-margin-top">
                  <label for="id_categoria">Categoria do Produto</label>
                  <select class="w3-select w3-white w3-border" id="id_categoria" name="id_categoria" v-model="dados.id_categoria" required>
                    <option v-for="c in categorias" :value="c.id_categoria">{{c.nome_categoria}}</option>
                  </select>
                </div>
                <div class="w3-col m4 w3-margin-top">
                  <label for="nome_produto">Nome do Produto</label>
                  <input type="text" class="w3-input w3-border" placeholder="Nome Produto" id="nome_produto" v-model="dados.nome_produto"
                         name="nome_produto" required>
                </div>
                <div class="w3-col m2 w3-margin-top">
                  <label for="referencia">Referência</label>
                  <input type="text" class="w3-input w3-border" placeholder="Ref do Produto"
                         id="referencia" name="referencia" :disabled="true">
                </div>
                <div class="w3-col m2 w3-margin-top">
                  <label for="gerar_pedido">Gerar Pedido</label>
                  <select class="w3-select w3-white w3-border" id="gerar_pedido" name="gerar_pedido" v-model="dados.gerar_pedido" required>
                    <option value="1">Sim</option>
                    <option value="0">Não</option>
                  </select>
                </div>
                <div class="w3-col m2 w3-margin-top">
                  <label for="ingrediente">Ingrediente</label>
                  <select class="w3-select w3-white w3-border" id="ingrediente" name="ingrediente" v-model="dados.ingrediente" required>
                    <option value="0">Não</option>
                    <option value="1">Sim</option>
                  </select>
                </div>
              </div>
            </div>
          </div>
          <hr>

          <input type="hidden" id="id_produto" name="id_produto" v-model="dados.id_produto">
          <div class="w3-margin-bottom">
            <h6><b>Composição</b></h6>
          </div>

          <div class="w3-card w3-white w3-padding w3-padding-16">
            <div class="w3-row-padding">
              <div class="w3-col m12">
                <h5>Inserir Produto</h5>
              </div>
              <div class="w3-col m8">
                <label>Selecione o produto a ser inserido</label>
                <select class="w3-select w3-border w3-white" id="produtos">
                  <option value=""></option>
                </select>
              </div>
              <div class="w3-col m4">
                <label>Inserir Produto</label>
                <button class="w3-button w3-black w3-dark-gray w3-block" type="button"
                        onclick="addItemTabela()"><i class="fa fa-plus"></i> Adicionar Produto
                </button>
              </div>
            </div>
            <br>
            <div class="w3-responsive w3-border" style="min-height: 150px">
              <table class="w3-table w3-bordered w3-centered" id="tableItens">
                <thead>
                <tr class="w3-red">
                  <th style="width: 70%">Nome</th>
                  <th style="width: 30%">Remover</th>
                </tr>
                </thead>
                <tbody id="itens">
                </tbody>
              </table>
            </div>
          </div>
          <!-- tsetset -->
          <hr>
          <div class="w3-margin-bottom">
            <h6><b>Tabela de Preços</b></h6>
          </div>
          <div class="w3-card w3-white w3-padding w3-padding-16">
            <div class="w3-row-padding">
              <div class="w3-col m12">
                <h5>Tabela de Preços</h5>
              </div>
              <div class="w3-col m4">
                <label>Escolha a tabela</label>
                <select class="w3-select w3-border w3-white" id="precos">
                  <?php foreach ($tabela as $t) { ?>
                  <option value="<?= $t->id_tabela ?>"><?= $t->nome_tabela ?></option>
                  <?php } ?>
                </select>
              </div>
              <div class="w3-col m4">
                <label>Insira o valor</label>
                <input class="w3-input w3-border" id="precosValor" type="number" placeholder="Ex: 25.20">
              </div>
              <div class="w3-col m4">
                <label>Inserir Tabela de Preços</label>
                <button class="w3-button w3-black w3-dark-gray w3-block" type="button"
                        onclick="addPrecoTabela()"><i class="fa fa-plus"></i> Adicionar Tabela
                </button>
              </div>
            </div>
            <br>
            <div class="w3-responsive" style="min-height: 150px">
              <table class="w3-table w3-bordered w3-centered" id="tablePreco">
                <thead>
                <tr class="w3-red">
                  <th style="width: 30%">Tabela</th>
                  <th style="width: 40%">Valor</th>
                  <th style="width: 30%">Remover</th>
                </tr>
                </thead>
                <tbody id="valores">
                </tbody>
              </table>
            </div>
          </div>
          <hr>
          <div>
            <h6><b><i class="fa fa-exclamation-triangle"></i> Danger Zone</b></h6>
          </div>
          <br>
          <div class="w3-responsive w3-card w3-white w3-border w3-margin-bottom" style="min-height: 70px">
            <button type="button" class="w3-button w3-red w3-margin"
                    onclick="deletarProdutorId(id)">
              <i class="fa fa-trash-o"></i>
              Deletar este Produto
            </button>
          </div>

        </form>
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
        editar: false,
        categorias: [],

        //pesquisa
        id_produto: '',
        nomeProduto: '',
        tipo: 1,
        referencia: '',
        ingrediente: 'false',

        dados: {
          id_categoria: 1,
          nome_produto: '',
          gerar_pedido: 1,
          ingrediente: 0,
        },

        dadosEditar: {
          id_produto: 1,
          id_categoria: 1,
          nome_produto: '',
          gerar_pedido: 1,
          ingrediente: 0,
        }
      }
    },
    methods: {
      buscarCategorias() {
        this.$http.get(base_url + 'categorias/' + localStorage.getItem('key'))
          .then(response => {
            this.categorias = response.data;
          });
      },

      cadastrar() {
        this.$http.post(base_url + 'produto', this.dados, {emulateJSON: true})
          .then(res => {
            this.$router.push("/produtos/editar/" + res.data);
          },
          res => {
            alert(res.data.result);
          });
      }
    },

    mounted() {
      this.buscarCategorias();

      if (this.$route.params.id) {
        console.log(this.$route.params.id);
        this.editar = true;
        this.dados.id_produto = this.$route.params.id;
      }
    }
  }
</script>

<style scoped>

</style>
