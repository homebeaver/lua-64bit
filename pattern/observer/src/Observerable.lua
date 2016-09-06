--local json  = require("json");
local Class = require("hump.class"); 


local Observerable = Class{}

function Observerable:init()
print("Observerable ctor")
  self.observers_ = {}
print("Observerable ctor",#self.observers_)
end

function Observerable:attach(observer)
print("Observerable:attach(",observer,") there are",#(self.observers_),"observers.")
  table.insert(self.observers_,observer)
print("Observerable:attach(",observer,") now there are",#self.observers_,"observers.")
end

function Observerable:detach(observer)
--print("Observerable:detach(",observer,") there are",#(self.observers_),"observers.")
  for k , v in pairs(self.observers_) do
    if(v==observer) then
      print("Observerable:detach(",observer,") found at",k)
      table.remove(self.observers_,k) 
      print("Observerable:detach(",observer,") now there are",#self.observers_,"observers.")
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