package edu.algo3.eventos.view

import edu.algo3.eventos.model.Estadisticas
import edu.algo3.eventos.model.Usuario
import edu.algo3.eventos.model.Usuarios
import org.uqbar.arena.Application

class EventOSApplication extends Application {

	def static main(String[] args) {
		new EventOSApplication().start
	}

	override protected createMainWindow() {
		val estadisticas = new Estadisticas => [
			usuarios = newArrayList => [
				for (var i = 0; i < 3; i++) {
					add(new Usuario(i))
				}
			]
		]
		new MainMenu(this, estadisticas)
	}

	def gestionDeUsuariosWindow() {
		val usuarios = new Usuarios => [
			usuarios = newArrayList => [
				for (var i = 0; i < 10; i++) {
					add(new Usuario(i))
				}
			]
		]
		new GestionUsuariosMenu(this, usuarios).open
	}

	def editarUsuarioWindow(Usuario usuario) {
		new EditarUsuarioMenu(this, usuario).open
	}

}
