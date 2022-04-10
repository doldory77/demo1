package demo.cmmn.service;

import java.util.Locale;

import org.springframework.context.MessageSource;
import org.springframework.context.support.DefaultMessageSourceResolvable;
import org.springframework.validation.BindingResult;
import org.springmodules.validation.commons.DefaultBeanValidator;

public class ValidatorHelper {

	public static final String DEFINED_VALIDATION_ERROR_CODE = "1000";
	public static boolean validate(MessageSource messageSource, DefaultBeanValidator beanValidator, Object bean, BindingResult bindingResult, PackingVO pack) {
		beanValidator.validate(bean, bindingResult);
		if (bindingResult.hasErrors()) {
			DefaultMessageSourceResolvable dsr = (DefaultMessageSourceResolvable) bindingResult.getAllErrors().get(0).getArguments()[0];
			pack.setCode(DEFINED_VALIDATION_ERROR_CODE);
			pack.setMsg(messageSource.getMessage(dsr.getCode().toString(), null, Locale.getDefault()));
			return false;
		}
		return true;
	}
}
