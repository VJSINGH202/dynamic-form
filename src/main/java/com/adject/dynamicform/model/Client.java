package com.adject.dynamicform.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import io.jetform.core.entity.TaxItem;

//@Entity
//@Table(name = "tbl_client")
public class Client {
	
 @Id
 @GeneratedValue(strategy = GenerationType.IDENTITY)
 private int id;
 
 private String name;
 
 
 @ManyToMany(fetch = FetchType.LAZY, cascade = { CascadeType.MERGE })
	/*
	 * @JoinTable(name = "tbl_client_tax", joinColumns = {
	 * 
	 * @JoinColumn(name = "clientId", referencedColumnName = "id") },
	 * inverseJoinColumns = {
	 * 
	 * @JoinColumn(name = "taxId", referencedColumnName = "id", unique = false) })
	 */
 @JoinTable(name = "tbl_client_tax",
 joinColumns = @JoinColumn(name="client_id"),
 inverseJoinColumns = @JoinColumn(name="tax_id"))
 private List<TaxItem> taxItem;
 
 public Client() {

}
 
public long getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}

public List<TaxItem> getTaxItem() {
	return taxItem;
}

public void setTaxItem(List<TaxItem> taxItem) {
	this.taxItem = taxItem;
}

 
 
}
