package com.adject.dynamicform.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.adject.dynamicform.modal.DynamicForm;
import com.google.gson.Gson;

import io.jetform.core.annotation.model.JetFormWrapper;
import io.jetform.core.engine.helper.FormRenderer;
import io.jetform.core.service.JetFormService;

@Controller
@RequestMapping("/dynamic")
public class DynamicFormController {
	@Autowired
	private JetFormService jetFormService; 
	
	@Autowired
	private FormRenderer formRenderer;

	@PostMapping("/generate")
	public String generateForm(@ModelAttribute DynamicForm dynamicForm, Model model) {
		
		JetFormWrapper form = formRenderer.getForm(dynamicForm.getClassName());
		Object newInstance = null;
		try {
			Class<?> forName = Class.forName(dynamicForm.getClassName());
			 newInstance = forName.getDeclaredConstructor().newInstance();
		}catch(Exception e) {e.getStackTrace();}
		
		//new Gson().toJson(form);
		System.out.println(dynamicForm);
		model.addAttribute("dy", dynamicForm);
		model.addAttribute("form", form);
		model.addAttribute("modalClass", newInstance);
		model.addAttribute("json", new Gson().toJson(form));
		return "home";
	}
	
	@GetMapping(value="/json/{className}",produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public String getForm(@PathVariable String className) {
		System.out.println("Printing the className : "+className);
		String formJson = jetFormService.getFormJson(className);
		return formJson;
	}

	@GetMapping("/generate")
	public String getForm(@ModelAttribute DynamicForm dynamicForm, Model model) {
		model.addAttribute("className", dynamicForm.getClassName());
		return "form";
	}
	
	@PostMapping("/list")
	public String getList(@ModelAttribute DynamicForm dynamicForm, Model model) {
		model.addAttribute("className", dynamicForm.getClassName());
		return "list";
	}
	
	@GetMapping(value="/load",produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody String loadJson(@RequestParam("className") String className) {
		
	//	System.out.println("className inside loadjson method"+className);
	
//		JetFormWrapper form = formRenderer.getForm(className);
//		System.out.println("form"+form);
		String formJson = jetFormService.getFormJson(className);
//		Gson gson=new Gson();
//		String json = gson.toJson(form);
//		System.out.println("Json:  "+json);
//		model.addAttribute("form", form);
//		model.addAttribute("json",json);
		return formJson;
	}  
}
