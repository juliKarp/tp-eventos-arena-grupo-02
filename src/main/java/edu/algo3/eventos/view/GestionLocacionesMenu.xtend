package edu.algo3.eventos.view

import edu.algo2.eventos.Locacion
import edu.algo2.repositorio.RepoLocaciones
import edu.algo3.eventos.model.Locaciones
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

class GestionLocacionesMenu extends Window<Locaciones> {

	new(MainMenu owner, Locaciones model) {
		super(owner, model)
		this.title = "EventOS - Gestión de Locaciones"
	}

	override createContents(Panel mainPanel) {
		mainPanel => [
			layout = new HorizontalLayout
			agregarTablaLocaciones
			agregarPanelOpciones
		]
	}
	
	def aplicacion() {
		mainMenu.aplicacion
	}
	
	def mainMenu() {
		this.owner as MainMenu
	}

	def void agregarTablaLocaciones(Panel panel) {

		new Table<Locacion>(panel, typeof(Locacion)) => [
			items <=> "locaciones"
			value <=> "locacionSeleccionada"
			numberVisibleRows = 6
			agregarColumna("Nombre", "nombre")
			agregarColumna("Capacidad máxima", "capacidadMaxima")
		]

	}

	def void agregarColumna(Table<Locacion> tabla, String titulo, String valor) {
		new Column<Locacion>(tabla) => [
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
				bindEnabled(new NotNullObservable("locacionSeleccionada"))
				onClick[
					aplicacion.editarLocacion(this, this.modelObject.locacionSeleccionada)
					this.actualizar
					this.mainMenu.actualizar
				]
			]

			new Button(it) => [
				caption = "Eliminar"
				bindEnabled(new NotNullObservable("locacionSeleccionada"))
				onClick[
					repoLocaciones.delete(this.modelObject.locacionSeleccionada)
					this.actualizar
					this.mainMenu.actualizar
				]
			]

			new Button(it) => [
				caption = "Nueva Locacion"
				onClick[
					aplicacion.nuevaLocacion(this)
					this.actualizar
					this.mainMenu.actualizar
				]
			]

			new Button(it) => [
				caption = "Update masivo"
				onClick[
					this.repoLocaciones.updateAll
					this.actualizar
					this.mainMenu.actualizar
				]
			]
		]
	}
	def actualizar() {
		ObservableUtils.firePropertyChanged(this.modelObject, "locaciones")
	}
	def RepoLocaciones getRepoLocaciones() {
		ApplicationContext.instance.getSingleton(typeof(Locacion))
	}
}
