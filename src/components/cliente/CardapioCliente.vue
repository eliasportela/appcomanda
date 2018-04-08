<template>
	<div>
		<div class="w3-container title-client">
			<span>CARDÁPIO</span>
		</div>
		<container>
			<div class="w3-display-middle" style="width:90%">
				<div class="w3-center title">Escolha uma categoria</div>
				<div class="w3-cell-row list w3-center">
					<div class="w3-cell list-img">
						<img src="../../assets/pizzas.jpg" class="w3-image">
					</div>
					<div class="w3-cell list-text">
						<span>PIZZAS</span>
					</div>
					<div class="w3-cell list-icon">
						<i class="fa fa-angle-right"></i>
					</div>
				</div>
			</div>
		</container>
		<bottom-bar></bottom-bar>
		<div class="w3-modal ">
			<div class="w3-modal-content w3-animate-opacity">
				<div class="w3-container w3-text-white w3-padding-16 title-modal">
					<span class="w3-large"> 
						<b>PIZZAS</b>
					</span>
					<i class="fa fa-times w3-right w3-xlarge"></i>
				</div>
				<div class="cardapio">
					<div class="w3-center">
						<img src="../../assets/pizzas.jpg" class="cardapio-image">
					</div>
					<hr>
					<div class="container-cardapio">
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
	</div>
</template>

<script>
import BottomBar from "../commons/BottomBar.vue"
	export default {
		beforeCreate: function() {
			document.body.className = 'cliente';
		},
		components:{BottomBar},
	}
</script>

<style scoped>
	.w3-modal-content{
		background-image: url("../../assets/cardapio.jpg");
		overflow: hidden;
	}
</style>