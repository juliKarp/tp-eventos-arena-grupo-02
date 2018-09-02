package edu.algo3.eventos.model

import edu.algo2.eventos.Locacion
import edu.algo2.repositorio.RepoLocaciones
import java.util.ArrayList
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Locaciones {
	Locacion locacionSeleccionada

	def getLocaciones() {
		new ArrayList<Locacion>(repoLocaciones.elementos)
	}

	def RepoLocaciones getRepoLocaciones() {
		ApplicationContext.instance.getSingleton(typeof(Locacion))
	}

}
