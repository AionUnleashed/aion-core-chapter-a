/**
 * This file is part of Aion Core Java 8 Migration
 * 
 * Compatibility class to replace org.apache.commons.lang.NullArgumentException
 * which was removed in commons-lang3
 */
package org.apache.commons.lang3;

/**
 * NullArgumentException compatibility wrapper for commons-lang3 migration
 * Extends IllegalArgumentException
 */
public class NullArgumentException extends IllegalArgumentException {
    
    private static final long serialVersionUID = 1L;
    
    /**
     * Constructor
     */
    public NullArgumentException() {
        super("Argument cannot be null");
    }
    
    /**
     * Constructor with message
     * 
     * @param message exception message
     */
    public NullArgumentException(String message) {
        super(message);
    }
    
    /**
     * Constructor with cause
     * 
     * @param cause the cause
     */
    public NullArgumentException(Throwable cause) {
        super("Argument cannot be null", cause);
    }
    
    /**
     * Constructor with message and cause
     * 
     * @param message exception message
     * @param cause the cause
     */
    public NullArgumentException(String message, Throwable cause) {
        super(message, cause);
    }
}
