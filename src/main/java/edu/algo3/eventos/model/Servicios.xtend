package edu.algo3.eventos.model

import edu.algo2.eventos.Servicio
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Servicios extends GestionModel<Servicio> {
	override getTipoDeElemento() {
		typeof(Servicio)
	}
}
