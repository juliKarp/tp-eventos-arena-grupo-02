package edu.algo3.eventos.view

import edu.algo2.eventos.Usuario
import edu.algo2.repositorio.RepoUsuarios
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

class EditarUsuarioMenu extends TransactionalDialog<Usuario> {

	new(GestionUsuariosMenu owner, Usuario model) {
		super(owner, model)
		this.title = "EventOS - Usuario"
	}

	override createFormPanel(Panel mainPanel) {
		new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
			agregarNombreValor("Username:", "nombreUsuario")
			agregarNombreValor("Nombre y apellido:", "nombreApellido")
			agregarNombreValor("email:", "email")
			agregarFecha("Fecha de nacimiento:", "fechaNacimiento")
			agregarSeleccionable("Tipo de usuario:", "tiposUsuarioPosibles", "tipoDeUsuario")
			agregarPunto("Direccion:", "direccion")
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
			bindItems(new ObservableProperty(repoUsuarios, valores))
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
	
	def RepoUsuarios getRepoUsuarios() {
		ApplicationContext.instance.getSingleton(typeof(Usuario))
	}
}
