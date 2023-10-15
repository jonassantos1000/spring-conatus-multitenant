package br.com.app.conatus.repositories;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import br.com.app.conatus.entities.DominioEntity;

@Repository
public interface DominioRepository extends JpaRepository<DominioEntity, Long>{

	Optional<DominioEntity> findByCodigo(String codigo);

}