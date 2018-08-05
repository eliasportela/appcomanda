<template>
	<div class="w3-top">
		<div class="w3-bar w3-red top-bar top-bar-home">
			<router-link to="/" class="w3-bar-item w3-button top-bar-title" v-show="!voltar">Le CARD</router-link>
			<router-link :to="'/' + voltar" class="w3-bar-item w3-button top-bar-title" v-show="voltar"><i class="fa fa-chevron-left"></i> Voltar</router-link>
			<button class="w3-bar-item w3-red w3-right top-bar-icon" @click="abrirMenu">
				<i class="fa" :class="fa"></i>
			</button>
		</div>
		<div class="w3-sidebar w3-card w3-round w3-red top-bar-home-sidebar" v-show="menu">
		  <router-link :to="'/login'" class="w3-bar-item top-bar-link" @click.native="abrirMenu">
		  	Garçom
		  </router-link>
		</div>
	</div>
</template>

<script>
	export default {
		props: {
			voltar: String
		},
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
.top-bar-home{
	padding: 6px 4px;
  margin-bottom: 20px;
}
.top-bar-home-sidebar {
	width:40%;
	right:1%;
  top: 5px;
	height:inherit;
	padding: 6px 8px;
}
</style>
