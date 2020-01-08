function love.load()
    score = 0
    time = 500

    circle = {}
    circle.x = 200
    circle.y = 200

    -- difficulty
    circle.size = 10
    
    isDir = love.filesystem.isDirectory( "test" )

    rng = love.math.newRandomGenerator()

    myFont = love.graphics.newFont(30)
    love.graphics.setFont(myFont)
end

-- is called 60 times every second
function love.update(dt)
    if time > 0 then
        time = time - 1
    end
end

-- also called in every frame but is responsible for graphics
function love.draw()
    
    love.graphics.setColor(1,0,0)
    love.graphics.rectangle("line", 2, 2,100,50)
    love.graphics.print(time,10,10)

    -- love.graphics.print(tostring(isDir),100,100)

    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill",circle.x ,circle.y , circle.size)

    love.graphics.setColor(0,1,1)
    s = "Score: "..score
    love.graphics.print(s,love.graphics.getWidth()-200,10)
end

function love.mousepressed(x,y,mouse,isTouch)
    if time <= 0 then
        return
    end
    -- left click
    if mouse == 1 then
        if isClickCorrect(x,y,circle.x,circle.y) then
            score = score + 1
            -- io.write(string.format("Hello from %s on %s\n",_VERSION,os.date()))
            io.write(string.format("Score %d\n",score))
        else
            print("Loss!")
            score = score - 1
        end
    end
    changeCirclePosition()
end

function isClickCorrect(x,y,targetX,targetY)
    d = distanceBetweenPoints(x,y,targetX,targetY)
    if d < circle.size then
        return true
    else
        return false
    end
end

function distanceBetweenPoints(x1,y1,x2,y2)
    subroot = (y2-y1)^2 + (x2-x1)^2
    return math.sqrt( subroot )
end

function changeCirclePosition()
    circle.x = rng:random(circle.size,love.graphics.getWidth() - circle.size)
    circle.y = rng:random(circle.size,love.graphics.getHeight() - circle.size)
end