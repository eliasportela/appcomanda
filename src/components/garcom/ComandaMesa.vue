<template>
	<div>
		<top-bar></top-bar>
		<div class="title-garcom mesa-title">
			<div class="w3-cell-row">
			<div class="w3-cell w3-cell-middle">
				<div>
					<span>COMANDAS: C0123</span>	
				</div>
				<div>
					<span>OBS: Elias Portela</span>	
				</div>	
			</div>
			<div class="w3-cell w3-center w3-cell-middle">
				<i class="fa fa-edit fa-2x"></i><br>
				<span class="w3-small">EDITAR</span>
			</div>
			</div>
		</div>
		<div class="container-garcom">
			<div class="w3-cell-row list">
				<div class="w3-cell">
					<div class="comanda-produto"> 
						<span>Lombinho Catupiry</span>
					</div>
					<div class="obs-comanda">
						<span><b>QTD:</b> 1/2</span>
					</div>
				</div>
				<div class="w3-cell list-icon">
					<i class="fa fa-chevron-right"></i><br>
					<span class="w3-small">EDITAR</span>
				</div>
			</div>
		</div>
		<div class="w3-margin">
			<button class="w3-button w3-round w3-block w3-red btn-garcom">
				ADICIONAR
			</button>
		</div>
		<div class="w3-modal">
			<div class="w3-modal-content w3-animate-opacity">
				<top-bar></top-bar>
				<div class="title-garcom">
					<span>Selecione o número da mesa</span>
				</div>
				<div class="container-garcom">
					<div class="w3-border w3-padding comanda-input-mesa">
						<span>Mesa:</span>
						<span>12</span>
					</div>
					<div class="w3-container">

					</div>
					<div class="w3-margin comanda-add-obs">
						<label>Observações</label>
						<textarea class="w3-input w3-text w3-border" placeholder="Observações da comanda">
						</textarea>
					</div>
				</div>
				<div class="w3-margin">
					<button class="w3-button w3-round w3-block w3-red btn-garcom">
						CONFIRMAR
					</button>
				</div>
			</div>
		</div>
	</div>
</template>

<script>

import TopBar from "../commons/TopBar.vue"
import ModalProduto from "../commons/Modal.vue"
	export default {
		beforeCreate: function() {
			document.body.className = 'cliente';
		},
		components:{TopBar,ModalProduto},
		data(){
	    return{
	      produtos:4
	    }
	  }
	}
</script>

<style scoped>
.list-icon{
	width: 25%;
	text-align: center;
	padding-left: 10px
}
.mesa-title{
	margin: 0 24px;
	text-align: left;
	font-size: 1em
}
.container-garcom{
	height: 66vh
}
</style>