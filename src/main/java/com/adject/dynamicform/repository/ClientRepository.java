package com.adject.dynamicform.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import io.jetform.core.entity.Client;



public interface ClientRepository extends JpaRepository<Client, Integer> {

}
