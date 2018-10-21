package edu.algo3.eventos.model

import edu.algo2.eventos.Locacion
import edu.algo2.eventos.Servicio
import edu.algo2.eventos.Usuario
import edu.algo2.repositorio.RepoLocaciones
import edu.algo2.repositorio.RepoServicios
import edu.algo2.repositorio.RepoUsuarios
import java.time.LocalDateTime
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable
import edu.algo2.eventos.Evento
import edu.algo2.repositorio.RepoEventos

@Observable
@Accessors
class Estadisticas {
	int valor
	
	def getUsuariosActivos() {
		listaUsuariosActivos.subList(0,Math.min(5, listaUsuariosActivos.size()))
	}
	def getLocacionesPopulares() {
		listaLocacionesPopulares
	}
	def getServiciosNuevos() {
		listaServiciosNuevos.subList(0,Math.min(5, listaServiciosNuevos.size()))
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
		eventos.fold(0, [suma, invitacion|suma + invitacion.cantidadEntradasVendidas])
	}
	def getCantidadInvitacionesEnviadas() {
		eventos.fold(0, [suma, invitacion|suma + invitacion.cantidadInvitaciones])
	}
	
	def listaUsuariosActivos() {
		repoUsuarios.elementos.sortBy[getActividad].reverse
	}
	
	def listaLocacionesPopulares() {
		val locaciones = eventos.map[locacion]
		locaciones.toSet.sortBy[ locacion |
			locaciones.filter[equals(locacion)].size
		].reverse
	}
	
	def listaServiciosNuevos() {
		repoServicios.elementos.reverseView
	}
	
	def getEventos() {
		repoEventos.elementos
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
	
	def RepoEventos getRepoEventos() {
		ApplicationContext.instance.getSingleton(typeof(Evento))
	}

	
}