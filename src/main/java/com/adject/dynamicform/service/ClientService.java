package com.adject.dynamicform.service;

import java.util.List;

import io.jetform.core.entity.Client;




public interface ClientService {
	
		public Client createClient(Client clientDto);
		public List<Client> getClients();
		public void deleteClient(int id);
		public Client getClient(int id);
	
}
