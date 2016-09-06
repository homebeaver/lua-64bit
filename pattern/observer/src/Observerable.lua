--local json  = require("json");
local Class = require("hump.class"); 


local Observerable = Class{}
local _trace = nil
-- uncomment for trace
--_trace = true

function Observerable:init()
  if(_trace) then print("Observerable ctor") end
  self.observers_ = {}
end

function Observerable:attach(observer)
  if(_trace) then print("Observerable:attach(",observer,"), there are",#(self.observers_),"observers.") end
  table.insert(self.observers_,observer)
--print("Observerable:attach(",observer,") now there are",#self.observers_,"observers.")
end

function Observerable:detach(observer)
--print("Observerable:detach(",observer,") there are",#(self.observers_),"observers.")
  for k , v in pairs(self.observers_) do
    if(v==observer) then
      if(_trace) then print("Observerable:detach(",observer,"), found this observer at",k) end
      table.remove(self.observers_,k) 
      if(_trace) then print("Observerable:detach(",observer,"), now there are",#self.observers_,"observers.") end
      break
    end
  end
end

function Observerable:notify()
  for i , observer in pairs(self.observers_) do
    observer:update()
  end
end

return Observerable