package edu.algo3.eventos.view

import edu.algo2.eventos.Servicio
import edu.algo2.repositorio.RepoServicios
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox
import org.uqbar.commons.applicationContext.ApplicationContext

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class EditarServicioMenu extends TransactionalDialog<Servicio> {

	new(GestionServiciosMenu owner, Servicio model) {
		super(owner, model)
		this.title = "EventOS - Servicio"
	}

	override createFormPanel(Panel mainPanel) {
		new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
			agregarNombreValor("Descripcion:", "descripcion")
//			agregarSeleccionable("Tipo de tarifa:", "tiposTarifaPosibles", "tipoTarifa")
			agregarNombreValor("Tarifa:", "tarifa")
			agregarPunto("Ubicación:", "ubicacion")
			agregarNombreValor("Tarifa por km:", "tarifaPorKm")
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
	
	def agregarSeleccionable(Panel panel, String nombre, String valores, String valor) {
		var valorPanel = new Panel(panel)
		valorPanel.layout = new VerticalLayout
		new Label(valorPanel) => [
			text = nombre
			width = 100
			alignLeft
		]
		new Selector(valorPanel) => [
			allowNull(false)
			bindItems(new ObservableProperty(repoServicios, valores))
			value <=> valor
			width = 185
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
	
	def RepoServicios getRepoServicios() {
		ApplicationContext.instance.getSingleton(typeof(Servicio))
	}
}
