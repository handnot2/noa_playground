<template>
  <np-step title='Send Test Request with Access Token' status='none'>
    <div class='form-group'>
      <label class='form-label'>
        Test Request  (
          <a href='#' @click.stop.prevent='prefill_with_builtin_test_req'>
            use built-in test endpoint
          </a>
        )
      </label>
    </div>
    <div class='panel' style='height: auto;'>
      <nav class='panel-nav'>
        <ul class='tab tab-block'>
          <li
            class='tab-item'
            v-bind:class='{"active": active === "np-http-req-basic"}'
          >
            <a href='#' v-on:click.stop.prevent='set_active("np-http-req-basic")'>
              Basic
            </a>
          </li>
          <li
            class='tab-item'
            v-bind:class='{"active": active === "np-http-req-headers"}'
          >
            <a href='#' v-on:click.stop.prevent='set_active("np-http-req-headers")'>
              Headers
            </a>
          </li>
          <li
            class='tab-item'
            v-bind:class='{"active": active === "np-http-req-content"}'
          >
            <a href='#' v-on:click.stop.prevent='set_active("np-http-req-content")'>
              Content
            </a>
          </li>
        </ul>
      </nav>
      <div class='panel-body'>
        <component v-bind:is='active'></component>
      </div>
      <div class='panel-footer'>
        <button class='btn btn-primary btn-block'
          v-bind:class='disabled_class'
          v-on:click.stop.prevent='testing_testing'
        >Send Request
        </button>
      </div>
    </div>
    <br/>
    <div v-if='enabled && result' class='form-group'>
      <label class='form-label' for='np_test_req_response'>
        Test Response
      </label>
      <textarea class='form-input' id='np_test_req_response'
        rows='8'
        v-model='result'
      ></textarea>
    </div>
  </np-step>
</template>

<script>
import NpStep       from './np_step'
import HTTPReqBasic from './http_req_basic'
import HTTPReqHeaders from './http_req_headers'
import HTTPReqContent from './http_req_content'
import Utils from '../lib/utils.js'
import Debug from '../lib/debug.js'
import Axios from 'axios'
import {mapGetters} from 'vuex'

export default {
  name: 'AppReq',
  components: {
    'np-step': NpStep,
    'np-http-req-basic': HTTPReqBasic,
    'np-http-req-headers': HTTPReqHeaders,
    'np-http-req-content': HTTPReqContent
  },
  computed: {
    ...mapGetters([
      'test_req_url',
      'test_req_method',
      'test_req_headers',
      'test_req_content_type',
      'test_req_content',
      'token_resp_status',
      'token_resp_data'
    ]),
    enabled: function() {
      return this.about_to_submit || this.token_resp_status === "OK";
    },
    disabled_class: function() {
      return {disabled: !this.enabled};
    },
  },
  methods: {
    set_active: function(component) {
      this.active = component;
    },
    prefill_with_builtin_test_req: function() {
      var req_data = {
        test_req_url: Utils.playground_origin() + '/api/testing_testing',
        test_req_method: 'POST',
        test_req_headers: 'X-NP-Header1: Value1\r\nX-NP-Header2: Value2',
        test_req_content_type: 'text/plain',
        test_req_content: 'test request content'
      }
      this.$store.commit('set_test_req', req_data);
      this.result = null;
    },
    testing_testing: function() {
      var url = window.location;

      this.about_to_submit = true;
      this.result = null;

      Utils.save_state(this);

      var params = {
        test_req_url: this.test_req_url,
        test_req_method: this.test_req_method,
        test_req_headers: this.test_req_headers,
        test_req_content_type: this.test_req_content_type,
        test_req_content: this.test_req_content,
        access_token: this.token_resp_data['access_token']
      }

      Debug.log(params, 'Test Request Data');

      var me = this;
      Axios.post(`${url.origin}/api/make_test_req`, params)
        .then(function(resp) {
          Debug.log(resp, 'OK: Response from Test Request Endpoint');
          me.about_to_submit = false;
          me.result = "OK\n\n" + JSON.stringify(resp.data, null, '  ');
        })
        .catch(function(err) {
          Debug.log(err, 'ERROR: Response from Test Request Endpoint');
          me.about_to_submit = false;
          me.result = "ERROR\n\n" + JSON.stringify(err, null, '  ');
        });
    }
  },
  data() {
    return {
      about_to_submit: false,
      active: 'np-http-req-basic',
      result: null
    }
  }
}
</script>
