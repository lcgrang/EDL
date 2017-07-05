

larguraDaTela = love.graphics.getWidth()
alturaDaTela = love.graphics.getHeight()

function love.load()
    love.physics.setMeter(64)

    world = love.physics.newWorld(0, 0, true)

    bloco = {}
    bloco.body = love.physics.newBody(world, 10, 650/2, "dynamic")
    bloco.shape = love.physics.newRectangleShape(50, 30)
    bloco.fixture = love.physics.newFixture(bloco.body, bloco.shape)
    velocidade = 5

    delayInimigo = 0.5
    tempoCriaInimigo = delayInimigo
    inimigos = {}
    -- trabalho 06
    -- Inimigos = {} é uma estrutura de tipo array que irá conter todos os blocos inimigos criados em tempo de execução.

    SIM = 1
    NAO = 0
    aux = 0

    pontos = 0
    bonus = 0
    perdas = 0

    

    function criaNovoBloco()
        local posx = 650/2
        local posy = 650/2
        local isAlive = NAO

        function moveBloco(dt)
            while true do
                for i=1, 5 do
                    posx = posx + 40*(dt+1)
                    --Executa um movimento e espera
                    dt = coroutine.yield(2)
                end
                for i=1, 5 do
                    posy = posy + 40*(dt+1)
                    dt = coroutine.yield(2)
                end
                for i=1, 5 do
                    posx = posx - 40*(dt+1)
                    dt = coroutine.yield(2)
                end
                for i=1, 5 do
                    posy = posy - 40*(dt+1)
                    dt = coroutine.yield(2)
                end
            end
        end

        local bloco = {
            -- trabalho 06
            -- bloco é um exemplo de registro, sendo uma estrutura que contém o acesso aos dados por meio de funções.
        coroutineBloco = coroutine.create(moveBloco),
        
        getX = function()
            return posx
        end,

        getY = function()
            return posy
        end,

        getPos = function()
            return posx, posy
        end,
        -- Trabalho 06
        -- Função getPos é um exemplo de Tupla
        revive = function()
            isAlive = SIM
            -- Trabalho 06
            -- SIM é um exemplo de enum
        end,

        morre = function()
            isAlive = NAO
        end,

        getIsAlive = function()
            return isAlive
        end

        }

        return bloco
    end

    blocoExtra = criaNovoBloco()
    
end

function love.update(dt)
    world:update(dt) 
    criaInimigo(dt)
    movimenta()
    colisao()

    if blocoExtra.getIsAlive() > 0 then
        co = coroutine.resume(blocoExtra.coroutineBloco, dt)
    end
end

function love.draw()
    love.graphics.setColor(240, 240, 240)
    love.graphics.polygon("fill", bloco.body:getWorldPoints(bloco.shape:getPoints()))
    for i, inimigo in ipairs(inimigos) do
        love.graphics.setColor(153, 0, 51)
        love.graphics.polygon("fill", inimigo.body:getWorldPoints(bloco.shape:getPoints()))
    end
    love.graphics.setColor(72, 240, 100)
    love.graphics.print("Pontuação:", 5, 20)
    love.graphics.print(pontos, 100, 20)
    
    
    if perdas > 25 then
        blocoExtra.revive()
        love.graphics.setColor(72, 240, 100)
        love.graphics.print("Alerta", 5, 35)
        love.graphics.print(pontos, 5, 50)
    end

    if perdas >= 100 then
        inimigos = {}
        pontos = 0
        perdas = 0
        bonus = 0
    end

    if blocoExtra.getIsAlive() > 0 then
        love.graphics.setColor(153,153,255)
        love.graphics.rectangle( "fill", blocoExtra.getX(), blocoExtra.getY(), 50, 30 )
    end
end

function movimenta()
    if love.keyboard.isDown("a") then 
        aceleracao = velocidade * 2
    else
        aceleracao = velocidade
    end

    if love.keyboard.isDown("right") then 
        if bloco.body:getX() < larguraDaTela then        
            bloco.body:setX(bloco.body:getX() + aceleracao)
        else
            bloco.body:setX(bloco.body:getX())
        end
    end  

    if love.keyboard.isDown("left") then
        if bloco.body:getX() > 0  then         
            bloco.body:setX(bloco.body:getX() - aceleracao)
        else 
            bloco.body:setX(bloco.body:getX())
        end
    end

    if love.keyboard.isDown("up") then
        if bloco.body:getY() > 0  then         
            bloco.body:setY(bloco.body:getY() - aceleracao)
        else 
            bloco.body:setY(bloco.body:getY())
        end
    end

    if love.keyboard.isDown("down") then
        if bloco.body:getY() < alturaDaTela  then         
            bloco.body:setY(bloco.body:getY() + aceleracao)
        else 
            bloco.body:setY(bloco.body:getY())
        end
    end
end

function criaInimigo(dt)
    tempoCriaInimigo = tempoCriaInimigo - (1* dt)
    if tempoCriaInimigo < 0 then
        tempoCriaInimigo = delayInimigo
        nRandom = math.random(10, love.graphics.getHeight())
        inimigo = {}
        inimigo.body = love.physics.newBody(world, love.graphics.getWidth() - 10, nRandom, "dynamic")
        inimigo.shape = love.physics.newRectangleShape(50, 30)  
        inimigo.fixture = love.physics.newFixture(bloco.body, bloco.shape)
        table.insert(inimigos, inimigo)
    end

    for i, inimigo in ipairs(inimigos) do
        inimigo.body:setX(inimigo.body:getX() - (170*dt))
        if inimigo.body:getX() < 0 then
            table.remove(inimigos, i)
            perdas = perdas + 1
        end
    end
end

function checaColisao(x1, y1, w1, h1, x2, y2, w2, h2)                  
    return x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + w1
end

function colisao()
    for i, inimigo in ipairs(inimigos) do
        if checaColisao(inimigo.body:getX(), inimigo.body:getY(), 50, 30, bloco.body:getX(), bloco.body:getY(), 50, 30) then
            table.remove(inimigos, i)
            pontos = pontos + 1
            bonus = bonus + 1
            if bonus >= 100 then
                bonus = 0
                perdas = 0
            end
            if blocoExtra.getIsAlive() > 0 then
                aux = aux + 1
            end
            if aux > 20 then
                blocoExtra.morre()
                aux = 0
            end

        end

        if checaColisao(inimigo.body:getX(), inimigo.body:getY(), 50, 30, blocoExtra:getX(), blocoExtra:getY(), 50, 30) then
            table.remove(inimigos, i)
        end
    end
end