package edu.algo3.eventos.view

import edu.algo2.eventos.Locacion

class NuevaLocacionMenu extends EditarLocacionMenu {

	new(GestionLocacionesMenu owner, Locacion model) {
		super(owner, model)
		this.title = "EventOS - Nueva Locacion"
	}
}
