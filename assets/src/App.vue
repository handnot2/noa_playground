<template>
  <div id="app">
    <np-settings></np-settings>
    <section class="section section-header bg-gray">
      <section class="grid-header container grid-960">
        <np-top-nav-bar></np-top-nav-bar>
      </section>
    </section>
    <section class="container grid-960" style="width: auto; height: auto;">
      <section class="columns">

        <div  class="docs-content column col-9 col-sm-12"
              style="padding: 4rem 1rem 1rem 1rem;">
          <np-code-grant-flow></np-code-grant-flow>
        </div>
      </section>
    </section>
    <np-footer></np-footer>
  </div>
</template>

<script>
import TopNavBar     from './components/top_nav_bar'
import Settings      from './components/settings'
import CodeGrantFlow from './components/code_grant_flow'
import Footer        from './components/footer'
import Utils         from './lib/utils.js'

export default {
  name: 'app',
  components: {
    'np-top-nav-bar': TopNavBar,
    'np-settings': Settings,
    'np-code-grant-flow': CodeGrantFlow,
    'np-footer': Footer
  },
  mounted: function() {
    Utils.restore_state(this);
    var frags  = Utils.get_hash_frags(window.location.hash);
    var params = Utils.get_qs_params(window.location.search);
    if (Object.keys(frags).length > 0) {
      if (Utils.process_authorization_response(this, frags)) {
        Utils.save_state(this);
        window.location = Utils.playground_url();
      }
    }
    else if (Object.keys(params).length > 0) {
      if (Utils.process_authorization_response(this, params)) {
        Utils.save_state(this);
        window.location = Utils.playground_url();
      }
    }
  }
}
</script>
