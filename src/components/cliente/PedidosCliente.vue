<template>
	<div>
		<div class="w3-top">
			<div class="top-bar">
				<span>MEUS PEDIDOS</span>
			</div>
		</div>
		<div class="container-bottom">
			<div class="title">
				PEDIDOS
			</div>
			<div class="list pedido-item" v-for="(p, index) in produtos" :key="p.id_produto_comanda">
				<div class="w3-border-bottom header">
					<i class="fa fa-utensils w3-text-red" v-show="p.status_pedido == 1"></i>
					<i class="fa fa-check w3-text-green" v-show="p.status_pedido == 2"></i>
					Pedido {{index + 1}} - {{p.nome_categoria}}
					<span class="w3-right"><i class="fa fa-clock" style="font-size:1em"></i> {{p.horas}}</span>
				</div>
				<div class="pedido-body">
					<span>- {{p.quantidade}} {{p.nome_produto}}</span><br>
					<span class="pedido-obs">
						<span style="display: block" v-for="(obs, index) in p.observacoes" :key="index">- {{obs}}</span>
					</span>
				</div>
			</div>
			<hr>
			<div class="w3-center text-primary">
				<i class="fa fa-utensils w3-text-red"></i>  Pedido enviado -
				<i class="fa fa-check w3-text-green"></i>  Pedido Pronto <br>
			</div>
		</div>
		<bottom-bar></bottom-bar>
	</div>
</template>

<script>

import BottomBar from "../commons/BottomBar.vue"
	export default {
		beforeCreate: function() {
			document.body.className = 'cliente';
		},
		components:{BottomBar},
		data(){
		    return{
		      	modalProduto:false,
	        	id_comanda:"",
	        	produtoDetalhes:"",
	        	produtos:[],
		    }
	  	},
	    methods:{
	  		buscarProdutosComanda(){
	  			this.$http.get(base_url + 'admin/api/pedidos-comanda/' + this.id_comanda)
				.then(response => {
					this.produtos = response.data;
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
	          this.id_comanda = localStorage.getItem("comanda");
	          this.buscarProdutosComanda();
	        }else{
	          this.$router.push("/");
	        }
	      }
		}
</script>

<style scoped>
	.pedido-body{
		margin-top: 12px
	}

</style>
