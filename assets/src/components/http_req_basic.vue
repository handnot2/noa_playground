<template>
  <div>
    <div class='form-group'>
      <label class='form-label' for='np_app_req_url'>
        Request URL
      </label>
      <input type='url' id='np_app_req_url'
        class='form-input'
        v-model='test_req_url'
        placeholder='http://my.app/action'
      />
    </div>
    <div class='form-group'>
      <label class='form-label' for='np_http_method'>
        HTTP Request Method
      </label>
      <select class='form-select' id='np_http_method'
        v-model='test_req_method'
      >
        <option v-for='m in http_methods' :key='m' :value='m'>{{m}}</option>
      </select>
    </div>

    <p>
      Access token will be sent in the <code>Authorization</code> header.
      No need to explicitly include it in the request headers.
    </p>
  </div>
</template>

<script>
export default {
  computed: {
    test_req_url: {
      get: function() {
        return this.$store.state.test_req_url;
      },
      set: function(v) {
        this.$store.commit('set_test_req', {test_req_url: v});
      }
    },
    test_req_method: {
      get: function() {
        return this.$store.state.test_req_method;
      },
      set: function(v) {
        this.$store.commit('set_test_req', {test_req_method: v});
      }
    },
  },
  data() {
    return {
      http_methods: ['GET', 'POST', 'PUT', 'PATCH', 'DELETE']
    }
  }
}
</script>
