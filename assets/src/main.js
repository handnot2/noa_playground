//import Phoenix_html from 'phoenix_html'
//import { Socket } from 'phoenix'
import Vue from 'vue'
import Vuex from 'vuex'
import App from './App'
import Store from './lib/store.js'

require("../css/app.css")

Vue.use(Vuex)
Vue.config.productionTip = false
const store = new Vuex.Store({
  state: Store.state,
  getters: Store.getters,
  mutations: Store.mutations
});

new Vue({
  el: '#app',
  store: store,
  template: '<App/>',
  components: { App }
});
