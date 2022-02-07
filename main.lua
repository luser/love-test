-- To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.
--
-- You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

paths = love.filesystem.getRequirePath()
love.filesystem.setRequirePath(paths .. ";share/lua/5.3/?.lua")
c_paths = love.filesystem.getCRequirePath()
love.filesystem.setCRequirePath(c_paths .. ";lib/lua/5.3/??")

function love.draw()
   love.graphics.print("Hello World", 400, 300)
end

function love.keypressed(key)
   if key == 'm' then
      send_message()
   elseif key == 'e' then
      send_exception()
   elseif key == 'f' then
      call_undef_func()
   elseif key == 'escape' or key == 'q' then
      love.event.quit(0)
   end
end

local raven = require "raven"

local rvn = raven.new {
   sender = require("raven.senders.luasocket").new {
      dsn = "< get this from your sentry config >",
                                                   },
   tags = { foo = "bar" },
}

function send_message()
   -- Send a message to sentry
   local id, err = rvn:captureMessage(
      "Sentry is a realtime event logging and aggregation platform.",
      { tags = { abc = "def" } } -- optional
   )
   if not id then
      print(err)
   end
end

function send_exception()
   -- Send an exception to sentry
   local exception = {{
         ["type"]= "SyntaxError",
         ["value"]= "Wattttt!",
         ["module"]= "__builtins__"
   }}
   local id, err = rvn:captureException(
      exception,
      { tags = { abc = "def" } } -- optional
   )
   if not id then
      print(err)
   end
end

-- Catch an exception and send it to sentry
function bad_func(n)
   return not_defined_func(n)
end

function call_undef_func()
   -- variable 'ok' should be false, and an exception will be sent to sentry
   local ok = rvn:call(bad_func, 1)
end
