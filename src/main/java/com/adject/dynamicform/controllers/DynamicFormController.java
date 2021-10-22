package com.adject.dynamicform.controllers;

import java.lang.reflect.Field;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.adject.dynamicform.modal.DynamicForm;
import com.google.gson.Gson;

import io.jetform.core.annotation.model.FormElementWrapper;
import io.jetform.core.annotation.model.JetFormWrapper;
import io.jetform.core.engine.helper.FormRenderer;
import io.jetform.core.entity.Employee;
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
		} catch (Exception e) {
			e.getStackTrace();
		}

		// new Gson().toJson(form);
		System.out.println(dynamicForm);
		model.addAttribute("dy", dynamicForm);
		model.addAttribute("form", form);
		model.addAttribute("modalClass", newInstance);
		model.addAttribute("json", new Gson().toJson(form));
		return "home";
	}

	@GetMapping(value = "/json/{className}", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public String getForm(@PathVariable String className) {
		System.out.println("Printing the className : " + className);
		String formJson = jetFormService.getFormJson(className);
		System.out.println("form json in new record method"+formJson);
		return formJson;
	}
	
	@GetMapping( value="/getJson",produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody JetFormWrapper getJsonWithFormValues(@RequestParam("id") String id, @RequestParam("className") String className) {
		System.out.println("id and class name in update method: ");
		System.out.println(id+className);
		JetFormWrapper formWrapper = jetFormService.getFormWrapperWithValues(Long.valueOf(id), className);
//		System.out.println("Form Wrapper"+formWrapper);
//		Gson gson=new Gson();
//				
		return formWrapper;
	}
	
	@GetMapping("/generate")
	public String getForm(@ModelAttribute DynamicForm dynamicForm, Model model) {
		System.out.println("classname received to update form"+dynamicForm.getClassName());
		System.out.println("id of the entity:"+dynamicForm.getId());
		
		return "form";
	}

	@PostMapping("/list")
	public String getList(@ModelAttribute DynamicForm dynamicForm, Model model) {
		model.addAttribute("className", dynamicForm.getClassName());
		return "list";
	}

	@GetMapping("/list")
	public String getList(@RequestParam String className, Model model) {
		model.addAttribute("className", className);
		return "list";
	}

	@GetMapping(value = "/load", produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody String loadJson(@RequestParam("className") String className) {

//		JetFormWrapper form = formRenderer.getForm(className);
		String formJson = jetFormService.getFormJson(className);
//		Gson gson=new Gson();
//		String json = gson.toJson(form);
//		model.addAttribute("form", form);
//		model.addAttribute("json",json);
		return formJson;
	}

	@GetMapping(value = "/entityList", produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody String getList(@RequestParam("className") String className) {
		System.out.println("inside list" + className);
		Gson gson = new Gson();
		String json = gson.toJson(jetFormService.getList(className));
		System.out.println("Json:" + json);
		return json;
	}

	@GetMapping(value = "/entity", produces = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody String getEntity(@RequestParam("id") String id, @RequestParam("className") String className) {

		System.out.println("id: " + id + "  className: " + className);
		JetFormWrapper formWrapper = jetFormService.getFormWrapperWithValues(Long.valueOf(id), className);
		System.out.println("Form Wrapper"+formWrapper);
		Gson gson=new Gson();
				
		return gson.toJson(formWrapper);
	}

	/*
	 * @PostMapping(value="/create") public String saveEntity(@Request String data)
	 * { System.out.println("inside : "); System.out.println(data); return null; }
	 */

	@RequestMapping(value = "/create", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String saveEntity(@RequestBody MultiValueMap<String, Object> formData,Model model) {
// your code goes here
		String className = formData.get("className").get(0).toString();
		Object saveEntity = jetFormService.saveEntity(formData);
		System.out.println("formData : " + formData);
		System.out.println(saveEntity);
		model.addAttribute("className", className);
		return "list";
		//return "index";
	}
	
	@GetMapping(value="/delete")
	public @ResponseBody String deleteEntity(@RequestParam("id") String id,@RequestParam("className") String className ) {
		
		boolean status = jetFormService.deleteEntity(Long.valueOf(id), className);
		return status?"Deletd":"Something went wrong";
	}
	

}