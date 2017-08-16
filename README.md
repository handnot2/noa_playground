# NoaPlayground

Development companion tool for `Noa`, an OAuth2 Provider.
This is very similar to Google OAuth Playground. Currently
it is designed to work with `Noa`. But it should be possible
in the future to make it work with any OAuth2 provider.

> Still work-in-progress. But useable.

#### Usage Instructions

> You need to have a working `Noa` OAuth2 Authorization Server running.
> Refer to `https://github.com/handnot2/noa` to get `Noa` up and running.

You need to have `nodejs` and `npm` installed before you can proceed
further.

```sh
git clone https://github.com/handnot2/noa_playground
cd noa_playground
mix deps.get
cd assets
npm install
cd ..
mix compile
mix phx.server
```

`Noa Playground` uses port `4004` in `MIX_ENV=dev`.

Launch the browser and go to: `http://localhost:4004`

Click on `Settings` and provide the following:

-   Noa Authorization Provider URL
-   OAuth Client ID
-   Client Secret

If you used the Docker setup to run `Noa`, consult the `seed_output.txt` file
that was generated when you created the setup. (The setup process uses a seed data `yml`
file. Check that file for the scope you can specify in the playground.)

Once setup, `Noa Playground` usage is very similar to Google OAuth Playground.

This tool is built using [Spectre CSS](https://picturepan2.github.io/spectre/). `Spectre CSS`
website CSS is used here verbatim. It made it so much easier to just quickly get
this up and running without much fussing. The Javascript behind Spectre is done with
[Vuejs](https://vuejs.org/). Nothing much fancy, just enough to get this working quicker.
