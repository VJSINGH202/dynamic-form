package com.adject.dynamicform.controllers;

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
		return formJson;
	}

	@GetMapping("/generate")
	public String getForm(@ModelAttribute DynamicForm dynamicForm, Model model) {
		// model.addAttribute("className", dynamicForm.getClassName());
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
	public @ResponseBody String getEntity(@RequestParam("id") String id, @RequestParam("className") String className) throws ClassNotFoundException {

		System.out.println("id: " + id + "  className: " + className);
		JetFormWrapper formWrapper = jetFormService.getFormWrapper(className);
		List<FormElementWrapper> elements = formWrapper.getElements();
		elements.stream()
			.forEach(a->System.out.println(a.getName()));
		System.out.println();
		Object entity = jetFormService.getEntity(Long.valueOf(id), className);
		System.out.println(entity.toString());		
		Object cast = Class.forName(className).cast(entity);
		System.out.println(cast.toString());
//		Employee cast = Employee.class.cast(entity);

		return null;
	}

	/*
	 * @PostMapping(value="/create") public String saveEntity(@Request String data)
	 * { System.out.println("inside : "); System.out.println(data); return null; }
	 */

	@RequestMapping(value = "/create", method = RequestMethod.POST, consumes = MediaType.APPLICATION_FORM_URLENCODED_VALUE)
	public String saveEntity(@RequestBody MultiValueMap<String, String> formData) {
// your code goes here
		System.out.println("formData : " + formData);
		return null;
	}

}