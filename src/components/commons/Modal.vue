<template>
	<div>
	<div class="w3-modal">
		<div class="w3-modal-content w3-animate-opacity">
			<div class="w3-container modal-voltar">
				<h4><i class="fa fa-chevron-left"></i> Voltar</h4>
			</div>
			<container>
				<slot></slot>
			</container>
			<bottom-bar></bottom-bar>
		</div>
	</div>

	</div>
</template>
<script>

import Container from './ContainerCliente.vue'
import BottomBar from './BottomBar.vue'

export default {
	components:{Container,BottomBar},
	data(){
		return{
			show:true		
		}
	}
}
</script>
<style>

</style>