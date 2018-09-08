package edu.algo3.eventos.runnable

import edu.algo2.eventos.Locacion
import edu.algo2.eventos.Servicio
import edu.algo2.eventos.Usuario
import edu.algo3.eventos.model.EditorTipoTarifa
import edu.algo3.eventos.model.Estadisticas
import edu.algo3.eventos.model.Locaciones
import edu.algo3.eventos.model.Servicios
import edu.algo3.eventos.model.Usuarios
import edu.algo3.eventos.view.EditarLocacionMenu
import edu.algo3.eventos.view.EditarServicioMenu
import edu.algo3.eventos.view.EditarTipoTarifaMenu
import edu.algo3.eventos.view.EditarUsuarioMenu
import edu.algo3.eventos.view.GestionLocacionesMenu
import edu.algo3.eventos.view.GestionServiciosMenu
import edu.algo3.eventos.view.GestionUsuariosMenu
import edu.algo3.eventos.view.MainMenu
import edu.algo3.eventos.view.NuevaLocacionMenu
import edu.algo3.eventos.view.NuevoServicioMenu
import edu.algo3.eventos.view.NuevoUsuarioMenu
import org.uqbar.arena.Application

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
	
	def gestionDeServicios(MainMenu parent) {
		new GestionServiciosMenu(parent, new Servicios).open
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
			onAccept[repositorio.create(nueva)]
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
			onAccept[repositorio.update(copia)]
			open
		]
	}

	def nuevoServicio(GestionServiciosMenu parent) {
		val nuevo = new Servicio
		new NuevoServicioMenu(parent, nuevo) => [
			onAccept[repositorio.create(nuevo)]
			open
		]
	}
	
	def editarServicio(GestionServiciosMenu parent, Servicio servicio) {
		val copia = new Servicio => [
			id = servicio.id
			descripcion = servicio.descripcion
			tarifa = servicio.tarifa
			tarifaPorKm = servicio.tarifaPorKm
			ubicacion = servicio.ubicacion
			tipoTarifa = servicio.tipoTarifa
		]
		new EditarServicioMenu(parent, copia) => [
			onAccept[repositorio.update(copia)]
			open
		]
	}
	
	def static editarTipoTarifa(EditarServicioMenu parent, Servicio _servicio) {
		val editor = new EditorTipoTarifa => [servicio = _servicio]
		new EditarTipoTarifaMenu(parent, editor) => [
			open
		]
	}
	
}
