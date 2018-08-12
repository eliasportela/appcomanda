<template>
  <div>
    <top-bar></top-bar>
    <div class="container-bottom">
      <div class="title">
        <span>COMANDAS ABERTAS</span>
      </div>
      <div class="w3-cell-row w3-padding-16 list w3-border" v-for="c in comandas" @click="abrirComanda(c.id_comanda)">
        <div class="w3-cell">
          <div class="comanda-produto">
            {{c.mesa != null ? 'Mesa: ' + c.mesa : ''}}
          </div>
          <div class="obs-comanda">
            Obs: {{c.observacao}}
          </div>
        </div>
        <div class="w3-cell list-icon">
          REF<br>{{c.ref_comanda}}
        </div>
      </div>
    </div>
    <div class="w3-bottom w3-white">
      <div class="w3-margin">
        <button class="w3-button w3-round w3-red w3-block btn-garcom" @click="toogleComanda">
          NOVA COMANDA
        </button>
      </div>
    </div>
    <div class="w3-modal" :class="{'show':modalComanda}">
      <div class="w3-modal-content" style="overflow: auto">
        <div class="w3-top top-bar">
					<span @click="toogleComanda">
						<i class="fa fa-chevron-left"></i>
						Voltar
					</span>
          <span class="w3-right" @click="novaComanda">
            Nova Comanda
            <i class="fa fa-check"></i>
          </span>
        </div>
        <div class="title-garcom">
          <span>Selecione o número da mesa</span>
        </div>
        <div class="comanda-garcom">
          <div class="w3-border w3-padding comanda-input-mesa">
            <span>Mesa:</span>
            <span>{{dados.mesa}}</span>
          </div>
          <div class="w3-container">
            <div class="w3-cell-row w3-center comanda-btn">
              <div class="w3-cell">
                <button class="w3-button w3-round w3-border comanda-btn-numero" @click="selNumero(1)">1</button>
              </div>
              <div class="w3-cell">
                <button class="w3-button w3-round w3-border comanda-btn-numero" @click="selNumero(2)">2</button>
              </div>
              <div class="w3-cell">
                <button class="w3-button w3-round w3-border comanda-btn-numero" @click="selNumero(3)">3</button>
              </div>
            </div>
            <div class="w3-cell-row w3-center comanda-btn">
              <div class="w3-cell">
                <button class="w3-button w3-round w3-border comanda-btn-numero" @click="selNumero(4)">4</button>
              </div>
              <div class="w3-cell">
                <button class="w3-button w3-round w3-border comanda-btn-numero" @click="selNumero(5)">5</button>
              </div>
              <div class="w3-cell">
                <button class="w3-button w3-round w3-border comanda-btn-numero" @click="selNumero(6)">6</button>
              </div>
            </div>
            <div class="w3-cell-row w3-center comanda-btn">
              <div class="w3-cell">
                <button class="w3-button w3-round w3-border comanda-btn-numero" @click="selNumero(7)">7</button>
              </div>
              <div class="w3-cell">
                <button class="w3-button w3-round w3-border comanda-btn-numero" @click="selNumero(8)">8</button>
              </div>
              <div class="w3-cell">
                <button class="w3-button w3-round w3-border comanda-btn-numero" @click="selNumero(9)">9</button>
              </div>
            </div>
            <div class="w3-cell-row w3-center comanda-btn">
              <div class="w3-cell">
                <button class="w3-button w3-round w3-border comanda-btn-numero" @click="eraserNumero(true)">
                  <i class="fa fa-eraser"></i>
                </button>
              </div>
              <div class="w3-cell">
                <button class="w3-button w3-round w3-border comanda-btn-numero" @click="selNumero(0)">0</button>
              </div>
              <div class="w3-cell">
                <button class="w3-button w3-round w3-border comanda-btn-numero" @click="eraserNumero()">
                  <i class="fa fa-arrow-left"></i>
                </button>
              </div>
            </div>
          </div>
          <div class="comanda-add-obs">
            <label>Observações</label>
            <textarea class="w3-input w3-text w3-border" placeholder="Observações da comanda"
                      v-model="dados.observacao">
						</textarea>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

  import TopBar from "../commons/TopBar.vue"
  import ModalProduto from "../commons/Modal.vue"

  export default {
    beforeCreate: function () {
      document.body.className = 'cliente';
    },
    components: {TopBar, ModalProduto},
    data() {
      return {
        token: '',
        comandas: '',
        modalComanda: false,
        dados: {
          mesa: "",
          observacao: "",
        }
      }
    },
    methods: {
      buscarComandas() {
        openLoading("Buscando Comandas");
        this.$http.get(base_url + 'comandas/1/' + this.token + '?status_comanda=1')
          .then(response => {
            this.comandas = response.data;
            closeLoading();
          });
      },
      toogleComanda() {
        this.modalComanda = !this.modalComanda;
        if (this.modalComanda == false) {
          this.buscarComandas();
        }
      },
      novaComanda() {
        if (this.dados.mesa !== '') {
          openLoading("Cadastrando comanda..");
          let options = {emulateJSON: true};
          this.$http.post(base_url + 'comandas/inserir/' + this.token, this.dados, options)
            .then(response => {
              let id_comanda = response.data.id_comanda;
              if (id_comanda != null) {
                closeLoading();
                this.$router.push("comanda-detalhes/" + id_comanda);
              } else {
                openModalMsg("Ops!",response.data.result);
              }
            });
        } else {
          openModalMsg("Ops!", "Selecione uma mesa");
        }
      },

      abrirComanda(id) {
        this.$router.push("comanda-detalhes/" + id)
      },
      selNumero(n) {
        this.dados.mesa += n;
      },
      eraserNumero(limpar) {
        if (limpar) {
          this.dados.mesa = "";
        } else if (this.dados.mesa.length > 0) {
          this.dados.mesa = this.dados.mesa.substr(0, (this.dados.mesa.length - 1));
        }
      }
    },
    created: function () {
      if (localStorage.getItem('key') !== undefined) {
        this.token = localStorage.getItem('key');
        this.buscarComandas();

      } else {
        this.$router.push("/")
      }
    }
  }
</script>

<style scoped>
  .list-icon {
    width: 25%;
    text-align: center;
  }
  .comanda-btn {
    margin-top: 12px
  }
  .comanda-btn-numero:hover {
    background-color: #FFF!important;
    color: #000!important;
  }
  .comanda-btn-numero {
    width: 90%;
    height: 50px
  }
  .comanda-input-mesa {
    margin: 0 20px;
    color: #aaa;
    font-weight: 900
  }
  .comanda-add-obs {
    margin: 16px 16px 24px 16px;
  }
  .w3-text {
    resize: none;
  }
  .w3-modal-content {
    height: 110%
  }
  .w3-text:focus + div {
    background-color: red
  }

</style>
