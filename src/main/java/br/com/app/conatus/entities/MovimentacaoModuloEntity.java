package br.com.app.conatus.entities;

import java.math.BigDecimal;
import java.time.ZonedDateTime;

import org.hibernate.annotations.CreationTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Table(name = "TB_MOVIM_MODULO")
@Builder @AllArgsConstructor @NoArgsConstructor
@Setter @Getter @EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class MovimentacaoModuloEntity {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "IDENT")
	private Long id;
	
	@ManyToOne
	@JoinColumn(name = "ID_TENANT_MODULO")
	private TenantModuloEntity tenantModulo;
	
	@ManyToOne
	@JoinColumn(name = "ID_TRANSACAO")
	private TransacaoEntity transacao;
	
	@Column(name = "VL_MOVIMENTACAO")
	private BigDecimal valorMovimentacao;
	
	@ManyToOne
	@JoinColumn(name = "ID_FUNCIONALIDADE")
	private FuncionalidadeCustomizadaEntity funcionalidadeCustom;
	
	@CreationTimestamp
	@Column(name = "DT_MOVIMENTACAO")
	private ZonedDateTime dataMovimentacao;
	
	@ManyToOne
	@JoinColumn(name = "ID_DOM_TIPO")
	private DominioEntity tipo;

}
