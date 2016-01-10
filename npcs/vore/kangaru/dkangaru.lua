require "/scripts/vore/npcvore.lua"

isDigest = true

playerLines = {	"Mmmm, you're better than the pearlpeas <3",
				"No need to wiggle, you'll be a part of me soon.",
				"You feel so lovely in there.",
				"Come back soon. <3"
}

function initHook()

	index = entity.getItemSlot("legs").parameters.colorIndex
	
	legs = {
		name = "kangarulegs",
		parameters = {
					colorIndex = index
	}}
	
	fulllegs = {
		name = "kangarulegsbelly",
		parameters = {
					colorIndex = index
	}}

end

function loseHook()
	
	isPlayer = false
	
end

function updateHook()

	if isPlayer and math.random(700) == 1 then
		entity.say( playerLines[math.random(#playerLines)])
	end

end