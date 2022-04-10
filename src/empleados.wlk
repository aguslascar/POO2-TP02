import empresa.*
import reciboHaberes.*

class Empleado {
	
	const property nombre
	const property direccion
	const property estadoCivil
	const property fechaNac
	const property sueldoBasico
	const hoy = new Date()
	
	method edad() {
		return (hoy - fechaNac) / 365
	}
	
	method sueldoNeto() 
	method sueldoBruto()
	method retenciones(sueldoBruto)
	method generarRecibo() {
		const recibo = new Recibo(nombreEmpleado = nombre, direccion = direccion, fechaEmision = hoy, sueldoBruto = self.sueldoBruto(), sueldoNeto = self.sueldoNeto(), desgloce = "")
	}
}

class PlantaPermanente inherits Empleado {
	const property cantHijos
	const property antiguedad
	
	override method sueldoNeto() {
		return self.retenciones(self.sueldoBruto())
	}
	
	override method sueldoBruto() {
		return sueldoBasico + self.salarioFamiliar()
	}
	method salarioFamiliar() {
		return self.asignacionHijos() + self.asignacionConyuge() + self.plusAntiguedad()
	}
	
	method asignacionHijos() {
		return cantHijos * 150
	}
	
	method asignacionConyuge() {
		if(estadoCivil == "Casado") {
			return 100
		}
		else return 0
	}
	
	method plusAntiguedad() {
		return antiguedad * 50
		
	}
	
	override method retenciones(sueldoBruto) {
		return ((sueldoBruto * 0.90) - 20 * cantHijos) * 0.85
	}
	
}

class PlantaTemporaria inherits Empleado {
	const property fechaFin
	const property horasExtra
	
	override method sueldoNeto() {
		return self.retenciones(self.sueldoBruto()) 
	}
	
	override method sueldoBruto() {
		return sueldoBasico + horasExtra * 40
	}
	
	override method retenciones(sueldoBruto) {
		return ((sueldoBruto * 0.90) - self.retencionMayorCincuenta()) * 0.90 - (5 * horasExtra)
	}
	method retencionMayorCincuenta() {
		if(self.edad() > 50) {
			return 25
		}
		else return 0
	}
}