import Vue from 'vue';
import Root from './components/root.vue';

import Buefy from 'buefy';
import 'buefy/dist/buefy.css';
Vue.use(Buefy);

import Gravatar from 'vue-gravatar';
Vue.component('v-gravatar', Gravatar);

global.$(document).ready(function () {
  new Vue({
    render: h => h(Root),
  }).$mount('#rails-vue-template');
});
