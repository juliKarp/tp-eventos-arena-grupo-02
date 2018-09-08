package edu.algo3.eventos.view

import edu.algo2.repositorio.Entidad
import edu.algo3.eventos.model.GestionModel
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Window
import org.uqbar.arena.windows.WindowOwner
import org.uqbar.commons.model.utils.ObservableUtils

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

abstract class GestionMenu<T extends Entidad> extends Window<GestionModel<T>> {

	new(WindowOwner owner, GestionModel<T> model) {
		super(owner, model)
	}

	def aplicacion() {
		mainMenu.aplicacion
	}

	def mainMenu() {
		this.owner as MainMenu
	}

	override createContents(Panel mainPanel) {
		mainPanel => [
			layout = new HorizontalLayout
			agregarTablaElementos
			agregarPanelOpciones
		]
	}

	def void agregarTablaElementos(Panel panel) {
		new Table<T>(panel, this.modelObject.tipoDeElemento) => [
			items <=> "elementos"
			value <=> "seleccionado"
			numberVisibleRows = 10
			agregarColumnas()
		]
	}

	def void agregarColumna(Table<T> tabla, String titulo, String valor) {
		new Column<T>(tabla) => [
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
				bindEnabled(new NotNullObservable("seleccionado"))
				onClick[
					this.editar(this.modelObject.seleccionado)
					this.actualizar
				]
			]

			new Button(it) => [
				caption = "Elimiar"
				bindEnabled(new NotNullObservable("seleccionado"))
				onClick[
					this.modelObject.repositorio.delete(this.modelObject.seleccionado)
					this.actualizar
				]
			]

			new Button(it) => [
				caption = "Nuevo"
				onClick[
					this.nuevo
					this.actualizar
				]
			]

			new Button(it) => [
				caption = "Update masivo"
				onClick[
					this.modelObject.repositorio.updateAll
					this.actualizar
				]
			]
		]
	}

	def actualizar() {
		ObservableUtils.firePropertyChanged(this.modelObject, "elementos")
		this.mainMenu.actualizar
	}

	def void agregarColumnas(Table<T> tabla)

	def void editar(T seleccionado)

	def void nuevo()

}
