<template>
	<div>
		<top-bar></top-bar>
		<div class="w3-center w3-display-middle home-container">
			<div class="home-title">
				<span>Login</span>
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
					<div class="login-btn">
						<button type="button" class="w3-button w3-round w3-block w3-red" @click="selComanda">
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
	border: 1px solid rgba(255,255,255,0.5);
	border-radius: 4px;
	padding: 10% 0 15% 0;
	margin-top: 4%;
	background-color: rgba(0,0,0,0.4);
}
.home-input{
	text-align: left;
}
.login-btn{
	margin: 32px 16px 0 16px
}
.home-title{
	margin-bottom: 32px
}
</style>

