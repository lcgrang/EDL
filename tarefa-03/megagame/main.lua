local anim8 = require 'anim8'

local animation, salto, imagem
larguraDaTela = love.graphics.getWidth()
alturaDaTela = love.graphics.getHeight()

local posX = 100
local posY = 100
local direcao = true
local saltou = false

function love.load()
    imagem = love.graphics.newImage("images/megaman.png")
    fundo = love.graphics.newImage("images/fundo.jpg")

    local megamanCorrida = anim8.newGrid(35, 45, imagem:getWidth(), imagem:getHeight())
    local megamanSalto = anim8.newGrid(49, 45, imagem:getWidth(), imagem:getHeight(), 120)

    corrida = anim8.newAnimation(megamanCorrida('1-2', 3), 0.1)
    salto = anim8.newAnimation(megamanSalto('1-2', 1), 0.1)

    delayInimigo = 0.5
    tempoCriaInimigo = delayInimigo
    inimigoImagem = love.graphics.newImage("images/bullet.png")
    inimigos = {}

    estaVivo = true
end

function love.update(dt)
    megamanMoves(dt) 
    criaInimigo(dt)
    colisao()   
end

function love.draw()
    --love.graphics.setBackgroundColor(255, 255, 255)
    love.graphics.draw(fundo, 0, 0, 0, 0.5, 0.6)
    verificaDirecaoMegaman()

    for i, inimigo in ipairs(inimigos) do
        love.graphics.draw(inimigo.imagem, inimigo.posX, inimigo.posY, 0, 0.2, 0.2)
    end
end

function megamanMoves(dt)
    if love.keyboard.isDown('left') then
        saltou = false
        if posX > 0 then
            posX = posX - 150 * dt
            if love.keyboard.isDown('a') then
                posX = posX - 350 * dt
            end
        end
        direcao = false
        corrida:update(dt)
    end

    if love.keyboard.isDown('right') then
        saltou = false
        if posX < larguraDaTela then
            posX = posX + 150 * dt
            if love.keyboard.isDown('a') then
                posX = posX + 350 * dt
            end
        end
        direcao = true
        corrida:update(dt)
    end
    if love.keyboard.isDown('up') then
        saltou = true
        if posY > 0 then
            posY = posY - 150 * dt
        end
        salto:update(dt)
    end
    if love.keyboard.isDown('down') then
        saltou = true
        if posY < alturaDaTela then
            posY = posY + 150 * dt            
        end
        salto:update(dt)
    end
end

function verificaDirecaoMegaman()
    if direcao then
        if saltou then
            salto:draw(imagem, posX, posY, 0,1,1,20,0)
        else
            corrida:draw(imagem, posX, posY, 0,1,1,20,0)
        end
    else 
        if saltou then
            salto:draw(imagem, posX, posY, 0,-1,1,20,0)
        else
            corrida:draw(imagem, posX, posY, 0,-1,1,20,0)
        end
    end
end

function criaInimigo(dt)
    tempoCriaInimigo = tempoCriaInimigo - (1* dt)
    if tempoCriaInimigo < 0 then
        tempoCriaInimigo = delayInimigo
        nRandom = math.random(10, love.graphics.getHeight())
        novoInimigo = {posX = love.graphics.getWidth() - 10, posY = nRandom, imagem = inimigoImagem}
        table.insert(inimigos, novoInimigo)
    end

    for i, inimigo in ipairs(inimigos) do
        inimigo.posX = inimigo.posX - (100*dt)
        if inimigo.posX < 0 then
            table.remove(inimigos, i)
        end
    end
end

function colisao()
    for i, inimigo in ipairs(inimigos) do
        if checaColisao(inimigo.posX, inimigo.posY, posX, posY) then
            table.remove(inimigos, i)
        end
    end
end

function checaColisao(x1, y1, x2, y2)
    return x1 == x2
end