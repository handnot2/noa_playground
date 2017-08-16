<template>
  <np-step title='Get Access Token Information' :status='step_status'>
    <div class='form-group'>
      <button
        class='btn btn-primary'
        v-bind:class='disabled_class'
        v-on:click.stop.prevent='introspect_token'
      >Get Access Token Information
      </button>
    </div>
    <br/>
    <np-resp-data
      v-if='introspect_resp_status'
      v-bind:resp_status='introspect_resp_status'
      v-bind:resp_data='introspect_resp_data'
    ></np-resp-data>
  </np-step>
</template>

<script>
import NpStep       from './np_step'
import RespData     from './resp_data'
import Utils        from '../lib/utils.js'
import Debug        from '../lib/debug.js'
import Axios        from 'axios'
import {mapGetters} from 'vuex'

export default {
  name: 'NpIntrospectTokenStep',
  components: {
    'np-step': NpStep,
    'np-resp-data': RespData
  },
  computed: {
    ...mapGetters([
      'token_resp_status',
      'token_resp_data',
      'introspect_resp_status',
      'introspect_resp_data',
      'client_id',
      'client_secret',
      'base_url'
    ]),
    disabled_class: function() {
      var visible = this.about_to_submit || this.token_resp_status === "OK";
      return {disabled: !visible};
    },
    step_status: function() {
      var resp_status = this.introspect_resp_status;
      if (resp_status === 'OK') {
        return 'success';
      }
      else if (resp_status === 'ERROR') {
        return 'error';
      }
      else {
        return 'none';
      }
    }
  },
  methods: {
    introspect_token: function() {
      this.about_to_submit = true;

      var url = window.location;

      var params = {
        base_url: this.base_url,
        client_id: this.client_id,
        client_secret: this.client_secret,
        access_token: this.token_resp_data['access_token']
      }

      Debug.log(params, 'Token Instrospection Request Params');

      var me = this;
      Axios.post(`${url.origin}/api/introspect_token`, params)
        .then(function(resp) {
          Debug.log(resp, 'OK: Token Instrospection Response');
          var status = resp.data['error'] ? "ERROR" : "OK";
          me.$store.commit('set_introspect_result', {
            status: status,
            data: resp.data
          });
          Utils.save_state(me);
          me.about_to_submit = true;
        })
        .catch(function(err) {
          Debug.log(err, 'ERROR: Token Instrospection Response');
          me.$store.commit('set_introspect_result', {
            status: "ERROR",
            data: {"error": err.response.data}
          });
          Utils.save_state(me);
          me.about_to_submit = true;
        });
    }
  },
  data() {
    return {
      about_to_submit: false
    }
  }
}
</script>
