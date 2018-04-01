<template>
  <div>
    <div class="w3-card w3-margin w3-padding w3-text-white w3-display-container container">
      <div class="w3-display-middle container-middle">
        <slot></slot>
      </div>
    </div>
  </div>
</template>

<script>

export default {
  name: 'Container'
}
</script>

<style scoped>
  .container {
    background-color: rgba(0,0,0,0.5);
    height: 85vh;
    border: 1.5px solid white;
    overflow: auto;
  }
  .container-middle {
    width:90%
  }

</style>
