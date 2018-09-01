package edu.algo3.eventos.model

import edu.algo2.eventos.Usuario
import edu.algo2.repositorio.RepoUsuarios
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable
import java.util.ArrayList

@Observable
@Accessors
class Usuarios {
	Usuario usuarioSeleccionado

	def getUsuarios() {
		new ArrayList<Usuario>(repoUsuarios.elementos)
	}

	def RepoUsuarios getRepoUsuarios() {
		ApplicationContext.instance.getSingleton(typeof(Usuario))
	}

}
