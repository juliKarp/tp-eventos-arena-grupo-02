package edu.algo3.eventos.runnable

import edu.algo2.eventos.Locacion
import edu.algo2.eventos.Usuario
import edu.algo2.repositorio.RepoLocaciones
import edu.algo2.repositorio.RepoUsuarios
import edu.algo3.eventos.model.Estadisticas
import edu.algo3.eventos.model.Locaciones
import edu.algo3.eventos.model.Usuarios
import edu.algo3.eventos.view.EditarLocacionMenu
import edu.algo3.eventos.view.EditarUsuarioMenu
import edu.algo3.eventos.view.GestionLocacionesMenu
import edu.algo3.eventos.view.GestionUsuariosMenu
import edu.algo3.eventos.view.MainMenu
import edu.algo3.eventos.view.NuevaLocacionMenu
import edu.algo3.eventos.view.NuevoUsuarioMenu
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
	
	def gestionDeLocaciones(MainMenu parent) {
		new GestionLocacionesMenu(parent, new Locaciones).open
	}
	
	def nuevoUsuario(GestionUsuariosMenu parent) {
		val nuevo = new Usuario
		new NuevoUsuarioMenu(parent, nuevo) => [
			onAccept[repoUsuarios.create(nuevo)]
			open
		]
	}
	
	def editarUsuario(GestionUsuariosMenu parent, Usuario usuario) {
		val copia = new Usuario => [
			id = usuario.id
			nombreApellido = usuario.nombreApellido
			nombreUsuario = usuario.nombreUsuario
			email = usuario.email
			fechaNacimiento = usuario.fechaNacimiento
			tipoDeUsuario = usuario.tipoDeUsuario
			direccion = usuario.direccion
		]
		new EditarUsuarioMenu(parent, copia) => [
			onAccept[repoUsuarios.update(copia)]
			open
		]
	}
	
	def nuevaLocacion(GestionLocacionesMenu parent) {
		val nueva = new Locacion
		new NuevaLocacionMenu(parent, nueva) => [
			onAccept[repoLocaciones.create(nueva)]
			open
		]
	}
	
	def editarLocacion(GestionLocacionesMenu parent, Locacion locacion) {
		val copia = new Locacion => [
			id = locacion.id
			nombre = locacion.nombre
			superficie = locacion.superficie
			ubicacion = locacion.ubicacion
		]
		new EditarLocacionMenu(parent, copia) => [
			onAccept[repoLocaciones.update(copia)]
			open
		]
	}

	def RepoUsuarios getRepoUsuarios() {
		ApplicationContext.instance.getSingleton(typeof(Usuario))
	}
	def RepoLocaciones getRepoLocaciones() {
		ApplicationContext.instance.getSingleton(typeof(Locacion))
	}
}
