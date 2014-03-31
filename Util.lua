--[[------------------------------------------------------------------ ----------
dump (label, x)
Dumps the value of "x" to the log, recursively dumping tables (and detecting
loops) with proper indenting.
---------------------------------------------------------------------- --------]]
local LrLogger = import 'LrLogger'
local log = LrLogger('mainLogger')
log:enable("logfile")


function dump (label, x)
  local function dump1 (x, indent, visited)
    if type (x) ~= "table" then
      log:trace (string.rep (" ", indent) .. tostring (x))
      return
    end
    visited [x] = true
    if indent == 0 then
      log:trace (string.rep (" ", indent) .. tostring (x))
    end
    for k, v in pairs (x) do    
      log:trace (string.rep (" ", indent + 4) .. tostring (k) .. " = " .. 
       tostring (v))
      if type (v) == "table" and not visited [v] then
        dump1 (v, indent + 4, visited)
      end
    end
  end

  log:trace (label .. ":")
  dump1 (x, 0, {})
end