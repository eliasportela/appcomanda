<template>
	<div>
		<top-bar></top-bar>
		<div class="title-garcom mesa-title">
			<div class="w3-cell-row">
			<div class="w3-cell w3-cell-middle">
				<div>
					<span>COMANDA: {{comanda.ref_comanda}}</span>	
				</div>
				<div>
					<span>OBS: {{comanda.observacao}}</span>	
				</div>	
			</div>
			<div class="w3-cell w3-center w3-cell-middle">
				<i class="fa fa-edit fa-2x"></i><br>
				<span class="w3-small">EDITAR</span>
			</div>
			</div>
		</div>
		<div class="container-garcom">
			<div class="w3-cell-row list" v-for="p in produtos">
				<div class="w3-cell">
					<div class="comanda-produto"> 
						<span>{{p.nome_produto}}</span>
					</div>
					<div class="obs-comanda">
						<span><b>QTD:</b> {{p.quantidade}}</span>
					</div>
				</div>
				<div class="w3-cell list-icon">
					<i class="fa fa-chevron-right"></i><br>
					<span class="w3-small">EDITAR</span>
				</div>
			</div>
		</div>
		<div class="w3-bottom container-btn-garcom">
			<button class="w3-button w3-round w3-block w3-red btn-garcom">
				ADICIONAR
			</button>
		</div>

		<div class="w3-modal">
			<div class="w3-modal-content w3-animate-opacity">
				<top-bar></top-bar>
				<div class="title-garcom">
					<button class="w3-button w3-round w3-block w3-red">
						<i class="fa fa-trash"></i>
						DELETAR ITEM
					</button>
				</div>
				<div class="container-garcom garcom-produto">
					<div class="w3-center w3-border-bottom w3-padding">
						PRODUTO
					</div>
					<ul class="w3-ul comanda-ul">
						<li>1/2 - Pizza Lombo Catupiry</li>
						<li>1/2 - Pizza Lombo Catupiry</li>
					</ul>
					<div class="w3-margin-top w3-center w3-border-bottom w3-padding">
						ADICIONAIS E OBSERVAÇÕES
					</div>
					<ul class="w3-ul comanda-ul">
						<li>- S/ Cebola</li>
						<li>- C/ Bacon</li>
						<li>- C/ Borda Catupiry</li>
					</ul>
				</div>
				<div class="w3-bottom container-btn-garcom w3-center">
					<button class="w3-button w3-round w3-red btn-garcom" style="width:49%">
						<i class="fa fa-chevron-left"></i>
						VOLTAR
					</button>
					<button class="w3-button w3-round w3-red btn-garcom" style="width:49%">
						<i class="fa fa-edit"></i>
						EDITAR
					</button>
				</div>
			</div>
		</div>

		<div class="w3-modal show">
			<div class="w3-modal-content w3-animate-opacity">
				<top-bar></top-bar>
				<div class="title-garcom">
					SELECIONE O TIPO DO PRODUTO
				</div>
				<div class="container-garcom garcom-tipo-produto">
					<div class="w3-cell-row comanda-tipo" v-for="i in 3">
						<div class="w3-cell list-text">
							Pizzas
						</div>
						<div class="w3-cell list-icon">
							<i class="fa fa-check"></i>
						</div>
					</div>
				</div>
				<div class="garcom-tipo-container w3-margin-top">	
					<div class="w3-cell-row">
						<div class="w3-cell cell-garcom-tipo">
							<button class="w3-button w3-border btn-garcom-tipo">
								<i class="far fa-circle"></i><br>
								ESFIHA
							</button>
						</div>
						<div class="w3-cell cell-garcom-tipo">
							<button class="w3-button w3-border btn-garcom-tipo">
								<i class="far fa-circle"></i><br>
								BROTO
							</button>
						</div>
						<div class="w3-cell cell-garcom-tipo">
							<button class="w3-button w3-border w3-round btn-garcom-tipo">
								<i class="far fa-circle"></i><br>
								GRANDE
							</button>
						</div>
					</div>
					<hr class="garcom-hr">
					<div class="w3-cell-row">
						<div class="w3-cell cell-garcom-tipo">
							<button class="w3-button w3-border btn-garcom-tipo">
								<i class="far fa-circle"></i><br>
								1/3
							</button>
						</div>
						<div class="w3-cell cell-garcom-tipo">
							<button class="w3-button w3-border btn-garcom-tipo">
								<i class="far fa-circle"></i><br>
								1/2
							</button>
						</div>
						<div class="w3-cell cell-garcom-tipo">
							<button class="w3-button w3-border w3-round btn-garcom-tipo">
								<i class="far fa-circle"></i><br>
								INTEIRA
							</button>
						</div>
					</div>
				</div>
				<div class="w3-bottom container-btn-garcom">
					<button class="w3-button w3-round w3-red w3-block btn-garcom">
						PRÓXIMO
						<i class="fa fa-chevron-right"></i>
					</button>
				</div>
			</div>
		</div>

	</div>
</template>

<script>

import TopBar from "../commons/TopBar.vue"
//import ModalProduto from "../commons/Modal.vue"
	export default {
		beforeCreate: function() {
			document.body.className = 'cliente';
		},
		components:{TopBar/*,ModalProduto*/},
		data(){
		    return{
		      comanda:"",
		      produtos:[]
		    }
	  },
	  methods:{
	  	buscarProdutos(id){
	  		this.$http.get('http://localhost/comanda-server/admin/api/comanda-prudutos/' + id)
		      .then(response => {
		        this.produtos = response.data;
		      });
	  	}
	  },
	  created: function () {
	        this.$http.get('http://localhost/comanda-server/admin/api/comanda/id/' + this.$route.params.id)
		      .then(response => {
		        this.comanda = response.data;
		        this.buscarProdutos(this.comanda.id_comanda);
		      });
      }
	}
</script>

<style scoped>
.list-icon{
	width: 20%;
	text-align: center;
}

</style>