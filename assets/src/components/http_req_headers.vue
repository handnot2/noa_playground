<template>
  <div>
    <div class='form-group'>
      <label class='form-label' for='np_app_req_headers'>
        Request Headers
      </label>
      <textarea class='form-input' id='np_app_req_headers'
        rows='5'
        v-bind:placeholder='usage_instruction'
        v-model='test_req_headers'
      >
      </textarea>
    </div>
  </div>
</template>

<script>
export default {
  name: 'HTTPReqHeaders',
  computed: {
    usage_instruction: function() {
      return "Enter each request header in a separate line. Header name and value should be separated by a colon and a space character.";
    },
    test_req_headers: {
      get: function() {
        return this.$store.state.test_req_headers;
      },
      set: function(v) {
        this.$store.commit('set_test_req', {test_req_headers: v});
      }
    }
  }
}
</script>
