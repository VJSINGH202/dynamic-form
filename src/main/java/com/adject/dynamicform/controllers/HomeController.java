package com.adject.dynamicform.controllers;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.adject.dynamicform.model.DynamicForm;

@Controller
public class HomeController {
	
	  @RequestMapping("/") 
	  public String home(Model model) {
		  model.addAttribute("dynamicForm", new DynamicForm());
		  System.out.println("hello");
	      return "index"; 
	  }
	  
	  @RequestMapping("/test") 
	  public String test(Model model) {
		 // model.addAttribute("dynamicForm", new DynamicForm());
		 // System.out.println("hello");
	      return "test"; 
	  }
	 
}