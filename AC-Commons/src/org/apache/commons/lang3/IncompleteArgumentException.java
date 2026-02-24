/**
 * This file is part of Aion Core Java 8 Migration
 * 
 * Compatibility class to replace org.apache.commons.lang.IncompleteArgumentException
 * which was removed in commons-lang3
 */
package org.apache.commons.lang3;

/**
 * IncompleteArgumentException compatibility wrapper for commons-lang3 migration
 * Extends IllegalArgumentException
 */
public class IncompleteArgumentException extends IllegalArgumentException {
    
    private static final long serialVersionUID = 1L;
    
    /**
     * Constructor
     */
    public IncompleteArgumentException() {
        super();
    }
    
    /**
     * Constructor with message
     * 
     * @param message exception message
     */
    public IncompleteArgumentException(String message) {
        super(message);
    }
    
    /**
     * Constructor with cause
     * 
     * @param cause the cause
     */
    public IncompleteArgumentException(Throwable cause) {
        super(cause);
    }
    
    /**
     * Constructor with message and cause
     * 
     * @param message exception message
     * @param cause the cause
     */
    public IncompleteArgumentException(String message, Throwable cause) {
        super(message, cause);
    }
}
