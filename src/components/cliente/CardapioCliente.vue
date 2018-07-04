<template>
	<div>
		<div class="w3-top top-bar">
			<span><b>CARDÁPIO</b></span>
		</div>
		<div class="container-bottom">
			<div class="title">
				ESCOLHA UMA CATEGORIA
			</div>
			<div class="w3-cell-row list w3-center" v-for="c in categoria" :key="c.id_categoria" @click="toogleCardapio">
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
						<i class="fa fa-times w3-right w3-xlarge" @click="toogleCardapio"></i>
					</div>
				</div>
				<div class="cardapio">
					<div class="w3-center">
						<img src="../../assets/pizzas.jpg" class="cardapio-image">
					</div>
					<hr>
					<div class="w3-cell-row cardapio-item">
						<div class="w3-cell">
							<span class="cardapio-produto">
                <!-- {{ l.ref_produto }} - {{ l.nome_produto }} -->
                </span><br>
							<span class="cardapio-ingredientes">
							  <span>
                  <!-- {{te.}} -->
                </span>
              </span>
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
      resource: this.$resource('http://localhost/comanda/api/item-produto/1'),
			categoria: [],
			cardapio: false,
      listas: [],
		}
	},
	methods:{
    initialize (){
      console.log("tete");
      this.resource.get({}).then((response) => {
          this.listas = response.data
          //this.load = false
          //this.loadlista = true;
        },response => {
          console.log(this.listas);
            //this.load = false;
            //this.loadBad = true;
        });
    },
		toogleCardapio(){
			this.cardapio = !this.cardapio;
		}
	},
  created: function () {
    this.$http.get('http://localhost/comanda/api/categorias/')
      .then(response => {
        this.categoria = response.data;
        console.log(this.categoria)
      });

    this.$http.get('http://localhost/comanda/api/item-produto/2')
      .then(response => {
        this.listas = response.data;
        console.log(this.listas)
      });

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
