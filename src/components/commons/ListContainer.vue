<template>
  <div class="w3-margin-top container-listas">
    <slot></slot>
  </div>
</template>

<script>

export default {
  name: 'ListContainer'
}
</script>

<style scoped>
  .container-listas{
    max-height: 70vh;
    overflow: auto;
  }
</style>
