A test project for submitting events to [Sentry](https://sentry.io/) from a [LÖVE](https://love2d.org/) project.

The contents of `raven` are vendored from cloudflare's [raven-lua](https://github.com/cloudflare/raven-lua) repository, including changes from [this pull request](https://github.com/cloudflare/raven-lua/pull/42). `json.lua` is vendored from [the json.lua repo](https://github.com/rxi/json.lua).

Required but not included in this repo is [`luasec`](https://github.com/brunoos/luasec). I installed it locally via luarocks by running `luarocks --tree=. install luasec`.

The contents of `main.lua` are released under the CC0 license.
