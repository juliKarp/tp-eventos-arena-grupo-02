package edu.algo3.eventos.runnable

import edu.algo2.eventos.Usuario
import edu.algo2.repositorio.RepoUsuarios
import edu.algo3.eventos.model.Estadisticas
import edu.algo3.eventos.model.Usuarios
import edu.algo3.eventos.view.EditarUsuarioMenu
import edu.algo3.eventos.view.GestionUsuariosMenu
import edu.algo3.eventos.view.MainMenu
import org.uqbar.arena.Application
import org.uqbar.commons.applicationContext.ApplicationContext

class EventOSApplication extends Application {

	new(EventOSBootstrap bootstrap) {
		super(bootstrap)
	}
	
	def static main(String[] args) {
		new EventOSApplication(new EventOSBootstrap).start
	}

	override protected createMainWindow() {
		new MainMenu(this, new Estadisticas)
	}

	def gestionDeUsuarios(MainMenu parent) {
		new GestionUsuariosMenu(parent, new Usuarios).open
	}

	def editarUsuario(GestionUsuariosMenu parent, Usuarios usuarios) {
		new EditarUsuarioMenu(parent, usuarios) => [
			//onAccept[repoUsuarios.update(usuario)]
			open
		]
	}


	def RepoUsuarios getRepoUsuarios() {
		ApplicationContext.instance.getSingleton(typeof(Usuario))
	}
}
