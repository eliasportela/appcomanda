<template>
	<div>
		<div class="w3-container">
			<span>COMANDA: CA404</span>
			<i class="fa fa-qrcode w3-right"></i>
		</div>
		<container class="w3-white">
			<h5>Teste</h5>
		</container>
		<bottom-bar></bottom-bar>
	</div>
</template>

<script>
import BottomBar from "./commons/BottomBar.vue"
import Container from '../components/commons/ContainerCliente.vue'
	export default {
		beforeCreate: function() {
			document.body.className = 'cliente';
		},
		components:{Container, BottomBar},
	}
</script>

<style scoped>

	body{
		background-color: red!important
	}
	.w3-container{
		margin-top: 1%;
		margin-bottom: -3%;
		color: #aaa;
		font-weight: 900!important;
		font-size: 1.5em;
		padding: 2% 8%
	}
	.w3-container > span {
		font-size: 0.9em;
	}

</style>