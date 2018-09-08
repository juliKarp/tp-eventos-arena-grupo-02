package edu.algo3.eventos.view

import edu.algo2.repositorio.Entidad
import edu.algo2.repositorio.Repositorio
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
import org.uqbar.lacar.ui.model.Action

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

abstract class EditarMenu<T extends Entidad> extends TransactionalDialog<T> {

	new(GestionMenu<T> owner, T model) {
		super(owner, model)
	}

	override createFormPanel(Panel mainPanel) {
		new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
			agregarCampos()
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

	def void agregarFecha(Panel panel, String nombre, String valor) {
		var valorPanel = new Panel(panel)
		valorPanel.layout = new VerticalLayout
		new Label(valorPanel) => [
			text = nombre
			width = 100
			alignLeft
		]
		new TextBox(valorPanel) => [
			(value <=> valor).transformer = new LocalDateTransformer
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
			bindItems(new ObservableProperty(repositorio, valores))
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

	def agregarValorFijo(Panel panel, String nombre, String valor) {
		var valorPanel = new Panel(panel)
		valorPanel.layout = new VerticalLayout
		new Label(valorPanel) => [
			text = nombre
			width = 200
			alignLeft
		]
		new Label(valorPanel) => [
			value <=> valor
			width = 200
			alignLeft
		]
	}

	def agregarBoton(Panel panel, String nombre, Action onClick) {
		new Button(panel) => [
			caption = nombre
			onClick(onClick)
			height = 90 //fix invisible
		]
		
	}

	def Repositorio<T> getRepositorio() {
		ApplicationContext.instance.getSingleton(tipoDeElemento)
	}

	def void agregarCampos(Panel panel)

	def Class<T> tipoDeElemento()
}
