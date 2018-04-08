<template>
	<div>
	<div class="w3-modal show">
		<div class="w3-modal-content w3-animate-opacity">
			<div class="w3-container">
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
.w3-modal{
	padding: 0;
}
.w3-modal-content{
	height: 100%;
	width: 100%!important;
	margin: 0;
}
.show{
	display: block;
}
.w3-container{
	margin-bottom: -3%;
	color: #aaa;
	font-weight: 900!important;
	font-size: 1.4em;
	padding: 4% 8% 2% 8%;
	color: #fff;
}
.w3-container h4{
	padding: 0;
	margin: 0
}
.w3-container i{
	font-size: 1.1em
}
.container{
	background-color: rgba(0,0,0,0.2);
	border-color: #fff!important;
}
</style>