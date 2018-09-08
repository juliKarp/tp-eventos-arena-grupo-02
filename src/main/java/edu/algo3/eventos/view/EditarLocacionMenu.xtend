package edu.algo3.eventos.view

import edu.algo2.eventos.Locacion
import org.uqbar.arena.widgets.Panel

class EditarLocacionMenu extends EditarMenu<Locacion> {

	new(GestionLocacionesMenu owner, Locacion model) {
		super(owner, model)
		this.title = "EventOS - Locacion"
	}

	override agregarCampos(Panel panel) {
		panel => [
			agregarNombreValor("Nombre:", "nombre")
			agregarNombreValor("Superficie", "superficie")
			agregarPunto("Ubicacion:", "ubicacion")
		]
	}

	override tipoDeElemento() {
		typeof(Locacion)
	}
}
