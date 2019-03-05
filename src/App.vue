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
button:focus {outline:0;}
</style>
