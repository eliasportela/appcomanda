<template>
	<div>
		<div class="w3-top top-bar">
			<span>COMANDA: CA404</span>
		</div>
		<div class="container-bottom">
			<div class="title">
				PRODUTOS
			</div>
			<div class="w3-cell-row list w3-padding-16" v-for="item in 10" @click="toogleProduto">
				<div class="w3-cell">
					<div class="comanda-produto"> 
						<span>Pizza Lombinho Catupiry</span>
					</div>
					<div class="obs-comanda">
						<span><b>QTD:</b> 1/2</span>
					</div>
				</div>
				<div class="w3-cell list-icon">
					<i class="fa fa-info-circle"></i><br>
					<span class="w3-small">Mais</span>
				</div>
			</div>
		</div>
		
		<div class="w3-modal" :class="{'show':modalProduto}">
			<div class="w3-modal-content">
				<div class="w3-top top-bar">
					<span class="w3-right" @click="toogleProduto">
						FECHAR 
						<i class="fa fa-times"></i>
					</span>
					<span>
						<i class="fa fa-th"></i>
					</span>
				</div>
				<div class="container-bottom">
					<div class="w3-center w3-border-bottom w3-padding title">
						PRODUTO
					</div>
					<ul class="w3-ul comanda-ul">
						<li>1/2 - Pizza Lombo Catupiry</li>
						<li>1/2 - Pizza Lombo Catupiry</li>
					</ul>
					<div class="w3-margin-top w3-center w3-border-bottom w3-padding title">
						ADICIONAIS E OBSERVAÇÕES
					</div>
					<ul class="w3-ul comanda-ul">
						<li>- S/ Cebola</li>
						<li>- C/ Bacon</li>
						<li>- C/ Borda Catupiry</li>
					</ul>
				</div>
			</div>
		</div>
		
		<bottom-bar></bottom-bar>

	</div>
</template>

<script>

import BottomBar from "../commons/BottomBar.vue"
import ModalProduto from "../commons/Modal.vue"
	export default {
		beforeCreate: function() {
			document.body.className = 'cliente';
		},
		components:{BottomBar,ModalProduto},
		data(){
		    return{
		      modalProduto:false
		    }
	  	},
	  	methods:{
	  		toogleProduto(){
	  			this.modalProduto = !this.modalProduto
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