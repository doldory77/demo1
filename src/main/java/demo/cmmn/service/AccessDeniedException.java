package demo.cmmn.service;

public class AccessDeniedException extends Exception {
	
	private static final long serialVersionUID = -8668411959442025425L;
	
	public AccessDeniedException(String message) {
		super(message);
	}

}
