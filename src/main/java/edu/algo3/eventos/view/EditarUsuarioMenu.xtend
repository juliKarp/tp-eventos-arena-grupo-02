package edu.algo3.eventos.view

import edu.algo2.eventos.Usuario
import edu.algo2.repositorio.RepoUsuarios
import org.uqbar.arena.widgets.Panel
import org.uqbar.commons.applicationContext.ApplicationContext

class EditarUsuarioMenu extends EditarMenu<Usuario> {

	new(GestionUsuariosMenu owner, Usuario model) {
		super(owner, model)
		this.title = "EventOS - Usuario"
	}

	def RepoUsuarios getRepoUsuarios() {
		ApplicationContext.instance.getSingleton(typeof(Usuario))
	}

	override agregarCampos(Panel panel) {
		panel => [
			agregarNombreValor("Username:", "nombreUsuario")
			agregarNombreValor("Nombre y apellido:", "nombreApellido")
			agregarNombreValor("email:", "email")
			agregarFecha("Fecha de nacimiento:", "fechaNacimiento")
			agregarSeleccionable("Tipo de usuario:", "tiposUsuarioPosibles", "tipoDeUsuario")
			agregarPunto("Direccion:", "direccion")
		]
	}

	override tipoDeElemento() {
		typeof(Usuario)
	}

}
