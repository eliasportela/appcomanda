<template>
	<div>
		<div class="w3-top top-bar">
			<span>COMANDA: {{comanda.ref_comanda}}</span>
		</div>
		<div class="container-bottom">
			<div class="title">
				PRODUTOS
			</div>
			<div class="w3-cell-row list w3-padding-16" v-for="p in produtos" :key="p.id" @click="toogleProduto(p.id_comanda_produto)">
				<div class="w3-cell">
					<div class="comanda-produto">
						<span>{{p.nome_produto}}</span>
					</div>
					<div class="obs-comanda">
						<span><b>QTD:</b> {{p.quantidade}}</span>
					</div>
				</div>
				<div class="w3-cell list-icon">
					<i class="fa fa-info-circle"></i><br>
					<span class="w3-small">Mais</span>
				</div>
			</div>
		</div>

		<div class="w3-modal" :class="{'show':modalProduto}">
			<div class="w3-modal-content w3-animate-opacity">
				<div class="w3-top top-bar">
					<span @click="toogleProduto">
						<i class="fa fa-chevron-left"></i>
						Voltar
					</span>
				</div>
				<div class="title-garcom">
					<span>Informações do Produto</span>
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
						<li v-for="obs in observacoes" :key="obs">- {{obs}}</li>
					</ul>
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
		beforeCreate: function() {
			document.body.className = 'cliente';
		},
		components:{BottomBar,TopBar},
		data(){
		    return{
          		url: 'http://localhost/',
		    	    modalProduto:false,

          		comanda:"",
          		produtoDetalhes:"",
          		observacoes:"",
          		produtos:[],

		    }
	  	},
	  	methods:{
	  		buscarComanda(id){
	  			//getComanda
				this.$http.get(this.url + 'comanda-server/admin/api/comanda/id/' + id)
				.then(response => {
					this.comanda = response.data;
					this.buscarProdutosComanda();
				});
	  		},
	  		buscarProdutosComanda(){
	  			this.$http.get(this.url + 'comanda-server/admin/api/comanda-prudutos/' + this.comanda.id_comanda)
				.then(response => {
					this.produtos = response.data;
				});
	  		},
	  		buscarDetalhesProdutoComanda(id){
				this.$http.get(this.url + 'comanda-server/admin/api/comanda-pruduto/' + id)
				.then(response => {
					this.produtoDetalhes = response.data;
					this.observacoes = this.produtoDetalhes.observacao.split("||");
				});
			},
	  		toogleProduto(id){
	  			this.modalProduto = !this.modalProduto;
	  			if (id) {
	  				this.buscarDetalhesProdutoComanda(id);
	  			}
	  		}
	  	},

      created: function () {
        var id = localStorage.getItem("comanda");
        if(id != undefined){
          this.buscarComanda(id);
        }else{
          this.$router.push("/");
        }
      }
	}
</script>

<style scoped>
	.list-icon{
		width: 15%;
		text-align: center;
	}
</style>
