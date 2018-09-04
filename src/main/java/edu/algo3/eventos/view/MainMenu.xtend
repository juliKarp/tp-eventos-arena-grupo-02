package edu.algo3.eventos.view

import edu.algo2.eventos.Locacion
import edu.algo2.eventos.Servicio
import edu.algo2.eventos.Usuario
import edu.algo3.eventos.model.Estadisticas
import edu.algo3.eventos.runnable.EventOSApplication
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
import org.uqbar.commons.model.utils.ObservableUtils

import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*

class MainMenu extends Window<Estadisticas> {

	new(WindowOwner owner, Estadisticas model) {
		super(owner, model)
		this.title = "EventOS"
	}

	override createContents(Panel mainPanel) {
		
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
	def actualizar(){
		ObservableUtils.firePropertyChanged(this.modelObject, "usuariosActivos")
		ObservableUtils.firePropertyChanged(this.modelObject, "locacionesPopulares")
		ObservableUtils.firePropertyChanged(this.modelObject, "serviciosNuevos")
	}

	def void agregarPanelEstadisticas(Panel panel) {
		new GroupPanel(panel) => [
			title = "Estadísticas:"
			agregarNombreValor("Cantidad total de eventos:", "cantidadEventos")
			agregarNombreValor("Eventos último mes:", "cantidadEventosDelMes")
			agregarNombreValor("Eventos exitosos:", "cantidadEventosExitosos")
			agregarNombreValor("Eventos fracasados:", "cantidadEventosFracasados")
			agregarNombreValor("Entradas vendidas:", "cantidadEntradasVendidas")
			agregarNombreValor("Invitaciones enviadas:", "cantidadInvitacionesEnviadas")
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
			items <=> "usuariosActivos"
			numberVisibleRows = 6
			agregarColumna("Username", "nombreUsuario", 100)
			agregarColumna("Nombre y apellido", "nombreApellido", 200)
		]
		
		new Button(usuariosPanel) => [
			caption = "Gestión de Usuarios"
			onClick[aplicacion.gestionDeUsuarios(this)]
		]
	}
	
	def void agregarPanelLocaciones(Panel panel) {
		var locacionesPanel = new GroupPanel(panel) => [
			title = "Locaciones más populares:"
			layout = new VerticalLayout
		]

		new Table<Locacion>(locacionesPanel, typeof(Locacion)) => [
			items <=> "locacionesPopulares"
			numberVisibleRows = 6
			agregarColumna("Nombre", "nombre", 200)
			agregarColumna("Capacidad", "capacidadMaxima", 100)
		]
		
		new Button(locacionesPanel) => [
			caption = "Gestión de Locaciones"
			onClick[aplicacion.gestionDeLocaciones(this)]
		]
	}
	
	def void agregarPanelServicios(Panel panel) {
		var serviciosPanel = new GroupPanel(panel) => [
			title = "Últimos Servicios:"
			layout = new VerticalLayout
		]

		new Table<Servicio>(serviciosPanel, typeof(Servicio)) => [
			items <=> "serviciosNuevos"
			numberVisibleRows = 6
			agregarColumna("Nombre", "descripcion", 200)
			agregarColumna("Tarifa", "tarifa", 100)
		]
		
		new Button(serviciosPanel) => [
			caption = "Gestión de Servicios"
			onClick[aplicacion.gestionDeServicios(this)]
			width = 320
		]
	}

	def void agregarColumna(Table<?> tabla, String titulo, String valor, Integer size) {
		new Column(tabla) => [
			title = titulo
			bindContentsToProperty(valor)
			fixedSize = size
		]
	}
}
