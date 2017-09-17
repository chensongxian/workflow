package com.csx.workflow.web.process;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("user")
public class UserController {
	@RequestMapping("query")
	@ResponseBody
	public List<User> lookPicBeforeStart(String key, Model model) {
		List<User> list = new ArrayList<>();
		User u1 = new User("1", "张三");
		User u2 = new User("2", "李四");
		list.add(u1);
		list.add(u2);
		return list;
	}

	public static class User {
		public String id;
		public String name;

		public String getId() {
			return id;
		}

		public void setId(String id) {
			this.id = id;
		}

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public User(String id, String name) {
			this.id = id;
			this.name = name;
		}

	}

}
