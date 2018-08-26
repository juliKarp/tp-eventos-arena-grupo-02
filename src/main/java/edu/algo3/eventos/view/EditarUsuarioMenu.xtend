package edu.algo3.eventos.view

import edu.algo3.eventos.model.Usuario
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class EditarUsuarioMenu extends TransactionalDialog<Usuario> {

	new(GestionUsuariosMenu owner, Usuario model) {
		super(owner, model)
		this.title = "EventOS - Usuario"
	}

	override createFormPanel(Panel mainPanel) {
		new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
			agregarNombreValor("Username:", "username")
			agregarNombreValor("Nombre:", "nombre")
			agregarNombreValor("Apellido:", "apellido")
			agregarNombreValor("email:", "email")
			agregarNombreValor("Tipo:", "tipo")
			agregarNombreValor("Fecha de nacimiento:", "nacimiento")
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
	
}
