<template>
  <div>
    <top-bar/>
    <menu-dash/>
    <div class="w3-main" style="margin-left:300px;margin-top:50px;">
      <header class="w3-container" style="padding-top:14px">
        <h6><b>Comandas Abertas</b></h6>
      </header>
      <div class="w3-row-padding">
        <div class="w3-col l3" v-for="c in comandas">
          <div class="w3-padding w3-padding w3-white pointer" style="margin-bottom: 8px">
            <div class="comanda-list" @click="abrirComanda(c.id_comanda)">
              <div class="w3-right">
                <span class="w3-small"><b>REF:</b> {{c.ref_comanda}}</span>
              </div>
              <div class="comanda-produto">
                <b>MESA:</b> 0{{c.mesa}}
              </div>
              <div>
                <b class="w3-small">Obs:</b> {{c.observacao}}
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <div class="w3-bottom w3-red">
      <button class="w3-button w3-padding-16 w3-round w3-red w3-block btn-garcom" @click="toogleComanda">
        Nova Comanda
      </button>
    </div>

    <div class="w3-modal" :class="{'show':modalComanda}">
      <div class="w3-modal-content" style="overflow: auto">
        <div class="top-bar">
					<button class="w3-button" style="margin:8px" @click="toogleComanda">
						<i class="fa fa-chevron-left"></i>
						Voltar
					</button>
          <button class="w3-button w3-right" style="margin:8px" @click="novaComanda">
            Confirmar
            <i class="fa fa-check"></i>
          </button>
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
  import MenuDash from "../commons/MenuDash.vue"
  import ModalProduto from "../commons/Modal.vue"

  export default {
    components: {TopBar, ModalProduto, MenuDash},
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
        if (this.modalComanda === false) {
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
      if (localStorage.getItem('key') !== null) {
        this.token = localStorage.getItem('key');
        this.buscarComandas();

        setInterval(() => {
          this.buscarComandas();
        }, 1000 * 60);

      } else {
        this.$router.push("/login")
      }
    }
  }
</script>

<style scoped>
  .comanda {
    margin: 8px 0;
  }
  .comanda-list {
    height: 60px;
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
  .w3-text:focus + div {
    background-color: red
  }

  @media all and (max-width: 600px) {
    .comanda-list {
      height: auto;
    }
  }

</style>
