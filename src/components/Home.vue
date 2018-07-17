<template>
	<div>
		<top-bar></top-bar>
		<div class="w3-center w3-display-middle home-container">
			<span class="home-title">Le CARD</span><br>
			<div class="home-form">
				<form class="">
					<div class="">
						<label class="home-label">Número da comanda</label>
						<input type="text" class="w3-input home-input" v-model="referencia" placeholder="Exemplo: C02">
						<button type="button" class="w3-button w3-border w3-round home-btn" @click="selComanda" :disabled="referencia == ''">
							<i class="fa fa-search"></i>
							BUSCAR
						</button>
					</div>
					<!-- <div class="home-qr-code">
						<label class="w3-large">Ler QR CODE</label><br>
						<button class="w3-button w3-border w3-round home-btn">
							<i class="fa fa-camera"></i>
							QR CODE
						</button>
					</div> -->
				</form>
			</div>
		</div>
	</div>
</template>

<script>
import TopBar from "./commons/TopBar.vue"
import Container from "./commons/Container.vue"
export default {
	components:{Container,TopBar},
	name: 'Home',
	data () {
		return {
      		referencia: ""
    	}
	},
	methods:{
		selComanda(){
	      if(this.referencia != ""){
	        this.$http.get(base_url + 'admin/api/comanda/ref/' + this.referencia)
				.then(response => {
					if(response.data != ""){
						localStorage.setItem("comanda",response.data);
						this.$router.push("comanda");
					}else{
						alert("Nao encontrado")
					}
				});
	      	}
		}
	}
}
</script>

<style scoped>
.home-container{
	border: 1px solid rgba(255,255,255,0.8);
	border-radius: 4px;
	padding: 10% 0 15% 0;
	margin-top: 4%;
	background-color: rgba(0,0,0,0.5);
}
</style>

