package edu.algo3.eventos.view

import edu.algo2.eventos.Locacion
import edu.algo3.eventos.model.Locaciones
import org.uqbar.arena.widgets.tables.Table

class GestionLocacionesMenu extends GestionMenu<Locacion> {

	new(MainMenu owner, Locaciones model) {
		super(owner, model)
		this.title = "EventOS - Gestión de Locaciones"
	}

	override agregarColumnas(Table<Locacion> tabla) {
		tabla => [
			agregarColumna("Nombre", "nombre")
			agregarColumna("Capacidad máxima", "capacidadMaxima")
		]
	}

	override editar(Locacion seleccionado) {
		aplicacion.editarLocacion(this, seleccionado)
	}

	override nuevo() {
		aplicacion.nuevaLocacion(this)
	}

}
