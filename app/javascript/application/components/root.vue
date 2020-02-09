<template>
  <div id="app">
    <Header />
    <div class="fullpage">
      <ContactIndex />
    </div>
    <Footer />
  </div>
</template>

<script>
import Header from './header.vue';
import Footer from './footer.vue';
import ContactIndex from './contact_index.vue';

export default {
  components: { Header, Footer, ContactIndex },
};
</script>

<style>
  html, body {
    height: 100%;
  }
</style>

<style scoped>
#app {
  height: 100%;
  display: flex;
  flex-flow: column;
}

.fullpage {
  flex-grow: 1;
}
</style>
