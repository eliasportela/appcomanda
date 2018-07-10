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
			<div class="w3-cell-row list" v-for="p in produtosComanda">
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
			<button class="w3-button w3-round w3-block w3-red btn-garcom" @click="toogleModalInsercao">
				ADICIONAR
			</button>
		</div>

		<div class="w3-modal" :class="{'show':modalComanda}">
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

		<div class="w3-modal" :class="{'show':modalInsercao}">
			<div class="w3-modal-content w3-animate-opacity">
				<top-bar></top-bar>
				<div class="title-garcom">
					SELECIONE O TIPO DO PRODUTO
				</div>
				<div class="container-garcom garcom-tipo-produto">
					<div class="w3-cell-row comanda-tipo" v-for="c in categorias" @click="selCategoria(c.id_categoria,c.pizza)">
						<div class="w3-cell list-text">
							{{c.nome_categoria}}
						</div>
						<div class="w3-cell list-icon">
							<i class="fa fa-check" v-show="categoriaSelecionada == c.id_categoria"></i>
						</div>
					</div>
				</div>
				<div class="garcom-tipo-container w3-margin-top" v-show="showPizza">	
					<hr class="garcom-hr">
					<div class="w3-cell-row">
						<div class="w3-cell cell-garcom-tipo">
							<button class="w3-button w3-border btn-garcom-tipo" @click="selTipoPizza(1)">
								<i :class="[tipoPizza == 1 ? 'fas fa-check-circle' : 'far fa-circle']"></i><br>
								1/2
							</button>
						</div>
						<div class="w3-cell cell-garcom-tipo">
							<button class="w3-button w3-border w3-round btn-garcom-tipo" @click="selTipoPizza(2)">
								<i :class="[tipoPizza == 2 ? 'fas fa-check-circle' : 'far fa-circle']"></i><br>
								INTEIRA
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="w3-modal" :class="{'show':modalProduto}">
			<div class="w3-modal-content">
				<top-bar></top-bar>
				<div class="title-garcom">
					<div class="w3-cell-row">
						<div class="w3-cell" style="width:50%;padding-right:4px">
							<button class="w3-button w3-border w3-block">
								<i class="fa fa-chevron-left"></i>
								Voltar
							</button>
						</div>
						<div class="w3-cell" style="width:50%;padding-left:4px">
							<button class="w3-button w3-border w3-block" @click="avancarModal(0)">
								<i class="fa fa-times"></i>
								Cancelar
							</button>
						</div>
					</div>
				</div>
				<div class="container-garcom">
					<div class="w3-cell-row comanda-tipo" v-for="p in produtos" @click="selProduto(p.id_produto, p.id_tabela)">
						<div class="w3-cell list-text">
							{{p.ref_produto}} - ({{p.nome_tabela}}) {{p.nome_produto}}
						</div>
						<div class="w3-cell list-icon">
							<i class="fa fa-check" v-show="(produtoSelecionado == p.id_produto) && (tabelaSelecionada == p.id_tabela)"></i>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="w3-modal" :class="{'show':modalAdicionais}">
			<div class="w3-modal-content">
				<top-bar></top-bar>
				<div class="title-garcom">
					<div class="w3-cell-row">
						<div class="w3-cell" style="width:50%;padding-right:4px">
							<button class="w3-button w3-border w3-block" @click="avancarModal(6)">
								<i class="fa fa-chevron-left"></i>
								Voltar
							</button>
						</div>
						<div class="w3-cell" style="width:50%;padding-left:4px">
							<button class="w3-button w3-border w3-block" @click="avancarModal(0)">
								<i class="fa fa-times"></i>
								Cancelar
							</button>
						</div>
					</div>
				</div>
				<div class="container-garcom">
					<div class="w3-cell-row comanda-tipo" v-for="a in adicionais" @click="selAdicionais(a.id_produto)">
						<div class="w3-cell list-text">
							{{a.nome_produto}}
						</div>
						<div class="w3-cell list-icon">
							<i class="fa fa-check" v-show="adicionaisSelecionados.includes(a.id_produto)"></i>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="w3-modal" :class="{'show':modalRemocoes}">
			<div class="w3-modal-content">
				<top-bar></top-bar>
				<div class="title-garcom">
					<div class="w3-cell-row">
						<div class="w3-cell" style="width:50%;padding-right:4px">
							<button class="w3-button w3-border w3-block" @click="avancarModal(6)">
								<i class="fa fa-chevron-left"></i>
								Voltar
							</button>
						</div>
						<div class="w3-cell" style="width:50%;padding-left:4px">
							<button class="w3-button w3-border w3-block" @click="avancarModal(0)">
								<i class="fa fa-times"></i>
								Cancelar
							</button>
						</div>
					</div>
				</div>
				<div class="container-garcom">
					<div class="w3-cell-row comanda-tipo" v-for="i in itens" @click="selAdicionais(a.id_produto)">
						<div class="w3-cell list-text">
							{{i.nome_produto}}
						</div>
						<div class="w3-cell list-icon">
							<i class="fa fa-check" v-show=""></i>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="w3-modal" :class="{'show':modalObservacoes}">
			<div class="w3-modal-content">
				<top-bar></top-bar>
				<div class="title-garcom">
					<div class="w3-cell-row">
						<div class="w3-cell" style="width:50%;padding-right:4px">
							<button class="w3-button w3-border w3-block" @click="avancarModal(6)">
								<i class="fa fa-chevron-left"></i>
								Voltar
							</button>
						</div>
						<div class="w3-cell" style="width:50%;padding-left:4px">
							<button class="w3-button w3-border w3-block" @click="avancarModal(0)">
								<i class="fa fa-times"></i>
								Cancelar
							</button>
						</div>
					</div>
				</div>
				<div class="container-garcom">
					<textarea class="w3-input w3-border" rows="10"></textarea>
				</div>
			</div>
		</div>

		<div class="w3-modal" :class="{'show':modalFinalizar}">
			<div class="w3-modal-content">
				<top-bar></top-bar>
				<div class="title-garcom">
					<div class="w3-cell-row">
						<div class="w3-cell" style="width:50%;padding-right:4px">
							<button class="w3-button w3-border w3-block">
								<i class="fa fa-chevron-left"></i>
								Voltar
							</button>
						</div>
						<div class="w3-cell" style="width:50%;padding-left:4px">
							<button class="w3-button w3-border w3-block" @click="avancarModal(0)">
								<i class="fa fa-times"></i>
								Cancelar
							</button>
						</div>
					</div>
				</div>
				<hr>
				<div class="w3-container">
					Informe a Quantidade
					<div class="w3-cell-row">
						<div class="w3-cel w3-margin-right">
							<input type="number" class="w3-input w3-border" placeholder="Quantidade" v-model="quantidade">
						</div>
						<div class="w3-cell" style="width:15%">
							<button class="w3-button w3-red" @click="minusQtd()">
								<i class="fa fa-minus"></i>
							</button>
						</div>
						<div class="w3-cell" style="width:15%">
							<button class="w3-button w3-red" @click="plusQtd()">
								<i class="fa fa-plus"></i>
							</button>
						</div>
					</div>
					<hr>
					<button class="w3-button w3-red w3-block w3-margin-top" style="padding:12px" @click="avancarModal(3)">
						Adicionais
					</button>
					<button class="w3-button w3-red w3-block w3-margin-top" style="padding:12px" @click="avancarModal(4)">
						Remoções
					</button>
					<button class="w3-button w3-red w3-block w3-margin-top" style="padding:12px" @click="avancarModal(5)">
						Observações
					</button>
					<button class="w3-button w3-red w3-block w3-margin-top" style="padding:12px" @click="avancarModal(0)">
						Finalizar
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
		url: 'http://localhost/',
		modalComanda:false,
		modalInsercao:false,
		modalProduto:false,
		modalAdicionais:false,
		modalFinalizar:false,
		modalRemocoes:false,
		modalObservacoes:false,
		comanda:"",

		produtosComanda:[],
		categorias: [],
		produtos:[],
		itens:[],
		tabelas:[],
		adicionais:[],

		categoriaSelecionada:0,
		produtoSelecionado:0,
		tabelaSelecionada:0,
		adicionaisSelecionados:[],
		tipoPizza:0,
		quantidade:1,
		showPizza: false,
	}
},
methods:{
	buscarProdutos(id){
		this.$http.get(this.url + 'comanda-server/admin/api/comanda-prudutos/' + id)
		.then(response => {
			this.produtosComanda = response.data;
		});
	},
	buscarTabelas(id){
		this.$http.get(this.url + 'comanda-server/admin/api/tabela-categoria/' + id)
		.then(response => {
			this.tabelas = response.data;
		});
	},
	buscarProdutosByCategoriaTabela(id){
		this.$http.get(this.url + 'comanda-server/admin/api/produtos-categoria-tabela/' + id)
		.then(response => {
			this.produtos = response.data;
		});
	},
	buscarProdutosByCategoria(id){
		this.$http.get(this.url + 'comanda-server/admin/api/produtos-categoria/' + id)
		.then(response => {
			this.adicionais = response.data;
		});
	},
	buscarItens(id){
		this.$http.get(this.url + 'comanda-server/admin/api/produto/id/' + id)
		.then(response => {
			this.itens = response.data.itens;
		});
	},
	selAdicionais(id){
		if (!this.adicionaisSelecionados.includes(id)) {
			this.adicionaisSelecionados.push(id);
		}else{
			var index = this.adicionaisSelecionados.indexOf(id);
			if (index !== -1) this.adicionaisSelecionados.splice(index, 1);
		}
		console.log(this.adicionaisSelecionados);	
	},
	toogleModalInsercao(){
		this.modalInsercao = !this.modalInsercao
	},
	selCategoria(id,tipo){
		this.categoriaSelecionada = id;

		this.buscarTabelas(this.categoriaSelecionada);
		if (tipo == 1) {
			this.showPizza = true;
		}
	},
	selTipoPizza(id){
		this.tipoPizza = id;
		this.avancarModal(2);
	},
	selProduto(id,tabela){
		this.produtoSelecionado = id;
		this.tabelaSelecionada = tabela;
		this.avancarModal(6);
		console.log(id);
		
	},
	plusQtd(){
		this.quantidade++;
	},
	minusQtd(){
		if (this.quantidade > 1) {
			this.quantidade--;
		}
	},
	avancarModal(modal){
		if (modal == 0) {
			//tela incial
			this.modalInsercao = false;
			this.modalProduto = false;
			this.modalAdicionais = false;
			this.modalRemocoes = false;
			this.modalObservacoes = false;
			this.modalFinalizar = false;
			//modal de Insercao
		} else if (modal == 1) {
			this.modalInsercao = true;
			this.modalProduto = false;
			this.modalAdicionais = false;
			this.modalRemocoes = false;
			this.modalObservacoes = false;
			this.modalFinalizar = false;
		} else if (modal == 2){
			//modal de Produtos
			this.buscarProdutosByCategoriaTabela(this.categoriaSelecionada);
			this.modalInsercao = false;
			this.modalProduto = true;
			this.modalAdicionais = false;
			this.modalRemocoes = false;
			this.modalObservacoes = false;
			this.modalFinalizar = false;
		} else if (modal == 3){
			//modal de Adcionais
			this.buscarProdutosByCategoria(1);
			this.modalInsercao = false;
			this.modalProduto = false;
			this.modalAdicionais = true;
			this.modalRemocoes = false;
			this.modalObservacoes = false;
			this.modalFinalizar = false;
		} else if (modal == 4){
			//modal de Remocao
			this.buscarItens(this.produtoSelecionado);
			this.modalInsercao = false;
			this.modalProduto = false;
			this.modalAdicionais = false;
			this.modalRemocoes = true;
			this.modalObservacoes = false;
			this.modalFinalizar = false;
		} else if (modal == 5){
			//modal de Observacoes
			this.modalInsercao = false;
			this.modalProduto = false;
			this.modalAdicionais = false;
			this.modalRemocoes = false;
			this.modalObservacoes = true;
			this.modalFinalizar = false;
		} else if (modal == 6){
			//modal Finalizar
			this.modalInsercao = false;
			this.modalProduto = false;
			this.modalAdicionais = false;
			this.modalRemocoes = false;
			this.modalObservacoes = false;
			this.modalFinalizar = true;
		}
	}

},
created: function () {

	//getComanda
	this.$http.get(this.url + 'comanda-server/admin/api/comanda/id/' + this.$route.params.id)
	.then(response => {
		this.comanda = response.data;
		this.buscarProdutos(this.comanda.id_comanda);
	});

	//getCategoria
	this.$http.get(this.url + 'comanda-server/admin/api/categoria-produtos')
	.then(response => {
		this.categorias = response.data;
	});
	}

}
</script>

<style scoped>
.list-icon{
	width: 20%;
	text-align: center;
}
.w3-button:hover{
	background-color: #fff!important;
	color: #000!important;
}

</style>