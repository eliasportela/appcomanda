<template>
  <div>
    <top-bar/>
    <menu-dash/>
    <div class="w3-main" style="margin-left:300px;margin-top:50px;">
      <header class="w3-container" style="padding-top:14px">
        <h6><b>Dashboard</b></h6>
      </header>
      <div class="w3-row-padding w3-margin-bottom">
        <div class="w3-col s6 l3 w3-margin-top">
          <a href="admin/produtor">
            <div class="w3-container w3-red w3-round w3-padding-16 w3-center">
              <i class="fa fa-shopping-basket w3-xxxlarge"></i>
              <div class="w3-clear"></div>
              <h4>Comandas</h4>
            </div>
          </a>
        </div>
        <div class="w3-col s6 l3 w3-margin-top">
          <a href="admin/contatos">
            <div class="w3-container w3-red w3-round w3-padding-16 w3-center">
              <i class="fa fa-edit w3-xxxlarge"></i>
              <div class="w3-clear"></div>
              <h4>Produtos</h4>
            </div>
          </a>
        </div>
        <div class="w3-col s6 l3 w3-margin-top">
          <a href="#">
            <div class="w3-container w3-red w3-round w3-padding-16 w3-center">
              <i class="fa fa-print w3-xxxlarge"></i>
              <div class="w3-clear"></div>
              <h4>Relatórios</h4>
            </div>
          </a>
        </div>
        <div class="w3-col s6 l3 w3-margin-top">
          <a href="#">
            <div class="w3-container w3-red w3-round w3-padding-16 w3-center">
              <i class="fa fa-users w3-xxxlarge"></i>
              <div class="w3-clear"></div>
              <h4>Usuários</h4>
            </div>
          </a>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import TopBar from "../commons/TopBar.vue"
  import MenuDash from "../commons/MenuDash.vue"

  export default {
    components: {TopBar, MenuDash},
    data() {
      return {}
    },
    methods: {
    }
  }
</script>

<style scoped>

</style>
