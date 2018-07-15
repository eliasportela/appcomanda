<template>
	<div>
		<div class="w3-top top-bar">
			<span><b>CARDÁPIO</b></span>
		</div>
		<div class="container-bottom">
			<div class="title">
				ESCOLHA UMA CATEGORIA
			</div>
			<div class="w3-cell-row list w3-center" v-for="c in categorias" :key="c.id_categoria" @click="toogleCardapio(c.id_categoria)">
				<div class="w3-cell list-img">
					<img src="../../assets/pizzas.jpg" class="w3-image">
				</div>
				<div class="w3-cell list-text" style="width:33%">
					<span>{{c.nome_categoria}}</span>
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
						<i class="fa fa-times w3-right w3-xlarge" @click="toogleCardapio(false)"></i>
					</div>
				</div>
				<div class="cardapio">
					<div class="w3-center">
						<img src="../../assets/pizzas.jpg" class="cardapio-image">
					</div>
					<hr>
					<div class="w3-cell-row cardapio-item" v-for="p in produtos" v-show="p.valores != ''">
						<div class="w3-cell">
							<span class="cardapio-produto">
                				{{p.ref_produto}} - {{p.nome_produto}}
                			</span><br>
							<span class="cardapio-ingredientes">
								({{p.ingredientes}})
              				</span>
						</div>
						<div class="w3-cell cardapio-preco">
							<div class="w3-red w3-round">
								<div v-for="v in p.valores">
									<span class="info-icon">{{v.nome_tabela.substring(0, 1)}}:</span>
									<span>{{v.valor}}</span>
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
      		categorias: [],
			cardapio: false,
      		produtos: [],
		}
	},
	methods:{
		buscarCategorias(){
			this.$http.get(base_url + 'admin/api/categoria-produtos')
			.then(response => {
				this.categorias = response.data;
			});
		},
		buscarProdutosCategoria(id){
			this.produtos = [];
			console.log(id);
			this.$http.get(base_url + 'admin/api/cardapio/' + id)
			.then(response => {
				this.produtos = response.data;
			});
		},
		toogleCardapio(id){
			this.cardapio = !this.cardapio;
			if (id) {
				this.buscarProdutosCategoria(id);
			}
		},

	},
	created: function () {
	    this.buscarCategorias();
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
