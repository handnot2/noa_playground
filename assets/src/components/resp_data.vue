<template>
  <div>
    <p v-if='resp_status' v-bind:style='resp_status_style'>
       <strong>{{resp_status}}</strong>
    </p>
    <table class='table table-striped table-hover'>
      <thead>
        <tr><th>Name</th><th>Value</th></tr>
      </thead>
      <tbody>
        <tr v-for='k in data_keys' :key='k'>
          <td>{{k}}</td><td>{{resp_data[k]}}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
  name: 'RespData',
  props: ['resp_status', 'resp_data'],
  computed: {
    data_keys: function() {
      return Object.keys(this.resp_data);
    },
    resp_status_style : function() {
      return {color: this.resp_status === "OK" ? 'blue' : 'red'}
    }
  }
}
</script>
