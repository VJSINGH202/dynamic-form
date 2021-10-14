package com.adject.dynamicform.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.adject.dynamicform.modal.DynamicForm;

@Controller
public class HomeController {
	
	  @RequestMapping("/") 
	  public String home(Model model) {
		  model.addAttribute("dynamicForm", new DynamicForm());
		  System.out.println("hello");
	      return "index"; 
	  }
	 
}