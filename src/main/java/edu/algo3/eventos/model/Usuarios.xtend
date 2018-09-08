package edu.algo3.eventos.model

import edu.algo2.eventos.Usuario
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Usuarios extends GestionModel<Usuario> {
	override getTipoDeElemento() {
		typeof(Usuario)
	}
}
