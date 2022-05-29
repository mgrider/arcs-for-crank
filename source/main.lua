import 'CoreLibs/graphics'

gfx = playdate.graphics

gfx.clear()

startAngle = 0
ds = 0.4
endAngle = 0
de = 2
radius = 120
nrings = 12

innerRadius = 1 * radius/nrings
outerRadius = 2 * radius/nrings

autodraw = false
inverted = false

gfx.setStrokeLocation(gfx.kStrokeOutside)

-- set some menu items

local menu = playdate.getSystemMenu()
local menuItem, error = menu:addMenuItem("Reset", function()
	reset()
end)
local menuItem, error = menu:addMenuItem("Randomize", function()
	randomize()
end)
local menuItem, error = menu:addMenuItem("Invert", function()
	doInvert()
end)

-- update

function playdate.update()

	gfx.clear()

	gfx.setColor(gfx.kColorWhite);
	gfx.drawRect(200 - radius, 120 - radius, radius * 2 + 1, radius * 2 + 1)

	if autodraw then
		startAngle = startAngle + ds
		endAngle = endAngle + de
	end

	gfx.setColor(gfx.kColorBlack);

	for i=1,nrings-1
	do
		innerRadius = i * radius/nrings
		outerRadius = (i+1) * radius/nrings
		gfx.setLineWidth(outerRadius - innerRadius)
		gfx.drawArc(200, 120, innerRadius, (nrings - i) * startAngle, (nrings - i) * endAngle)
	end

end


function drawarc()
	gfx.setColor(gfx.kColorWhite);
	gfx.drawRect(0, 0, 400, 240)

	gfx.setColor(gfx.kColorXOR)
	gfx.setLineWidth(outerRadius - innerRadius)
	gfx.drawArc(200, 120, innerRadius, startAngle, endAngle)
	playdate.display.flush()
end


function playdate.upButtonDown()
	nrings += 1
	drawarc()
end

function playdate.downButtonDown()
	nrings -= 1
	if nrings < 2 then nrings = 2 end
	drawarc()
end

function playdate.leftButtonDown()
	endAngle = endAngle - 10
	drawarc()
end

function playdate.rightButtonDown()
	endAngle = endAngle + 10
	drawarc()
end

function playdate.AButtonDown()
	autodraw = not autodraw
end

function playdate.BButtonDown()
	reset()
end

function playdate.cranked(change, acceleratedChange)
	startAngle += acceleratedChange / 10
	endAngle += acceleratedChange / 2
end

function reset()
	gfx.clear()
	startAngle = 0
	ds = 0.4
	endAngle = 0
	de = 2
	radius = 120
	nrings = 12
	innerRadius = 1 * radius/nrings
	outerRadius = 2 * radius/nrings
	drawarc()
end

function randomize()
	gfx.clear()
	startAngle = math.random(120)
	endAngle = math.random(120)
--	radius = math.random(120)
	nrings = math.random(2,24)
	innerRadius = math.random(120)
	outerRadius = math.random(120)
	drawarc()
end

function doInvert()
	inverted = not inverted
	playdate.display.setInverted(inverted)
end

function playdate.gameWillPause()

--	local img = gfx.image.new()

	local img = gfx.getDisplayImage()
	img = img:fadedImage(0.5, playdate.graphics.image.kDitherTypeScreen)

	gfx.lockFocus(img)
	local bgRect = playdate.geometry.rect.new(20, 20, 160, 200)
	local textRect = playdate.geometry.rect.new(30, 30, 140, 180)
	gfx.setColor(gfx.kColorWhite)
	gfx.fillRoundRect(bgRect, 10)
	gfx.setColor(gfx.kColorBlack)
	gfx.drawRoundRect(bgRect, 10)
	gfx.drawTextInRect(" Arc-for-crank \n\n adapted from PlaydateSDK \"arcs\" example \n\n by Martin Grider", textRect, 0, "...", kTextAlignment.center)
	gfx.unlockFocus()

	playdate.setMenuImage(img, 0)

end
