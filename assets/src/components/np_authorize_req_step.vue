<template>
  <np-step title='Get User Authorization/Approval' :status='step_status'>
    <div class='form-group'>
      <label class='form-label'>
        Make sure the OAuth server <code>redirect_uri</code> is set to
        <code>{{redirect_uri}}</code>
      </label>
    </div>
    <div class='form-group'>
      <button
        class='btn btn-primary'
        v-bind:class='disabled_class'
        v-on:click.stop='authorize_req'
      >Get Authorization Code
      </button>
    </div>
    <br/>
    <np-resp-data
      v-if='authorize_resp_status'
      v-bind:resp_status='authorize_resp_status'
      v-bind:resp_data='authorize_resp_data'
    ></np-resp-data>
  </np-step>
</template>

<script>
import NpStep       from './np_step'
import RespData     from './resp_data'
import Utils        from '../lib/utils.js'
import Debug        from '../lib/debug.js'
import {mapGetters} from 'vuex'

export default {
  name: 'AuthorizeReqStep',
  components: {
    'np-step': NpStep,
    'np-resp-data': RespData
  },
  computed: {
    ...mapGetters([
      'authorize_resp_status',
      'authorize_resp_data',
      'client_id',
      'base_url',
      'send_scope',
      'scope'
    ]),
    disabled_class: function() {
      var visible = this.base_url != "" && this.client_id != "";
      return {disabled: !visible};
    },
    step_status: function() {
      var resp_status = this.authorize_resp_status;
      if (resp_status === 'OK') {
        return 'success';
      }
      else if (resp_status === 'ERROR') {
        return 'error';
      }
      else {
        return 'none';
      }
    },
    redirect_uri: function() {
      var url = window.location;
      return `${url.origin}${url.pathname}`;
    }
  },
  methods: {
    authorize_req: function() {
      var req_state =
        '' + (Math.random() * Math.pow(10, 10)) +
        '.' + (Math.random() * Math.pow(10, 10));
      this.$store.commit('set_authorization_state', req_state);

      var callback_uri = Utils.playground_url();
      var authorize_url = Utils.compose_authorization_url(
        this.base_url,
        this.client_id,
        callback_uri,
        req_state,
        this.send_scope ? this.scope : null
      );

      Utils.save_state(this);

      Debug.log(authorize_url, 'Authorization Request Redirect');
      window.location = authorize_url;
    }
  }
}
</script>
