<template>
  <div>
    <div class="w3-card w3-margin w3-padding w3-text-white w3-display-container container">
      <slot></slot>
     
    </div>
  </div>
</template>

<script>

export default {
  name: 'ContainerCliente'
}
</script>

<style scoped>
  .container {
    height: 79vh;
    border: 1.5px solid #aaa;
    overflow: auto;
  }
  .container-middle {
    width:90%
  }

</style>
