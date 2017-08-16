<template>
  <div class="timeline">
    <div class='toast toast-primary'>
      <strong>Important:</strong>
      Noa Playground is intended for development purposes. The secrets and tokens
      used here do show up in logs. They are also stored in the browser session
      storage.
    </div>
    <br/>
    <np-setup-scope-step></np-setup-scope-step>
    <np-authorize-req-step></np-authorize-req-step>
    <np-exchange-code-step></np-exchange-code-step>
    <np-introspect-token-step></np-introspect-token-step>
    <np-test-req-step></np-test-req-step>
  </div>
</template>

<script>
import NpSetupScopeStep      from './np_setup_scope_step'
import NpAuthorizeReqStep    from './np_authorize_req_step'
import NpExchangeCodeStep    from './np_exchange_code_step'
import NpIntrospectTokenStep from './np_introspect_token_step'
import NpTestReqStep         from './np_test_req_step'

export default {
  name: 'CodeGrantFlow',
  components: {
    'np-setup-scope-step': NpSetupScopeStep,
    'np-authorize-req-step': NpAuthorizeReqStep,
    'np-exchange-code-step': NpExchangeCodeStep,
    'np-introspect-token-step': NpIntrospectTokenStep,
    'np-test-req-step': NpTestReqStep
  }
}
</script>
