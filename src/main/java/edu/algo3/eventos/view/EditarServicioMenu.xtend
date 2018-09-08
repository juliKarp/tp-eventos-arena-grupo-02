package edu.algo3.eventos.view

import edu.algo2.eventos.Servicio
import edu.algo3.eventos.runnable.EventOSApplication
import org.uqbar.arena.widgets.Panel

class EditarServicioMenu extends EditarMenu<Servicio> {

	new(GestionServiciosMenu owner, Servicio model) {
		super(owner, model)
		this.title = "EventOS - Servicio"
	}

	override agregarCampos(Panel panel) {
		panel => [
			agregarNombreValor("Descripcion:", "descripcion")
			agregarPunto("Ubicación:", "ubicacion")
			agregarNombreValor("Tarifa por km:", "tarifaPorKm")
			agregarNombreValor("Tarifa:", "tarifa")
			agregarValorFijo("Tipo de tarifa:", "tipoTarifa")
			agregarBoton("Cambiar tipo tarifa", [EventOSApplication.editarTipoTarifa(this, this.modelObject)])
		]
	}

	override tipoDeElemento() {
		typeof(Servicio)
	}
}
