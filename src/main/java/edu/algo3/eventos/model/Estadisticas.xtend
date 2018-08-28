package edu.algo3.eventos.model

import edu.algo2.eventos.Locacion
import edu.algo2.eventos.Servicio
import edu.algo2.eventos.Usuario
import edu.algo2.repositorio.RepoLocaciones
import edu.algo2.repositorio.RepoServicios
import edu.algo2.repositorio.RepoUsuarios
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Estadisticas {
	List<Usuario> usuariosActivos
	List<Locacion> locacionesPopulares
	List<Servicio> serviciosNuevos
	
	int valor
	
	def void sumarEstadistica() {
		valor+=50
	}
	
	def actualizar() { //TODO: Cambiar por los listados que corresponden
		usuariosActivos = newArrayList(repoUsuarios.elementos)
		locacionesPopulares = newArrayList(repoLocaciones.elementos)
		serviciosNuevos = newArrayList(repoServicios.elementos)
		
//		ObservableUtils.firePropertyChanged(this, "usuariosActivos")
//		ObservableUtils.firePropertyChanged(this, "locacionesPopulares")
//		ObservableUtils.firePropertyChanged(this, "serviciosNuevos")
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