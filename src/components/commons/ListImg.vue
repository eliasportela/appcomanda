<template>
  <div class="w3-cell list-img">
    <slot></slot>
  </div>
</template>

<script>

export default {
  name: 'ListText'
}
</script>

<style scoped>
  .list-img{
    text-align:left;
    vertical-align:middle;
    width: 30%;
  }
</style>
