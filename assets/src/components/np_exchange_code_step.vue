<template>
  <np-step title='Exchange Code for Access Token' :status='step_status'>
    <div class='form-group'>
      <button
        class='btn btn-primary'
        v-bind:class='disabled_class'
        v-on:click.stop.prevent='exchange_code'
      >Get Access Token
      </button>
    </div>
    <br/>
    <np-resp-data
      v-if='token_resp_status'
      v-bind:resp_status='token_resp_status'
      v-bind:resp_data='token_resp_data'
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
  name: 'NpExchangeCodeStep',
  components: {
    'np-step': NpStep,
    'np-resp-data': RespData
  },
  computed: {
    ...mapGetters([
      'token_resp_status',
      'token_resp_data',
      'authorize_resp_status',
      'authorize_resp_data',
      'client_id',
      'client_secret',
      'base_url'
    ]),
    disabled_class: function() {
      var visible = this.about_to_submit || this.authorize_resp_status === "OK";
      return {disabled: !visible};
    },
    step_status: function() {
      var resp_status = this.token_resp_status;
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
    exchange_code: function() {
      this.about_to_submit = true;

      var url = window.location;

      var params = {
        base_url: this.base_url,
        client_id: this.client_id,
        client_secret: this.client_secret,
        code: this.authorize_resp_data['code']
      }

      var me = this;
      Axios.post(`${url.origin}/api/exchange_code`, params)
        .then(function(resp) {
          Debug.log(resp, 'OK: Exchange code for access token');
          var status = resp.data['error'] ? "ERROR" : "OK";
          me.$store.commit('set_token_result', {
            status: status,
            data: resp.data
          });
          me.$store.commit('clear_introspect_result');
          Utils.save_state(me);
          me.about_to_submit = false;
        })
        .catch(function(err) {
          Debug.log(err, 'ERROR: Exchange code for access token');
          me.$store.commit('set_token_result', {
            status: "ERROR",
            data: {"error": err.response.data}
          });
          me.$store.commit('clear_introspect_result');
          Utils.save_state(me);
          me.about_to_submit = false;
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
