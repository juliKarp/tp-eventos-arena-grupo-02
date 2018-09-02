package edu.algo3.eventos.view

import edu.algo2.eventos.Locacion
import edu.algo2.repositorio.RepoLocaciones
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.TextBox
import org.uqbar.commons.applicationContext.ApplicationContext

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class EditarLocacionMenu extends TransactionalDialog<Locacion> {

	new(GestionLocacionesMenu owner, Locacion model) {
		super(owner, model)
		this.title = "EventOS - Locacion"
	}

	override createFormPanel(Panel mainPanel) {
		new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
			agregarNombreValor("Nombre:", "nombre")
			agregarNombreValor("Superficie", "superficie")
			agregarPunto("Ubicacion:", "ubicacion")
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
	
	def void agregarPunto(Panel panel, String nombre, String valor) {
		var valorPanel = new Panel(panel)
		valorPanel.layout = new VerticalLayout
		new Label(valorPanel) => [
			text = nombre
			width = 100
			alignLeft
		]
		new TextBox(valorPanel) => [
			(value <=> valor).transformer = new PointTransformer
			width = 200
			alignLeft
		]
	}
	
	def RepoLocaciones getRepoLocaciones() {
		ApplicationContext.instance.getSingleton(typeof(Locacion))
	}
}
