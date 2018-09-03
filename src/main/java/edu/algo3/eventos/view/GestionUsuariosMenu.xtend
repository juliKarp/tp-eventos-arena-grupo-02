package edu.algo3.eventos.view

import edu.algo2.eventos.Usuario
import edu.algo2.repositorio.RepoUsuarios
import edu.algo3.eventos.model.Usuarios
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Window
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.commons.model.utils.ObservableUtils

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import edu.algo3.eventos.runnable.Actualizacion

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
		mainMenu.aplicacion
	}
	
	def mainMenu() {
		this.owner as MainMenu
	}

	def void agregarTablaUsuarios(Panel panel) {

		new Table<Usuario>(panel, typeof(Usuario)) => [
			items <=> "usuarios"
			value <=> "usuarioSeleccionado"
			numberVisibleRows = 6
			agregarColumna("Username", "nombreUsuario")
			agregarColumna("Nombre y apellido", "nombreApellido")
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
				onClick[
					aplicacion.editarUsuario(this, this.modelObject.usuarioSeleccionado)
					this.actualizar
					this.mainMenu.actualizar
				]
			]

			new Button(it) => [
				caption = "Elimiar"
				bindEnabled(new NotNullObservable("usuarioSeleccionado"))
				onClick[
					repoUsuarios.delete(this.modelObject.usuarioSeleccionado)
					this.actualizar
					this.mainMenu.actualizar
				]
			]

			new Button(it) => [
				caption = "Nuevo usuario"
				onClick[
					aplicacion.nuevoUsuario(this)
					this.actualizar
					this.mainMenu.actualizar
				]
			]

			new Button(it) => [
				caption = "Update masivo"
				onClick[
					this.repoUsuarios.procesarListaJson(actualizacion.actualizacionUsuarios)
					this.actualizar
					this.mainMenu.actualizar
				]
			]
		]
	}
	def actualizar() {
		ObservableUtils.firePropertyChanged(this.modelObject, "usuarios")
	}
	def RepoUsuarios getRepoUsuarios() {
		ApplicationContext.instance.getSingleton(typeof(Usuario))
	}
	
	def Actualizacion getActualizacion() {
		ApplicationContext.instance.getSingleton(typeof(Actualizacion))
	}
}
