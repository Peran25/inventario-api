package com.jaime.inventario_api.repository;

import com.jaime.inventario_api.model.MovimientoStock;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MovimientoStockRepository extends JpaRepository<MovimientoStock, Long> {
}