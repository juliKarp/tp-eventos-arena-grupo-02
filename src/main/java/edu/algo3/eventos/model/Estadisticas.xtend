package edu.algo3.eventos.model

import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List

@Observable
@Accessors
class Estadisticas {
	List<Usuario> usuarios
	int valor
	
	def void sumarEstadistica() {
		valor+=50
	}
}