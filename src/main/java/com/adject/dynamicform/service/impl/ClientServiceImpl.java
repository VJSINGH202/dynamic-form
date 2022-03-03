package com.adject.dynamicform.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.adject.dynamicform.repository.ClientRepository;
import com.adject.dynamicform.service.ClientService;

import io.jetform.core.entity.Client;

@Service
public class ClientServiceImpl implements ClientService{

	@Autowired
	private ClientRepository clientRepository;
	@Override
	public Client createClient(Client client) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Client> getClients() {
		
		return clientRepository.findAll();
	}

	@Override
	public void deleteClient(int id) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Client getClient(int id) {
		
		return clientRepository.findById(id).orElseThrow();
	}

}
