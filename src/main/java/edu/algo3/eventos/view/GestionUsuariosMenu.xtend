package edu.algo3.eventos.view

import edu.algo3.eventos.model.Usuario
import edu.algo3.eventos.model.Usuarios
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Window

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class GestionUsuariosMenu extends Window<Usuarios> {

	new(MainMenu owner, Usuarios model) {
		super(owner, model)
		this.title = "EventOS - Gestión de Usuarios"
	}

	override createContents(Panel mainPanel) {
		mainPanel => [
			layout = new HorizontalLayout
			agregarTablaUsuarios
			agregarPanelOpciones
		]
	}
	
	def aplicacion() {
		(this.owner as MainMenu).aplicacion
	}

	def void agregarTablaUsuarios(Panel panel) {

		new Table<Usuario>(panel, typeof(Usuario)) => [
			items <=> "usuarios"
			value <=> "usuarioSeleccionado"
			numberVisibleRows = 6
			agregarColumna("Username", "username")
			agregarColumna("Nombre", "nombre")
			agregarColumna("Apellido", "apellido")
			agregarColumna("email", "email")
		]

	}

	def void agregarColumna(Table<Usuario> tabla, String titulo, String valor) {
		new Column<Usuario>(tabla) => [
			title = titulo
			bindContentsToProperty(valor)
			fixedSize = 100
		]
	}

	def void agregarPanelOpciones(Panel panel) {
		new Panel(panel) => [
			layout = new VerticalLayout
			new Button(it) => [
				caption = "Editar"
				bindEnabled(new NotNullObservable("usuarioSeleccionado"))
				onClick[aplicacion.editarUsuario(this, this.modelObject.usuarioSeleccionado)]
			]

			new Button(it) => [
				caption = "Elimiar"
				bindEnabled(new NotNullObservable("usuarioSeleccionado"))
				onClick[this.modelObject.eliminarUsuarioSeleccionado]
			]

			new Button(it) => [
				caption = "Nuevo usuario"
				onClick[]
			]

			new Button(it) => [
				caption = "Update masivo"
				onClick[]
			]
		]
	}
}
