package edu.algo3.eventos.view

import edu.algo2.eventos.Servicio
import edu.algo3.eventos.model.Servicios
import org.uqbar.arena.widgets.tables.Table

class GestionServiciosMenu extends GestionMenu<Servicio> {

	new(MainMenu owner, Servicios model) {
		super(owner, model)
		this.title = "EventOS - Gestión de Servicios"
	}
	
	override tipoDeTabla() {
		typeof(Servicio)
	}

	override agregarColumnas(Table<Servicio> tabla) {
		tabla => [
			agregarColumna("Servicio", "descripcion")
			agregarColumna("Tarifa", "tarifa")
		]
	}
	
	override editar(Servicio seleccionado) {
		aplicacion.editarServicio(this, seleccionado)
	}
	
	override nuevo() {
		aplicacion.nuevoServicio(this)
	}
}
