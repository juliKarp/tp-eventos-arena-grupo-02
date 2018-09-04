package edu.algo3.eventos.view

import edu.algo2.eventos.Servicio
import edu.algo2.repositorio.RepoServicios
import edu.algo3.eventos.model.Servicios
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

class GestionServiciosMenu extends Window<Servicios> {

	new(MainMenu owner, Servicios model) {
		super(owner, model)
		this.title = "EventOS - Gestión de Servicios"
	}

	override createContents(Panel mainPanel) {
		mainPanel => [
			layout = new HorizontalLayout
			agregarTablaServicios
			agregarPanelOpciones
		]
	}
	
	def aplicacion() {
		mainMenu.aplicacion
	}
	
	def mainMenu() {
		this.owner as MainMenu
	}

	def void agregarTablaServicios(Panel panel) {

		new Table<Servicio>(panel, typeof(Servicio)) => [
			items <=> "servicios"
			value <=> "servicioSeleccionado"
			numberVisibleRows = 6
			agregarColumna("Servicio", "descripcion")
			agregarColumna("Tarifa", "tarifa")
		]

	}

	def void agregarColumna(Table<Servicio> tabla, String titulo, String valor) {
		new Column<Servicio>(tabla) => [
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
				bindEnabled(new NotNullObservable("servicioSeleccionado"))
				onClick[
					aplicacion.editarServicio(this, this.modelObject.servicioSeleccionado)
					this.actualizar
					this.mainMenu.actualizar
				]
			]

			new Button(it) => [
				caption = "Elimiar"
				bindEnabled(new NotNullObservable("servicioSeleccionado"))
				onClick[
					repoServicios.delete(this.modelObject.servicioSeleccionado)
					this.actualizar
					this.mainMenu.actualizar
				]
			]

			new Button(it) => [
				caption = "Nuevo servicio"
				onClick[
					aplicacion.nuevoServicio(this)
					this.actualizar
					this.mainMenu.actualizar
				]
			]

			new Button(it) => [
				caption = "Update masivo"
				onClick[
					this.repoServicios.updateAll
					this.actualizar
					this.mainMenu.actualizar
				]
			]
		]
	}
	def actualizar() {
		ObservableUtils.firePropertyChanged(this.modelObject, "servicios")
	}
	def RepoServicios getRepoServicios() {
		ApplicationContext.instance.getSingleton(typeof(Servicio))
	}
}
