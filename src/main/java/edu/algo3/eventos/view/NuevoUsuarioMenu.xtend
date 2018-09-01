package edu.algo3.eventos.view

import edu.algo2.eventos.Usuario

class NuevoUsuarioMenu extends EditarUsuarioMenu {

	new(GestionUsuariosMenu owner, Usuario model) {
		super(owner, model)
		this.title = "EventOS - Nuevo Usuario"
	}

	
}
