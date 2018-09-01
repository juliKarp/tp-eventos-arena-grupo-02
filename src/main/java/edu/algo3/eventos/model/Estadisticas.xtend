package edu.algo3.eventos.model

import edu.algo2.eventos.Locacion
import edu.algo2.eventos.Servicio
import edu.algo2.eventos.Usuario
import edu.algo2.repositorio.RepoLocaciones
import edu.algo2.repositorio.RepoServicios
import edu.algo2.repositorio.RepoUsuarios
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable
import java.util.ArrayList

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