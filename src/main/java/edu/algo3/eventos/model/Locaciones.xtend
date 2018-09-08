package edu.algo3.eventos.model

import edu.algo2.eventos.Locacion
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Locaciones extends GestionModel<Locacion> {
	override getRepositorio() {
		ApplicationContext.instance.getSingleton(typeof(Locacion))
	}
}
