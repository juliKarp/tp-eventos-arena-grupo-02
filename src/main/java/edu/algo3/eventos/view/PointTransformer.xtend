package edu.algo3.eventos.view

import org.apache.commons.lang.StringUtils
import org.uqbar.arena.bindings.ValueTransformer
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.geodds.Point

class PointTransformer implements ValueTransformer<Point, String> {
	override viewToModel(String valueFromView) {
		try {
			if (StringUtils.isBlank(valueFromView)) {
				null
			} else {
				val cordenadas = valueFromView.split(",")
				new Point(new Double(cordenadas.get(0).trim), new Double(cordenadas.get(1).trim))
			}
		} catch (RuntimeException e) {
			throw new UserException("Debe ingresar un par de cordenadas en formato: #.#, #.#")
		}
	}

	override getModelType() {
		typeof(Point)
	}

	override getViewType() {
		typeof(String)
	}

	override modelToView(Point valueFromModel) {
		if (valueFromModel === null) {
			null
		} else {
			valueFromModel.x + ", " + valueFromModel.y
		}
	}

}
