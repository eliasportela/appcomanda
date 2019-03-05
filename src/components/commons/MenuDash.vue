<template>
  <div>
    <nav class="w3-sidebar w3-collapse w3-white" style="z-index:1;width:300px;" id="mySidebar"><br>
      <div class="w3-container w3-center">
        <span><i class="fa fa-user fa-2x"></i> <strong>Elias Portela</strong></span><br>
      </div>
      <hr>
      <div class="w3-container">
        <h5>Dashboard</h5>
      </div>
      <div class="w3-bar-block">
        <router-link to="dashboard" class="w3-bar-item w3-button row-menu" active-class="w3-red"><i class="fa fa-home fa-fw"></i>  Home</router-link>
        <router-link to="/produtos" class="w3-bar-item w3-button row-menu" active-class="w3-red"><i class="fa fa-edit fa-fw"></i>  Produtos</router-link>
        <router-link to="/comanda-garcom" class="w3-bar-item w3-button row-menu" active-class="w3-red"><i class="fa fa-shopping-basket fa-fw"></i>  Comandas</router-link>
        <router-link to="/pedidos" class="w3-bar-item w3-button row-menu" active-class="w3-red"><i class="fas fa-tasks fa-fw"></i>  Cozinha</router-link>
        <router-link to="a" class="w3-bar-item w3-button row-menu" active-class="w3-red"><i class="fa fa-print fa-fw"></i>  Relatórios</router-link>
        <router-link to="a" class="w3-bar-item w3-button row-menu" active-class="w3-red"><i class="fa fa-users fa-fw"></i>  Usuários</router-link>
        <router-link to="a" class="w3-bar-item w3-button row-menu" active-class="w3-red"><i class="fa fa-cog fa-fw"></i>  Configurações</router-link><br><br>
      </div>
    </nav>
    <div class="w3-overlay w3-hide-large w3-animate-opacity" onclick="w3_close()" style="cursor:pointer" title="close side menu" id="myOverlay"></div>
  </div>
</template>

<script>
    export default {
        name: "MenuDash"
    }
</script>

<style scoped>
  .row-menu{
    padding: 12px 8px!important
  }
</style>
