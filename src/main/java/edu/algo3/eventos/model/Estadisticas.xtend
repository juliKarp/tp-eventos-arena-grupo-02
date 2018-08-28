package edu.algo3.eventos.model

import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.List
import org.uqbar.commons.applicationContext.ApplicationContext
import edu.algo2.eventos.Usuario
import edu.algo2.repositorio.RepoUsuarios
import edu.algo2.repositorio.RepoLocaciones
import edu.algo2.eventos.Locacion
import edu.algo2.eventos.Servicio
import edu.algo2.repositorio.RepoServicios

@Observable
@Accessors
class Estadisticas {
	List<Usuario> usuarios
	int valor
	
	def void sumarEstadistica() {
		valor+=50
	}
	
	def List<Usuario> getListaUsuariosActivos(){
		repoUsuarios.elementos // TODO: Traer lista usuarios activos. No todo el repo
	}
	
	def List<Locacion> getListaLocacionesPopulares(){
		repoLocaciones.elementos // TODO: Traer lista locaciones mas populares. Esto trae todo el repo
	}
	
	def List<Servicio> getListaServiciosNuevos(){
		repoServicios.elementos // TODO: Traer lista servicios nuevos. Esto trae todo el repo
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