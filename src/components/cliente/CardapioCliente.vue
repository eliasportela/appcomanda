<template>
	<div>
		<div class="w3-top top-bar">
			<span><b>CARDÁPIO</b></span>
		</div>
		<div class="container-bottom">
			<div class="title">
				ESCOLHA UMA CATEGORIA
			</div>
			<div class="w3-cell-row list w3-center" v-for="i in 2" @click="toogleCardapio">
				<div class="w3-cell list-img">
					<img src="../../assets/pizzas.jpg" class="w3-image">
				</div>
				<div class="w3-cell list-text" style="width:33%">
					<span>PIZZAS</span>
				</div>
				<div class="w3-cell list-icon" style="width:33%">
					<i class="fa fa-angle-right"></i>
				</div>
			</div>
		</div>
		<bottom-bar></bottom-bar>
		<div class="w3-modal" :class="{'show':cardapio}">
			<div class="w3-modal-content w3-animate-opacity">
				<div class="w3-container w3-top cardapio-top">
					<div class="w3-text-white w3-padding-16 title-modal">
						<span class="w3-large"> 
							<b>PIZZAS</b>
						</span>
						<i class="fa fa-times w3-right w3-xlarge" @click="toogleCardapio"></i>
					</div>
				</div>
				<div class="cardapio">
					<div class="w3-center">
						<img src="../../assets/pizzas.jpg" class="cardapio-image">
					</div>
					<hr>
					<div class="w3-cell-row cardapio-item" v-for="iten in 12">
						<div class="w3-cell">
							<span class="cardapio-produto">01 - Lombinho com Catupiry</span><br>
							<span class="cardapio-ingredientes">(Lombinho, mussarela, catupiry, molho de tomate)</span>
						</div>
						<div class="w3-cell cardapio-preco">
							<div class="w3-red w3-round">
								<div class="">
									<span class="info-icon">E</span>
									<span>54,99</span>
								</div>
								<div class="">
									<span class="info-icon">B</span>
									<span>54,99</span>
								</div>
								<div class="">
									<span class="info-icon">G</span>
									<span>54,99</span>
								</div>
							</div>
						</div>
					</div>
					<hr>
					<div class="w3-red w3-round w3-center">
						<span class="info-icon">E</span>: ESFIHA -
						<span class="info-icon">B</span>: BROTO -
						<span class="info-icon">G</span>: GRANDE
					</div>
					<div class="w3-red w3-round info-list">
						<ul class="w3-ul">
							<li>
								<i class="fa fa-asterisk w3-small info-icon"></i>
								Pizzas 1/2 a 1/2 será cobrado pelo valor maior
							</li>
							<li>
								<i class="fa fa-asterisk w3-small info-icon"></i> 
								Todas as pizzas levam molho de tomate e azeitonas
							</li>
						</ul>
					</div>
				</div>

			</div>
		</div>
	</div>
</template>

<script>
import BottomBar from "../commons/BottomBar.vue"
export default {
	beforeCreate: function() {
		document.body.className = 'cliente';
	},
	components:{BottomBar},
	data(){
		return{
			categoria: '',
			cardapio: false
		}
	},
	methods:{
		toogleCardapio(){
			this.cardapio = !this.cardapio;
		}
	}
}
</script>

<style scoped>
.w3-modal-content{
	background-image: url("../../assets/cardapio.jpg");
}
.cardapio-top{
	background-image: url("../../assets/cardapio.jpg");
    background-repeat: no-repeat;
}

</style>