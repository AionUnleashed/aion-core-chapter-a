/**
 * This file is part of Aion Core Java 8 Migration
 * 
 * Compatibility class to replace org.apache.commons.lang.math.FloatRange
 * which was removed in commons-lang3
 * 
 * Uses Google Guava Range internally
 */
package org.apache.commons.lang3.math;

import com.google.common.collect.Range;

/**
 * FloatRange compatibility wrapper for commons-lang3 migration
 * Wraps Google Guava Range<Float>
 */
public class FloatRange {
    
    private final Range<Float> range;
    private final float min;
    private final float max;
    
    /**
     * Creates a FloatRange with minimum and maximum values (inclusive)
     * 
     * @param min minimum value (inclusive)
     * @param max maximum value (inclusive)
     */
    public FloatRange(float min, float max) {
        // Auto-correct inverted values instead of throwing exception
        if (min > max) {
            float temp = min;
            min = max;
            max = temp;
        }
        this.min = min;
        this.max = max;
        this.range = Range.closed(min, max);
    }
    
    /**
     * Gets the minimum value
     * 
     * @return minimum float value
     */
    public float getMinimumFloat() {
        return min;
    }
    
    /**
     * Gets the maximum value
     * 
     * @return maximum float value
     */
    public float getMaximumFloat() {
        return max;
    }
    
    /**
     * Gets the minimum value as Number
     * 
     * @return minimum value
     */
    public Number getMinimumNumber() {
        return min;
    }
    
    /**
     * Gets the maximum value as Number
     * 
     * @return maximum value
     */
    public Number getMaximumNumber() {
        return max;
    }
    
    /**
     * Checks if value is within range (inclusive)
     * 
     * @param value value to check
     * @return true if value is within range
     */
    public boolean containsFloat(float value) {
        return range.contains(value);
    }
    
    /**
     * Checks if value is within range (inclusive)
     * 
     * @param value value to check
     * @return true if value is within range
     */
    public boolean containsNumber(Number value) {
        return range.contains(value.floatValue());
    }
    
    /**
     * Checks if value is within range (inclusive)
     * 
     * @param value value to check
     * @return true if value is within range
     */
    public boolean contains(float value) {
        return containsFloat(value);
    }
    
    @Override
    public String toString() {
        return "FloatRange[" + min + "," + max + "]";
    }
    
    @Override
    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof FloatRange)) {
            return false;
        }
        FloatRange other = (FloatRange) obj;
        return this.min == other.min && this.max == other.max;
    }
    
    @Override
    public int hashCode() {
        return range.hashCode();
    }
}
