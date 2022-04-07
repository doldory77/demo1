package demo.cmmn.service;

public class NotExistUserException extends Exception {

	private static final long serialVersionUID = -746881772955436743L;
	
	public NotExistUserException(String message) {
		super(message);
	}

}
