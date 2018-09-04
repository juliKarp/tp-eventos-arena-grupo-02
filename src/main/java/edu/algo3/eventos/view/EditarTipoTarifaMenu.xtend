package edu.algo3.eventos.view

import edu.algo3.eventos.model.EditorTipoTarifa
import org.uqbar.arena.aop.windows.TransactionalDialog
import org.uqbar.arena.bindings.ObservableProperty
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.Selector
import org.uqbar.arena.widgets.TextBox

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class EditarTipoTarifaMenu extends TransactionalDialog<EditorTipoTarifa> {
	
	new(EditarServicioMenu owner, EditorTipoTarifa model) {
		super(owner, model)
		this.title = "EventOS - Tipo Tarifa"
	}

	override createFormPanel(Panel mainPanel) {
		new Panel(mainPanel) => [
			agregarValorFijo("Tipo de tarifa anterior:", "servicio.tipoTarifa")
			agregarSeleccionable("Tipo de usuario:", "tipoTarifaPosibles", "tipoTarifaSeleccionado")
			agregarNombreValor("Porcentaje mínimo:", "valor")
		]
	}

	override addActions(Panel actions) {
		new Button(actions) => [
			caption = "Cancelar"	
			onClick [this.cancel]
		]
		
		new Button(actions) => [
			caption = "Guardar"
			onClick [
				this.modelObject.servicio.tipoTarifa = this.modelObject.crearTipoTarifa
				this.accept
			]
			disableOnError	
		]
	}
	
	def agregarValorFijo(Panel panel, String nombre, String valor) {
		var valorPanel = new Panel(panel)
		valorPanel.layout = new VerticalLayout
		new Label(valorPanel) => [
			text = nombre
			width = 100
			alignLeft
		]
		new Label(valorPanel) => [
			value <=> valor
			width = 200
			alignLeft
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
			bindItems(new ObservableProperty(this.modelObject, valores))
			value <=> valor
			width = 185
		]
	}
}
