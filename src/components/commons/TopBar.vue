<template>
	<div class="w3-top">
		<div class="w3-bar w3-text-white w3-padding w3-red">
			<router-link to="/" class="w3-bar-item w3-button title">Le CARD</router-link>
			<button class="w3-bar-item w3-red w3-right icon" @click="abrirMenu">
				<i class="fa" :class="fa"></i>
			</button>
		</div>
		<div class="w3-sidebar w3-card w3-bar-block w3-red w3-padding w3-round sidebar" v-show="menu">
		  <router-link :to="'/voluntarios'" class="w3-bar-item w3-button w3-border-bottom w3-padding-16 link" @click.native="abrirMenu">
		  	Garçom
		  </router-link>
		  <router-link :to="'/login'" class="w3-bar-item w3-button w3-padding-16 link" @click.native="abrirMenu">
		  	Login
		  </router-link>
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
.title {
	font-weight: bold;
	font-size: 1.5em
}
.icon {
	margin-top: 0.3em
}
.sidebar {
	width:50%;
	right:1%;
	height:inherit;
}
.link {
	font-size: 1.2em;
	font-weight: bold;
}
</style>