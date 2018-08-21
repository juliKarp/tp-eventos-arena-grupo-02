package edu.algo3.eventos.view

import edu.algo3.eventos.model.Usuario
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.arena.windows.Window
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class EditarUsuarioMenu extends Window<Usuario> {

	new(WindowOwner owner, Usuario model) {
		super(owner, model)
	}

	override createContents(Panel mainPanel) {
		this.title = "EventOS - Usuario"
		mainPanel => [
			layout = new ColumnLayout(2)
			agregarNombreValor("Username:", "username")
			agregarNombreValor("Nombre:", "nombre")
			agregarNombreValor("Apellido:", "apellido")
			agregarNombreValor("email:", "email")
			agregarNombreValor("Tipo:", "tipo")
			agregarNombreValor("Fecha de nacimiento:", "nacimiento")
			new Button(it) => [
				caption = "Cancelar"
				onClick[this.close]
			]

			new Button(it) => [
				caption = "Guardar"
				onClick[]
			]
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
