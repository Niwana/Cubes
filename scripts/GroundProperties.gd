extends Node

var biomass

func _ready():
	biomass = randi()%11
	
func setBiomass(value):
    biomass = value

func getBiomass():
    return biomass