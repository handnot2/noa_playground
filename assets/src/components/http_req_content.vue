<template>
  <div>
    <div class='form-group'>
      <label class='form-label' for='np_app_req_content_type'>
        Content Type
      </label>
      <select class='form-select' id='np_app_req_content_type'
        v-model='test_req_content_type'
      >
        <option v-for='ct in content_types' :key='ct' :value='ct'>
          {{ct}}
        </option>
      </select>
    </div>
    <div class='form-group'>
      <label class='form-label' for='np_app_req_content'>
        Request Body
      </label>
      <textarea class='form-input' id='np_app_req_content'
        rows='5'
        placeholder=''
        v-model='test_req_content'
      >
      </textarea>
    </div>
  </div>
</template>

<script>
export default {
  name: 'HTTPReqBody',
  computed: {
    test_req_content_type: {
      get: function() {
        return this.$store.state.test_req_content_type;
      },
      set: function(v) {
        this.$store.commit('set_test_req', {test_req_content_type: v});
      }
    },
    test_req_content: {
      get: function() {
        return this.$store.state.test_req_content;
      },
      set: function(v) {
        this.$store.commit('set_test_req', {test_req_content: v});
      }
    }
  },
  data() {
    return {
      content_types: [
        'application/json',
        'application/atom+xml',
        'application/x-www-form-url-encoded',
        'text/csv',
        'text/plain'
      ]
    }
  }
}
</script>
