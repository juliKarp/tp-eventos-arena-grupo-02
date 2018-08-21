package edu.algo3.eventos.model

import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable
import java.time.LocalDate

@Observable
@Accessors
class Usuarios {
	List<Usuario> usuarios
	Usuario usuarioSeleccionado

	def eliminarUsuarioSeleccionado() {
		val List<Usuario> nuevaListaUsuarios = newArrayList(usuarios)
		nuevaListaUsuarios.remove(usuarioSeleccionado)
		usuarios = nuevaListaUsuarios
	}

}

@Observable
@Accessors
class Usuario {
	String username
	String nombre
	String apellido
	String email
	String tipo
	LocalDate nacimiento

	new() {
	}

	new(int i) {
		username = "1" + String.valueOf(i)
		nombre = "2" + String.valueOf(i)
		apellido = "3" + String.valueOf(i)
		email = "4" + String.valueOf(i)
		tipo = "tipo"
		nacimiento = LocalDate.now.minusYears(i)
	}
}
