package edu.algo3.eventos.model

import edu.algo2.eventos.Servicio
import edu.algo2.repositorio.RepoServicios
import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Servicios {
	Servicio servicioSeleccionado

	def getServicios() {
		new ArrayList<Servicio>(repoServicios.elementos)
	}

	def RepoServicios getRepoServicios() {
		ApplicationContext.instance.getSingleton(typeof(Servicio))
	}

}
