<template>
	<div>
		<top-bar></top-bar>
		<div class="w3-center w3-display-middle home-container">
			<div class="home-img-container">
				<img src="../assets/logo3.png" class="home-img">
			</div>
			<span class="home-title">Le CARD</span><br>
			</span>
			<div class="home-form">
				<form class="">
					<div class="">
						<label class="home-label">Número da comanda</label>
						<input type="text" class="w3-input home-input" placeholder="Exemplo: ca12">
						<button type="button" class="w3-button w3-border w3-round home-btn" @click="selComanda">
							<i class="fa fa-search"></i>
							BUSCAR
						</button>
					</div>
					<div class="home-qr-code">
						<label class="w3-large">Ler QR CODE</label><br>
						<button class="w3-button w3-border w3-round home-btn">
							<i class="fa fa-camera"></i>
							QR CODE
						</button>
					</div>
				</form>	
			</div>
		</div>
	</div>
</template>

<script>
import TopBar from "./commons/TopBar.vue"
import Container from "./commons/Container.vue"
export default {
	beforeCreate: function() {
		document.body.className = 'login-cliente';
	},
	components:{Container,TopBar},
	name: 'Home',
	data () {
		return {
			msg: 'Welcome to Your Vue.js App'
		}
	},
	methods:{
		selComanda(){
			this.$router.push("comanda")
		}
	}
}
</script>

<style scoped>
</style>

