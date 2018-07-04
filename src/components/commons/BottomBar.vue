<template>
	<div>
		<div class="w3-bottom w3-center">
			<div class="w3-red bottom-bar w3-cell-row">
				<router-link class="w3-cell col" to="comanda" activeClass="active">
					<div class="w3-button btn-bar">
						<i class="fa fa-th-list"></i><br>
						<span class="w3-small">COMANDA</span>
					</div>
				</router-link>
				<router-link class="w3-cell col" to="cardapio" activeClass="active">
					<div class="w3-button btn-bar">
						<i class="fa fa-th"></i><br>
						<span class="w3-small">CARDÁPIO</span>
					</div>
				</router-link>
				<router-link class="w3-cell col" to="pedidos" activeClass="active">
					<div class="w3-button btn-bar">
						<i class="fa fa-bell"></i><br>
						<span class="w3-small">PEDIDOS</span>
					</div>
				</router-link>
			</div>
		</div>
		<div class="w3-top w3-hide">
			<div class="w3-right menu">
				<i class="fa fa-ellipsis-v"></i>
			</div>
			<div class="w3-sidebar w3-card w3-bar-block w3-round top-bar-cliente-sidebar" >
			  <router-link :to="'/'" class="w3-bar-item top-bar-link" @click.native="abrirMenu">
			  	SAIR <i class="fa fa-sign-out-alt"></i>
			  </router-link>
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
.bottom-bar{
	box-shadow: 0px -1px 6px -1px rgba(0,0,0,0.75);
}
.btn-bar{
	padding: 4px 0;
}
.col{
	width: 33%!important;
	color: rgba(255,255,255,0.8);
	font-weight: 900;
}
.col > i{
	font-size: 1.2em;
}
.active{
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
	padding: 17px 24px;
}
.menu i {
	color: #fff;
	font-size: 1em
}
.top-bar-cliente-sidebar {
	margin-top: 60px;
	width:40%;
	right:1%;
	height:inherit;
	padding: 6px 8px;
	color: #aaa;
	text-align: center;
}
</style>
