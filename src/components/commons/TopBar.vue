<template>
	<div class="w3-top">
		<div class="w3-bar w3-red top-bar top-bar-home">
			<router-link to="/" class="w3-bar-item w3-button top-bar-title">Le CARD</router-link>
			<button class="w3-bar-item w3-red w3-right top-bar-icon" @click="abrirMenu">
				<i class="fa" :class="fa"></i>
			</button>
		</div>
		<div class="w3-sidebar w3-card w3-bar-block w3-round top-bar-home-sidebar" v-show="menu">
		  <router-link :to="'/login'" class="w3-bar-item top-bar-link" @click.native="abrirMenu">
		  	Garçom
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
.top-bar-home{
	padding: 6px 4px
}
.top-bar-home-title {
	font-weight: bold;
	font-size: 1.5em
}
.top-bar-home-icon {
	margin: 6px 1px;
}
.top-bar-home-sidebar {
	width:40%;
	right:1%;
	height:inherit;
	padding: 6px 8px;
}
.top-bar-home-link {
	font-size: 1em;
	font-weight: bold;
	text-decoration: none;
	border-color: #fff!important;
	padding: 12px!important;
}
.top-bar-home-link:last-child {
	border-color: none;
}
</style>