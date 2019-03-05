<template>
  <div id="app">
    <router-view/>
  </div>
</template>

<script>
export default {
  name: 'App'
}
</script>

<style>
a {
	text-decoration: none;
}
.pointer {
  cursor: pointer;
}
.w3-button:hover {
  background-color: #f44336!important;
}
button:focus {outline:0;}
</style>
