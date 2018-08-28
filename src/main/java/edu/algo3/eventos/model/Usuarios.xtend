package edu.algo3.eventos.model

import edu.algo2.eventos.TipoDeUsuario
import edu.algo2.eventos.Usuario
import edu.algo2.repositorio.RepoUsuarios
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Usuarios {
	List<Usuario> usuarios
	Usuario usuarioSeleccionado
	List<TipoDeUsuario> tiposUsuarioPosibles
	
	new (){
		tiposUsuarioPosibles = newArrayList
		tiposUsuarioPosibles.add(repoUsuarios.tipoUsuarioFree)
		tiposUsuarioPosibles.add(repoUsuarios.tipoUsuarioAmateur)
		tiposUsuarioPosibles.add(repoUsuarios.tipoUsuarioProfesional)
	}
	
	def actualizarUsuarios(){
		usuarios = newArrayList(repoUsuarios.elementos)
	}

	def eliminarUsuarioSeleccionado() {
		repoUsuarios.delete(usuarioSeleccionado)
		actualizarUsuarios
	}
	
	def RepoUsuarios getRepoUsuarios() {
		ApplicationContext.instance.getSingleton(typeof(Usuario))
	}

}
