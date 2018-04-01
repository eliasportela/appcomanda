<template>
	<div>
		<top-bar></top-bar>
		<container style="margin-top:80px">
			<div class="w3-center boas-vindas">
				<div>
					<img src="../assets/logo3.png" class="img-logo">	
				</div>
				<span class="title">Le CARD</span><br>
				</span>
				<div class="form">
					<form class="">
						<div class="">
							<label class="label">Número da comanda</label>
							<input type="text" class="w3-input input" placeholder="Exemplo: ca12">
							<button type="button" class="w3-button w3-border w3-round w3-margin-top btn" @click="selComanda">
								<i class="fa fa-search"></i>
								BUSCAR
							</button>
						</div>
						<div class="qr-code">
							<label class="w3-large">Ler QR CODE</label><br>
							<button class="w3-button w3-border w3-round w3-margin-top btn">
								<i class="fa fa-camera"></i>
								QR CODE
							</button>
						</div>
					</form>	
				</div>
			</div>
		</container>
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
			this.$router.push("comanda-cliente/"+123)
		}
	}
}
</script>

<style scoped>

.boas-vindas{
	font-weight: bold;
}
.title{
	font-size: 2em;
	font-family: sans-serif;
}
.subtitle{
	font-size: 1.1em;
	font-family: sans-serif;
}
.img-logo{
	width: 96px;
	height: 96px;
}
.form{
	margin-top: 10%;
}
.input{
	background-color: rgba(255,255,255,0.0);
	color: #fff;
	text-align: center;
	font-size: 1.2em;
	display: initial;
	width: 80%;
	border-bottom: 2px solid #fff;
	margin-bottom: 5%

}
.qr-code{
	margin-top: 20%
}
.btn {
	width: 80%
}
.label{
	font-size: 1.1em;
}
</style>

