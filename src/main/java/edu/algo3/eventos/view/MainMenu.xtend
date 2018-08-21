package edu.algo3.eventos.view

import edu.algo3.eventos.model.Estadisticas
import edu.algo3.eventos.model.Usuario
import org.uqbar.arena.layout.ColumnLayout
import org.uqbar.arena.layout.HorizontalLayout
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.Button
import org.uqbar.arena.widgets.GroupPanel
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.windows.Window
import org.uqbar.arena.windows.WindowOwner

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class MainMenu extends Window<Estadisticas> {

	new(WindowOwner owner, Estadisticas model) {
		super(owner, model)
	}

	override createContents(Panel mainPanel) {
		this.title = "EventOS"
		mainPanel.layout = new VerticalLayout
		
		new Panel(mainPanel) => [
			layout = new ColumnLayout(2)
			agregarPanelEstadisticas
			agregarPanelUsuarios
			agregarPanelLocaciones
			agregarPanelServicios
			new Label(it)
		]
	}
	
	def aplicacion() {
		this.owner as EventOSApplication
	}

	def void agregarPanelEstadisticas(Panel panel) {
		new GroupPanel(panel) => [
			title = "Estadísticas:"
			agregarNombreValor("Cantidad total de eventos:", "valor")
			agregarNombreValor("Eventos último mes:", "valor")
			agregarNombreValor("Eventos exitosos:", "valor")
			agregarNombreValor("Eventos fracasados:", "valor")
			agregarNombreValor("Entradas vendidas:", "valor")
			agregarNombreValor("Invitaciones enviadas:", "valor")
			layout = new VerticalLayout
		]
	}

	def void agregarNombreValor(Panel panel, String nombre, String valor) {
		var valorPanel = new Panel(panel)
		valorPanel.layout = new HorizontalLayout
		new Label(valorPanel) => [
			text = nombre
			width = 240
			alignLeft
		]
		new Label(valorPanel) => [
			value <=> valor
			width = 60
			alignLeft
		]
	}

	def void agregarPanelUsuarios(Panel panel) {
		var usuariosPanel = new GroupPanel(panel) => [
			title = "Usuarios más activos:"
			layout = new VerticalLayout
		]

		new Table<Usuario>(usuariosPanel, typeof(Usuario)) => [
			items <=> "usuarios"
			numberVisibleRows = 5
			agregarColumnaUsuarios("Username", "username")
			agregarColumnaUsuarios("Nombre", "nombre")
			agregarColumnaUsuarios("Apellido", "apellido")
		]
		new Button(usuariosPanel) => [
			caption = "Gestión de Usuarios"
			onClick[aplicacion.gestionDeUsuariosWindow()]
		]
	}
	
	def void agregarColumnaUsuarios(Table<Usuario> tabla, String titulo, String valor) {
		new Column<Usuario>(tabla) => [
			title = titulo
			bindContentsToProperty(valor)
			fixedSize = 100
		]
	}

	def void agregarPanelLocaciones(Panel panel) {
		var locacionesPanel = new GroupPanel(panel) => [
			title = "Locaciones más populares:"
			layout = new VerticalLayout
		]

		new Table<Usuario>(locacionesPanel, typeof(Usuario)) => [
			items <=> "usuarios"
			numberVisibleRows = 5
			agregarColumnaLocaciones("Nombre", "nombre")
			agregarColumnaLocaciones("Capacidad", "apellido")
		]
		new Button(locacionesPanel) => [
			caption = "Gestión de Locaciones"
			onClick[this.modelObject.sumarEstadistica]
		]
	}
	
	def void agregarColumnaLocaciones(Table<Usuario> tabla, String titulo, String valor) {
		new Column<Usuario>(tabla) => [
			title = titulo
			bindContentsToProperty(valor)
			fixedSize = 150
		]
	}
	
	def void agregarPanelServicios(Panel panel) {
		var serviciosPanel = new GroupPanel(panel) => [
			title = "Últimos Servicios:"
			layout = new VerticalLayout
		]

		new Table<Usuario>(serviciosPanel, typeof(Usuario)) => [
			items <=> "usuarios"
			numberVisibleRows = 5
			agregarColumnaLocaciones("Nombre", "nombre")
			agregarColumnaLocaciones("Tarifa", "apellido")
		]
		new Button(serviciosPanel) => [
			caption = "Gestión de Servicios"
			onClick[this.modelObject.sumarEstadistica]
		]
	}
	
	def void agregarColumnaServicios(Table<Usuario> tabla, String titulo, String valor) {
		new Column<Usuario>(tabla) => [
			title = titulo
			bindContentsToProperty(valor)
			fixedSize = 150
		]
	}
}
