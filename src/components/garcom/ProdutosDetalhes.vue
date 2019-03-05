<template>
  <div>

  </div>
</template>

<script>
  import TopBar from "../commons/TopBar.vue"
  import MenuDash from "../commons/MenuDash.vue"

  export default {
    components: {TopBar, MenuDash},
    data() {
      return {

        dados: {
          id_categoria: 1,
          nome_produto: '',
          gerar_pedido: 1,
          ingrediente: 0,
        }

      }
    },

    methods: {

    },
    mounted() {

    }
  }
</script>

<style scoped>

</style>
