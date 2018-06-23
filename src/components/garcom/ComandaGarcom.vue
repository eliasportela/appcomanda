<template>
	<div>
		<top-bar></top-bar>
		<div class="container-bottom">
			<div class="title">
				<span>COMANDAS ABERTAS</span>
			</div>
			<div class="w3-cell-row w3-padding-16 list" v-for="item in 10">
				<div class="w3-cell">
					<div class="comanda-produto">
						MESA 1
					</div>
					<div class="obs-comanda">
						Obs: Elias Portela
					</div>
				</div>
				<div class="w3-cell list-icon">
					REF<br>C0121
				</div>
			</div>
		</div>
		<div class="w3-bottom w3-white">
			<div class="w3-margin">
				<button class="w3-button w3-round w3-red w3-block btn-garcom" @click="toogleComanda">
					NOVA COMANDA
				</button>	
			</div>
		</div>
		<div class="w3-modal" :class="{'show':modalComanda}">
			<div class="w3-modal-content w3-animate-opacity">
				<div class="w3-top top-bar">
					<span @click="toogleComanda">
						<i class="fa fa-chevron-left"></i>
						Voltar
					</span>
				</div>
				<div class="title-garcom">
					<span>Selecione o número da mesa</span>
				</div>
				<div class="comanda-garcom">
					<div class="w3-border w3-padding comanda-input-mesa">
						<span>Mesa:</span>
						<span>12</span>
					</div>
					<div class="w3-container">
						<div class="w3-cell-row w3-center comanda-btn" >
							<div class="w3-cell">
								<button class="w3-button w3-round w3-border comanda-btn-numero">1</button>
							</div>
							<div class="w3-cell">
								<button class="w3-button w3-round w3-border comanda-btn-numero">2</button>
							</div>
							<div class="w3-cell">
								<button class="w3-button w3-round w3-border comanda-btn-numero">3</button>
							</div>
						</div>
						<div class="w3-cell-row w3-center comanda-btn" >
							<div class="w3-cell">
								<button class="w3-button w3-round w3-border comanda-btn-numero">4</button>
							</div>
							<div class="w3-cell">
								<button class="w3-button w3-round w3-border comanda-btn-numero">5</button>
							</div>
							<div class="w3-cell">
								<button class="w3-button w3-round w3-border comanda-btn-numero">6</button>
							</div>
						</div>
						<div class="w3-cell-row w3-center comanda-btn" >
							<div class="w3-cell">
								<button class="w3-button w3-round w3-border comanda-btn-numero">7</button>
							</div>
							<div class="w3-cell">
								<button class="w3-button w3-round w3-border comanda-btn-numero">8</button>
							</div>
							<div class="w3-cell">
								<button class="w3-button w3-round w3-border comanda-btn-numero">9</button>
							</div>
						</div>
						<div class="w3-cell-row w3-center comanda-btn" >
							<div class="w3-cell">
								<button class="w3-button w3-round w3-border comanda-btn-numero">
									<i class="fa fa-eraser"></i>
								</button>
							</div>
							<div class="w3-cell">
								<button class="w3-button w3-round w3-border comanda-btn-numero">0</button>
							</div>
							<div class="w3-cell">
								<button class="w3-button w3-round w3-border comanda-btn-numero">
									<i class="fa fa-arrow-left"></i>
								</button>
							</div>
						</div>
					</div>
					<div class="w3-margin comanda-add-obs">
						<label>Observações</label>
						<textarea class="w3-input w3-text w3-border" placeholder="Observações da comanda">
						</textarea>
					</div>
				</div>
				<div class="w3-bottom w3-white garcom-container-btn">
					<div class="w3-margin">
						<button class="w3-button w3-round w3-red w3-block btn-garcom" @click="novaComanda">
							CONFIRMAR
						</button>	
					</div>
				</div>
			</div>
		</div>
	</div>
</template>

<script>

import TopBar from "../commons/TopBar.vue"
import ModalProduto from "../commons/Modal.vue"
	export default {
		beforeCreate: function() {
			document.body.className = 'cliente';
		},
		components:{TopBar,ModalProduto},
		data(){
		    return{
		      produtos:'',
		      modalComanda: false
		    }
		},
	    methods:{
	    	toogleComanda(){
	    		this.modalComanda = !this.modalComanda;
	    	},
	    	novaComanda(){
	    		this.$router.push("comanda-mesa")
	    	}
	    }
	}
</script>

<style scoped>
.list-icon{
	width: 25%;
	text-align: center;
}
.comanda-btn{
	margin-top: 12px	
}
.comanda-btn-numero{
	width: 90%;
	height: 50px
}
.comanda-input-mesa{
	margin: 0 20px;
	color: #aaa;
	font-weight: 900
}
.comanda-add-obs{

}
.w3-text{
	resize: none;
}
.garcom-bottom{
	margin: 16px
}
.w3-modal-content{
	height: 110%
}

.w3-text:focus + div{
    background-color: red
}

</style>