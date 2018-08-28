package edu.algo3.eventos.runnable

import edu.algo3.eventos.model.Estadisticas
import edu.algo3.eventos.model.Usuario
import edu.algo3.eventos.model.Usuarios
import edu.algo3.eventos.view.EditarUsuarioMenu
import edu.algo3.eventos.view.GestionUsuariosMenu
import edu.algo3.eventos.view.MainMenu
import org.uqbar.arena.Application
import org.uqbar.commons.applicationContext.ApplicationContext
import edu.algo2.repositorio.RepoUsuarios

class EventOSApplication extends Application {

	new(EventOSBootstrap bootstrap) {
		super(bootstrap)
	}
	
	def static main(String[] args) {
		new EventOSApplication(new EventOSBootstrap).start
	}

	override protected createMainWindow() {
		val estadisticas = new Estadisticas
		new MainMenu(this, estadisticas)
	}

	def gestionDeUsuarios(MainMenu parent) {
		val usuarios = new Usuarios => [
			usuarios = newArrayList => [
				for (var i = 0; i < 10; i++) {
					add(new Usuario(i))
				}
			]
		]
		new GestionUsuariosMenu(parent, usuarios).open
	}

	def editarUsuario(GestionUsuariosMenu parent, Usuario usuario) {
		new EditarUsuarioMenu(parent, usuario) => [
			//onAccept[repoUsuarios.update(usuario)]
			open
		]
	}


	def RepoUsuarios getRepoUsuarios() {
		ApplicationContext.instance.getSingleton(typeof(edu.algo2.eventos.Usuario))
	}
}
