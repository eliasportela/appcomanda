<template>
	<div>
		<top-bar></top-bar>
		<div class="w3-center w3-display-middle home-container">
			<div class="home-title">
				<span>Garçom</span>
			</div>
			</span>
			<div class="login-form">
				<form class="">
					<div class="w3-cell-row">
						<div class="w3-cell login-icon">
							<i class="fa fa-user"></i>
						</div>
						<div class="w3-cell">
							<input type="text" class="w3-input home-input" placeholder="Usuário">
						</div>
					</div>
					<div class="w3-cell-row">
						<div class="w3-cell login-icon">
							<i class="fa fa-lock"></i>
						</div>
						<div class="w3-cell">
							<input type="text" class="w3-input home-input" placeholder="Senha">
						</div>
					</div>
					<div>
						<button type="button" class="w3-button w3-round home-btn w3-red" @click="selComanda">
							ENTRAR
						</button>
					</div>
				</form>	
			</div>
		</div>
	</div>
</template>

<script>
import TopBar from "../commons/TopBar.vue"
export default {
	beforeCreate: function() {
		document.body.className = 'login-cliente';
	},
	components:{TopBar},
	name: 'Home',
	data () {
		return {
			msg: 'Welcome to Your Vue.js App'
		}
	},
	methods:{
		selComanda(){
			this.$router.push("comanda-garcom")
		}
	}
}
</script>

<style scoped>
.home-container{
	border: 2px solid #fff;
	border-radius: 4px;
	padding: 10% 0 15% 0;
	margin-top: 4%;
	background-color: rgba(0,0,0,0.7);
}
.home-input{
	text-align: left;
}
.home-btn{
	margin-top: 42px
}
.home-title{
	margin-bottom: 32px
}
</style>

