<template>
	<div>
		<div class="w3-bottom w3-center">
			<div class="w3-red w3-cell-row">
				<router-link class="w3-cell col" to="comanda" activeClass="active">
					<div class="w3-button">
						<i class="fa fa-th-list"></i><br>
						<span class="w3-small">COMANDA</span>
					</div>
				</router-link>
				<router-link class="w3-cell col" to="cardapio" activeClass="active">
					<div class="w3-button">
						<i class="fa fa-th"></i><br>
						<span class="w3-small">CARDÁPIO</span>
					</div>
				</router-link>
				<router-link class="w3-cell col" to="pedidos" activeClass="active">
					<div class="w3-button">
						<i class="fa fa-bell"></i><br>
						<span class="w3-small">PEDIDOS</span>
					</div>
				</router-link>
			</div>
		</div>
		<div class="w3-top">
			<div class="w3-right menu">
				<i class="fa fa-ellipsis-v"></i>	
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
.w3-button:hover{
	background-color: #f44336!important
}
.menu{
	padding: 15px 24px;
}
.menu i {
	color: #aaa;
	font-size: 1.2em
}
</style>