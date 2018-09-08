package edu.algo3.eventos.view

import edu.algo2.eventos.Usuario
import edu.algo3.eventos.model.Usuarios
import org.uqbar.arena.widgets.tables.Table

class GestionUsuariosMenu extends GestionMenu<Usuario> {

	new(MainMenu owner, Usuarios model) {
		super(owner, model)
		this.title = "EventOS - Gestión de Usuarios"
	}

	override agregarColumnas(Table<Usuario> tabla) {
		tabla => [
			agregarColumna("Username", "nombreUsuario")
			agregarColumna("Nombre y apellido", "nombreApellido")
			agregarColumna("email", "email")
		]
	}

	override editar(Usuario seleccionado) {
		aplicacion.editarUsuario(this, seleccionado)
	}

	override nuevo() {
		aplicacion.nuevoUsuario(this)
	}
}
