package edu.algo3.eventos.view

import edu.algo2.eventos.Usuario
import edu.algo2.repositorio.RepoUsuarios
import edu.algo3.eventos.model.Usuarios
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.List
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.commons.applicationContext.ApplicationContext

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class EditarUsuarioMenu extends TransactionalDialog<Usuarios> {

	new(GestionUsuariosMenu owner, Usuarios model) {
		super(owner, model)
		this.title = "EventOS - Usuario"
	}

	override createFormPanel(Panel mainPanel) {
		new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
			agregarNombreValor("Username:", "usuarioSeleccionado.nombreUsuario")
			agregarNombreValor("Nombre:", "usuarioSeleccionado.nombreApellido")
			agregarNombreValor("email:", "usuarioSeleccionado.email")
			
			new List(mainPanel) => [
				allowNull(false)
				(items <=> "tiposUsuarioPosibles")//.adapter = new PropertyAdapter(typeof(TipoDeUsuario), "nombre")
				value <=> "usuarioSeleccionado.tipoDeUsuario"
			]

			agregarNombreValor("Fecha de nacimiento:", "usuarioSeleccionado.fechaNacimiento")
		]
	}

	override addActions(Panel actions) {
		new Button(actions) => [
			caption = "Cancelar"	
			onClick [this.cancel]
		]
		
		new Button(actions) => [
			caption = "Guardar"
			onClick [this.accept]
			setAsDefault
			disableOnError	
		]
	}
	
	def void agregarNombreValor(Panel panel, String nombre, String valor) {
		var valorPanel = new Panel(panel)
		valorPanel.layout = new VerticalLayout
		new Label(valorPanel) => [
			text = nombre
			width = 100
			alignLeft
		]
		new TextBox(valorPanel) => [
			value <=> valor
			width = 200
			alignLeft
		]
	}
	
	def RepoUsuarios getRepoUsuarios() {
		ApplicationContext.instance.getSingleton(typeof(Usuario))
	}
	
}
