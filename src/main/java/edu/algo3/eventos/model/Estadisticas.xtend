package edu.algo3.eventos.model

import edu.algo2.eventos.Locacion
import edu.algo2.eventos.Servicio
import edu.algo2.eventos.Usuario
import edu.algo2.repositorio.RepoLocaciones
import edu.algo2.repositorio.RepoServicios
import edu.algo2.repositorio.RepoUsuarios
import java.time.LocalDateTime
import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Estadisticas {
	int valor
	
	def void sumarEstadistica() {
		valor += 50
	}
	
	
	def getUsuariosActivos() {
		new ArrayList<Usuario>(repoUsuarios.elementos)
	}
	def getLocacionesPopulares() {
		new ArrayList<Locacion>(repoLocaciones.elementos)
	}
	def getServiciosNuevos() {
		new ArrayList<Servicio>(repoServicios.elementos)
	}
	

	def getCantidadEventos() {
		eventos.size
	}
	def getCantidadEventosDelMes() {
		eventos.filter[mismoMes(LocalDateTime.now)].size
	}
	def getCantidadEventosExitosos() {
		eventos.filter[esExitoso].size
	}
	def getCantidadEventosFracasados() {
		eventos.filter[esUnFracaso].size
	}
	def getCantidadEntradasVendidas() {
		eventos.fold(0, [suma, invitacion|suma + invitacion.cantidadEntradas])
	}
	def getCantidadInvitacionesEnviadas() {
		eventos.fold(0, [suma, invitacion|suma + invitacion.cantidadInvitaciones])
	}
	
	def getEventos() {
		repoUsuarios.elementos.map[eventos].flatten.toList
	}
	
	def RepoUsuarios getRepoUsuarios() {
		ApplicationContext.instance.getSingleton(typeof(Usuario))
	}
	
	def RepoLocaciones getRepoLocaciones() {
		ApplicationContext.instance.getSingleton(typeof(Locacion))
	}
	
	def RepoServicios getRepoServicios() {
		ApplicationContext.instance.getSingleton(typeof(Servicio))
	}

	
}