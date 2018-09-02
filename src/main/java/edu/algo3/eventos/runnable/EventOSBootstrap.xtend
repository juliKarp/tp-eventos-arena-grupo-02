package edu.algo3.eventos.runnable

import edu.algo2.eventos.Entrada
import edu.algo2.eventos.EventoAbierto
import edu.algo2.eventos.EventoCerrado
import edu.algo2.eventos.Invitacion
import edu.algo2.eventos.Locacion
import edu.algo2.eventos.Servicio
import edu.algo2.eventos.TarifaFija
import edu.algo2.eventos.TarifaPorHora
import edu.algo2.eventos.TarifaPorPersona
import edu.algo2.eventos.Usuario
import edu.algo2.repositorio.RepoLocaciones
import edu.algo2.repositorio.RepoServicios
import edu.algo2.repositorio.RepoUsuarios
import java.time.LocalDate
import java.time.LocalDateTime
import java.time.temporal.ChronoUnit
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.arena.bootstrap.CollectionBasedBootstrap
import org.uqbar.commons.applicationContext.ApplicationContext
import org.uqbar.geodds.Point

class EventOSBootstrap extends CollectionBasedBootstrap {
	
	new() {
		ApplicationContext.instance.configureSingleton(typeof(Usuario), new RepoUsuarios)
		ApplicationContext.instance.configureSingleton(typeof(Locacion), new RepoLocaciones)
		ApplicationContext.instance.configureSingleton(typeof(Servicio), new RepoServicios)
		ApplicationContext.instance.configureSingleton(typeof(Actualizacion), new Actualizacion)
		
	}

	override run() {
		val repoUsuarios = ApplicationContext.instance.getSingleton(typeof(Usuario)) as RepoUsuarios
		val repoLocaciones = ApplicationContext.instance.getSingleton(typeof(Locacion)) as RepoLocaciones
		val repoServicios = ApplicationContext.instance.getSingleton(typeof(Servicio)) as RepoServicios

		repoUsuarios => [
			create(new Usuario("lucas_capo", tipoUsuarioAmateur) => [
				fechaNacimiento = LocalDate.now.minus(25, ChronoUnit.YEARS)
				direccion = new Point(-35, -60)
				nombreApellido = "Lucas Lopez"
				email = "lucas_93@hotmail.com"
			])
			create(new Usuario("martin1990", tipoUsuarioFree) => [
				fechaNacimiento = LocalDate.now.minus(28, ChronoUnit.YEARS)
				direccion = new Point(-35, -60)
				nombreApellido = "Martín Varela"
				email = "martinvarela90@yahoo.com"
			])
		]

		repoLocaciones => [
			create(new Locacion("Salón El Abierto", -34.603759, -58.381586, 200.0))
			create(new Locacion("Estadio Obras", -34.572224, -58.535651, 2000.0))
		]

		repoServicios => [
			create(new Servicio("Fotografos unidos", new Point(-34, -51), 1000.0) => [
				tipoTarifa = new TarifaFija
			])
			create(new Servicio("Show en vivo", new Point(-34, -51), 1000.0) => [
				tipoTarifa = new TarifaPorHora
			])
			create(new Servicio("Catering Food Party", new Point(-34, -51), 1000.0) => [
				tipoTarifa = new TarifaPorPersona => [porcentajeMinimo = 0.1]
			])
		]
		
		
		val locacion = new Locacion("Casa de Fiesta", -35, -59, 20.0)

		val eventoAbierto = new EventoAbierto("La Fiesta", locacion) => [
			fechaMaximaConfirmacion = LocalDateTime.now.plus(10, ChronoUnit.DAYS)
			fechaDesde = LocalDateTime.now.plus(16, ChronoUnit.DAYS)
			fechaHasta = LocalDateTime.now.plus(18, ChronoUnit.DAYS).minus(1, ChronoUnit.HOURS)
			precio = 350.50
			edadMinima = 12
			organizador = repoUsuarios.elementos.get(0)
			repoUsuarios.elementos.get(0).eventos.add(it)
		]

		val eventoCerrado = new EventoCerrado("La Fiesta Privada", locacion) => [
			fechaMaximaConfirmacion = LocalDateTime.now.plus(10, ChronoUnit.DAYS)
			fechaDesde = LocalDateTime.now.plus(16, ChronoUnit.DAYS)
			fechaHasta = LocalDateTime.now.plus(18, ChronoUnit.DAYS).minus(1, ChronoUnit.HOURS)
			capacidadMaxima = 10
			organizador = repoUsuarios.elementos.get(1)
			repoUsuarios.elementos.get(1).eventos.add(it)
		]

		val invitacionAceptada = new Invitacion(eventoCerrado, repoUsuarios.elementos.get(0), 5) => [aceptada = true]
		eventoCerrado.invitaciones.add(invitacionAceptada)
		
		val invitacionRechazada = new Invitacion(eventoCerrado, repoUsuarios.elementos.get(1), 5) => [rechazada = true]
		eventoCerrado.invitaciones.add(invitacionRechazada)
		
		val entrada = new Entrada(eventoAbierto, repoUsuarios.elementos.get(1))
		eventoAbierto.entradasVendidas.add(entrada)

	}
}

@Accessors
class Actualizacion {
	val actualizacionUsuarios = '[{"nombreUsuario":"nose","nombreApellido":"El Que no sabe","email":"no_se@hotmail.com","fechaNacimiento":"15/01/1992","direccion":{"calle":"25 de Mayo","numero":3918,"localidad":"San Martín","provincia":"Buenos Aires","coordenadas":{"x":-34.572224,"y":51.535651}}},{"nombreUsuario":"martin1990","nombreApellido":"Martín Varela","email":"otromail@yahoo.com","fechaNacimiento":"18/11/1990","direccion":{"calle":"Av. Triunvirato","numero":4065,"localidad":"CABA","provincia":"","coordenadas":{"x":-33.58236,"y":60.516598}}}]'
	val actualizacionLocaciones = '[{"x":-34.603759,"y":-58.381586,"nombre":"El quinchito","superficie":150.00},{"x":-34.603759,"y":-60.381586,"nombre":"Salón El Abierto"},{"x":-34.572224,"y":-58.535651,"nombre":"Estadio Obras"}]'
	val actualizacionServicios = '[{"descripcion":"Catering Re Loco","tarifaServicio":{"tipo":"TPH","valor":1000.00,"minimo":3500.00},"tarifaTraslado":30.00,"ubicacion":{"x":-34.572224,"y":58.535651}},{"descripcion":"Catering Food Party","tarifaServicio":{"tipo":"TF","valor":5000.00},"tarifaTraslado":30.00,"ubicacion":{"x":-34.572224,"y":58.535651}}]'
}
