package edu.algo3.eventos.runnable

import edu.algo2.eventos.EventoAbierto
import edu.algo2.eventos.EventoCerrado
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

		val locacion1 = new Locacion("Casa de Fiesta", -35, -59, 20.0)
		val locacion2 = new Locacion("Salón El Abierto", -34.603759, -58.381586, 200.0)
		val locacion3 = new Locacion("Estadio Obras", -34.572224, -58.535651, 2000.0)
		val locacion4 = new Locacion("Saloncito", -34.603759, -58.381586, 200.0)
		val locacion5 = new Locacion("Castillo para eventos", -34.603759, -58.381586, 200.0)
		val locacion6 = new Locacion("Tropitango", -34.603759, -58.381586, 200.0)

		val lucas_capo = new Usuario("lucas_capo", repoUsuarios.tipoUsuarioAmateur) => [
			fechaNacimiento = LocalDate.now.minus(25, ChronoUnit.YEARS)
			direccion = new Point(-35, -60)
			nombreApellido = "Lucas Lopez"
			email = "lucas_93@hotmail.com"
			radioCercania = 100.00
		]
		val martin1990 = new Usuario("martin1990", repoUsuarios.tipoUsuarioProfesional) => [
			fechaNacimiento = LocalDate.now.minus(28, ChronoUnit.YEARS)
			direccion = new Point(-35, -60)
			nombreApellido = "Martín Varela"
			email = "martinvarela90@yahoo.com"
			radioCercania = 100.00
		]
		val elBarto = new Usuario("elBarto", repoUsuarios.tipoUsuarioFree) => [
			fechaNacimiento = LocalDate.now.minus(10, ChronoUnit.YEARS)
			direccion = new Point(-35, -60)
			nombreApellido = "Bart Simpson"
			email = "elbarto@gmail.com"
			radioCercania = 100.00
		]
		val elHomo = new Usuario("elHomo", repoUsuarios.tipoUsuarioFree) => [
			fechaNacimiento = LocalDate.now.minus(45, ChronoUnit.YEARS)
			direccion = new Point(-35, -60)
			nombreApellido = "Homero Simpson"
			email = "homerosimpson@gmail.com"
			radioCercania = 100.00
		]
		val usuarioOrganizador = new Usuario("elOrganizer", repoUsuarios.tipoUsuarioProfesional) => [
			fechaNacimiento = LocalDate.now.minus(28, ChronoUnit.YEARS)
			direccion = new Point(-35, -60)
			nombreApellido = "Ricardo Montaner"
			email = "ricardito@yahoo.com"
			radioCercania = 100.00
		]
		val usuarioSolitario = new Usuario("elEmo", repoUsuarios.tipoUsuarioProfesional) => [
			fechaNacimiento = LocalDate.now.minus(28, ChronoUnit.YEARS)
			direccion = new Point(-35, -60)
			nombreApellido = "Emilio Solano"
			email = "solito@yahoo.com"
		]
		repoUsuarios => [
			create(usuarioOrganizador)
			create(lucas_capo)
			create(martin1990)
			create(elBarto)
			create(elHomo)
			create(usuarioSolitario)
		]

		repoLocaciones => [
			create(locacion1)
			create(locacion2)
			create(locacion3)
			create(locacion4)
			create(locacion5)
			create(locacion6)
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

		val fiesta = new EventoAbierto("La Fiesta", locacion1) => [
			fechaMaximaConfirmacion = LocalDateTime.now.plus(10, ChronoUnit.DAYS)
			fechaDesde = LocalDateTime.now.plus(16, ChronoUnit.DAYS)
			fechaHasta = LocalDateTime.now.plus(18, ChronoUnit.DAYS).minus(1, ChronoUnit.HOURS)
			precio = 350.50
			edadMinima = 12
		]
		lucas_capo.organizarEventoAbierto(fiesta)
		fiesta.nuevaEntrada(elHomo)
		fiesta.nuevaEntrada(martin1990)
		
		val privada = new EventoCerrado("La Fiesta Privada", locacion1) => [
			fechaMaximaConfirmacion = LocalDateTime.now.plus(10, ChronoUnit.DAYS)
			fechaDesde = LocalDateTime.now.plus(16, ChronoUnit.DAYS)
			fechaHasta = LocalDateTime.now.plus(18, ChronoUnit.DAYS).minus(1, ChronoUnit.HOURS)
			capacidadMaxima = 100
		]
		martin1990.organizarEventoCerrado(privada)
		privada.nuevaInvitacion(lucas_capo,5)
		privada.nuevaInvitacion(martin1990,5)

		val fiestita = new EventoCerrado("La Fiestita", locacion6) => [
			fechaMaximaConfirmacion = LocalDateTime.now.plus(10, ChronoUnit.DAYS)
			fechaDesde = LocalDateTime.now.plus(16, ChronoUnit.DAYS)
			fechaHasta = LocalDateTime.now.plus(18, ChronoUnit.DAYS).minus(1, ChronoUnit.HOURS)
			capacidadMaxima = 100
		]
		usuarioOrganizador.organizarEventoCerrado(fiestita)
		fiestita.nuevaInvitacion(lucas_capo,5)
		fiestita.nuevaInvitacion(martin1990,5)
		fiestita.nuevaInvitacion(elBarto,5)
		fiestita.nuevaInvitacion(elHomo,5)
		
		lucas_capo.invitaciones.forEach[aceptarInvitacion(5)]
		martin1990.invitaciones.forEach[aceptarInvitacion(5)]
		elBarto.invitaciones.forEach[aceptarInvitacion(5)]
		elHomo.invitaciones.forEach[aceptarInvitacion(5)]
	}
}

@Accessors
class Actualizacion {
	val actualizacionUsuarios = '[{"nombreUsuario":"nose","nombreApellido":"El Que no sabe","email":"no_se@hotmail.com","fechaNacimiento":"15/01/1992","direccion":{"calle":"25 de Mayo","numero":3918,"localidad":"San Martín","provincia":"Buenos Aires","coordenadas":{"x":-34.572224,"y":51.535651}}},{"nombreUsuario":"martin1990","nombreApellido":"Martín Varela","email":"otromail@yahoo.com","fechaNacimiento":"18/11/1990","direccion":{"calle":"Av. Triunvirato","numero":4065,"localidad":"CABA","provincia":"","coordenadas":{"x":-33.58236,"y":60.516598}}}]'
	val actualizacionLocaciones = '[{"x":-34.603759,"y":-58.381586,"nombre":"El quinchito","superficie":150.00},{"x":-34.603759,"y":-60.381586,"nombre":"Salón El Abierto"},{"x":-34.572224,"y":-58.535651,"nombre":"Estadio Obras"}]'
	val actualizacionServicios = '[{"descripcion":"Catering Re Loco","tarifaServicio":{"tipo":"TPH","valor":1000.00,"minimo":3500.00},"tarifaTraslado":30.00,"ubicacion":{"x":-34.572224,"y":58.535651}},{"descripcion":"Catering Food Party","tarifaServicio":{"tipo":"TF","valor":5000.00},"tarifaTraslado":30.00,"ubicacion":{"x":-34.572224,"y":58.535651}}]'
}
