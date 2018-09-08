package edu.algo3.eventos.model

import edu.algo2.repositorio.Entidad
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import edu.algo2.repositorio.Repositorio
import org.uqbar.commons.applicationContext.ApplicationContext

@Observable
@Accessors
abstract class GestionModel<T extends Entidad> {
	T seleccionado

	def getElementos() {
		repositorio.elementos
	}

	def Repositorio<T> getRepositorio() {
		ApplicationContext.instance.getSingleton(tipoDeElemento)
	}

	def Class<T> getTipoDeElemento()
}
