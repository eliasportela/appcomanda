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
			<div class="list pedido-item" v-for="i in 4">
				<div class="w3-border-bottom header">
					Pedido 1 - <i class="fa fa-check w3-text-green"></i>
					<span class="w3-right"><i class="fa fa-clock" style="font-size:1em"></i> 11:23</span>
				</div>
				<div class="pedido-body">
					<span>- 1/2 Lombinho Catupiry</span><br>
					<span>- 1/2 Frangueto</span><br>
					<span class="pedido-obs">OBS: S/ Cebola, C/ Bacon, C/ Borda Catupiry</span>
				</div>
			</div>
			<div class="list pedido-item">
				<div class="w3-border-bottom header">
					Pedido 2 - <i class="fa fa-utensils w3-text-red"></i>
					<span class="w3-right"><i class="fa fa-clock" style="font-size:1em"></i> 11:23</span>
				</div>
				<div class="pedido-body">
					<span>- 1 Frangueto</span><br>
					<span class="pedido-obs">OBS: S/ Cebola, C/ Bacon, C/ Borda Catupiry</span>
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
	      produtos:4
	    }
	  }
	}
</script>

<style scoped>
	.pedido-body{
		margin-top: 12px
	}

</style>