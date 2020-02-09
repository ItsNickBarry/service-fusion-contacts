import Vue from 'vue';
import Root from './components/root.vue';

import Buefy from 'buefy';
import 'buefy/dist/buefy.css';

import Gravatar from 'vue-gravatar';

Vue.use(Buefy);
Vue.component('v-gravatar', Gravatar);

global.$(document).ready(function () {
  new Vue({
    render: h => h(Root),
  }).$mount('#rails-vue-template');
});
