<template>
	<div class="w3-bottom w3-center">
		<div class="w3-red w3-cell-row">
			<div class="w3-cell col active">
				<div class="w3-button">
					<i class="fa fa-th-list"></i><br>
					<span class="w3-small">COMANDA</span>
				</div>
			</div>
			<div class="w3-cell col">
				<div class="w3-button">
					<i class="fa fa-th"></i><br>
					<span class="w3-small">CARDÁPIO</span>
				</div>
			</div>
			<div class="w3-cell col">
				<div class="w3-button">
					<i class="fa fa-sign-out-alt"></i><br>
					<span class="w3-small">SAIR</span>
				</div>
			</div>
		</div>
	</div>
</template>

<script>
	export default {
		data(){
			return{
				menu: false,
				fa: 'fa-ellipsis-v'
			}
		},
		methods:{
			abrirMenu(){
				this.menu = !this.menu;
			},
			linkar(link){
				this.menu = false;
				router.push(link);
			}
		}
	}
</script>


<style>

i{
	font-size: 1.5em;
}
.col{
	width: 33%!important;
	color: rgba(255,255,255,0.8);
}
.active{	
	font-weight: 900;
	color: #fff;
	border-top: 3px solid #fff;
}
.active > .w3-button > i{
	color: #fff!important;
}
</style>