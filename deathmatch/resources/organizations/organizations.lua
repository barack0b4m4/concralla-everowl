
function Class(tbl)
    setmetatable(tbl, {
        __call = function (cls, ...) 
            local self = {}

            setmetatable(self, {
                __index = cls
            })

            self:constructor(...)
        end
    })
    -- set a meta table  on the passed in table

        -- call property

            -- create new table

            -- on new table, set ___index to our class

            --  call a constructor method on the class

            -- return our new table

    return tbl
end

local Organization = Class({
    constructor = function (self, name)
        self:setName(name)
    end;
    getName = function (self) 
        return self.name
    end;

    setName = function (self, name)
        self.name = name
    end;
})


local police = Organization('Los Santos Police Department')

local news = setmetatable({ name = 'San Andreas News' }, {
    __index = Organization;
})

outputServerLog(police:getName())
outputChatBox(news:getName())