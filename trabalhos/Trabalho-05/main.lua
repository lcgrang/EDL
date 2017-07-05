larguraDaTela = love.graphics.getWidth()
alturaDaTela = love.graphics.getHeight()
    -- Nome: Variável "alturaDaTela"
    -- Propriedade: Endereço
    -- Binding Time: Compile
    -- Explicação: Variável global e assim, é alocada em memória em tempo de compilação
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

    pontos = 0
    bonus = 0
    perdas = 0
end

function love.update(dt)
    world:update(dt) 
    criaInimigo(dt)
    movimenta()
    colisao()
end

function love.draw()
love.graphics.setColor(240, 240, 240)
    love.graphics.polygon("fill", bloco.body:getWorldPoints(bloco.shape:getPoints()))

    -- Nome: For
    -- Propriedade: semântica
    -- Binding Time: Design
    -- Explicação: O identificador para o loop "For" é uma palavra reservada da linguagem,
    --              assim sendo sua amarração é feita na implementação da linguagem.
    for i, inimigo in ipairs(inimigos) do
        love.graphics.polygon("fill", inimigo.body:getWorldPoints(bloco.shape:getPoints()))
    end
    love.graphics.setColor(72, 240, 100)
    love.graphics.print("Pontuação:", 5, 20)
    love.graphics.print(pontos, 100, 20)
    -- Nome: Retorno da função 'print'
    -- Propriedade: semântica
    -- Binding Time: Run
    -- Explicação: Exibe na tela informações que são passadas no tempo de execução

    if perdas > 70 then
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
end

function movimenta()
if love.keyboard.isDown("a") then 
    aceleracao = velocidade * 2
    -- Nome: *
    -- Propriedade: semântica
    -- Binding time: Design
    -- Explicação: "*" é um operador aritimético, e assim sendo, sua função
    --              dentro da linguagem é definida em tempo de implementação.
else
    aceleracao = velocidade
end

if love.keyboard.isDown("right") then 
    -- Nome: Parâmetro da função 'isDown'
    -- Propriedade: Valor
    -- Binding Time: Run
    -- Explicação: Essa função verifica se um tecla foi pressionada, porém só em tempo de execução
    --              o valor passado como parâmetro será conhecido.
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
    -- Nome: Variável x1
    -- Propriedade: endereço
    -- Binding time: run
    -- Explicação: Durante a execução do programa, para cada objeto criado,
    --              durante o tempo de vida do mesmo, é feita a checagem de colisao com outros objetos,
    --              sendo assim, o endereço de memória da variável é alocado em tempo de execução.                    
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
        end
    end
end