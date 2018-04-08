<template>
  <div class="w3-cell-row border-list">
    <slot></slot>
  </div>
</template>

<script>

export default {
  name: 'List'
}
</script>

<style scoped>
  .border-list{
    padding: 8px 16px;
    margin-top: 8px;
    border: 2px solid #aaa
  }
</style>
