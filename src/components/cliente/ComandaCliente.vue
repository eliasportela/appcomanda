<template>
	<div>
		<div class="w3-container title-client">
			<span>COMANDA: CA404</span>
		</div>
		<div class="w3-margin-top container">
			<div class="w3-cell-row list" v-for="item in 5">
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
		
		<modal-produto>
			<div class="w3-center w3-border-bottom w3-padding">
				PRODUTO
			</div>
			<ul class="w3-ul comanda-ul">
				<li>1/2 - Pizza Lombo Catupiry</li>
				<li>1/2 - Pizza Lombo Catupiry</li>
			</ul>
			<div class="w3-margin-top w3-center w3-border-bottom w3-padding">
				ADICIONAIS E OBSERVAÇÕES
			</div>
			<ul class="w3-ul comanda-ul">
				<li>- S/ Cebola</li>
				<li>- C/ Bacon</li>
				<li>- C/ Borda Catupiry</li>
			</ul>
		</modal-produto>
		
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
	      produtos:4
	    }
	  }
	}
</script>

<style scoped>
	.list-icon{
		width: 20%;
		text-align: center;
	}
</style>