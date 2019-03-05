<template>
	<div class="w3-top" style="z-index: 2">
		<div class="w3-bar w3-red top-bar top-bar-home">
			<router-link to="/" class="w3-bar-item w3-button top-bar-title" v-show="!voltar">Le CARD</router-link>
			<router-link :to="'/' + voltar" class="w3-bar-item w3-button top-bar-title" v-show="voltar"><i class="fa fa-chevron-left"></i> Voltar</router-link>
			<button class="w3-bar-item w3-red w3-right top-bar-icon" @click="abrirMenu">
				<i class="fa" :class="fa"></i>
			</button>
		</div>
		<div class="w3-sidebar w3-card w3-round w3-red top-bar-home-sidebar" v-show="menu" style="width: 120px">
		  <div id="sair" class="w3-bar-item top-bar-link" v-on="{click: logoff, blur: abrirMenu}" tabindex="1">
		  	Sair
		  </div>
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
				fa: 'fa-ellipsis-v',
        btnLogoff: false
			}
		},
		methods:{
			abrirMenu(){
				if (!this.menu) {
          setTimeout(() => {
            document.getElementById("sair").focus();
          },500);
        }
        this.menu = !this.menu;
			},
      logoff(){
        localStorage.clear();
        this.$router.push("login");
      },
			linkar(link){
				this.menu = false;
				router.push(link);
			}
		},
    mounted(){
		  if (localStorage.getItem("key") !== null){
        //this.btnLogoff = true;
        //console.log(this.btnLogoff);
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
  top: 52px;
	height:inherit;
	padding: 6px 8px;
}
</style>
