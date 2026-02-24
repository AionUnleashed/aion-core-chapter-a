/**
 * This file is part of Aion Core Java 8 Migration
 * 
 * Compatibility class to replace org.apache.commons.lang.math.IntRange
 * which was removed in commons-lang3
 * 
 * Uses Google Guava Range internally
 */
package org.apache.commons.lang3.math;

import com.google.common.collect.Range;

/**
 * IntRange compatibility wrapper for commons-lang3 migration
 * Wraps Google Guava Range<Integer>
 */
public class IntRange {
    
    private final Range<Integer> range;
    private final int min;
    private final int max;
    
    /**
     * Creates an IntRange with minimum and maximum values (inclusive)
     * 
     * @param min minimum value (inclusive)
     * @param max maximum value (inclusive)
     */
    public IntRange(int min, int max) {
        // Auto-correct if min > max (tolerant to bad data)
        if (min > max) {
            int temp = min;
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
     * @return minimum int value
     */
    public int getMinimumInteger() {
        return min;
    }
    
    /**
     * Gets the maximum value
     * 
     * @return maximum int value
     */
    public int getMaximumInteger() {
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
    public boolean containsInteger(int value) {
        return range.contains(value);
    }
    
    /**
     * Checks if value is within range (inclusive)
     * 
     * @param value value to check
     * @return true if value is within range
     */
    public boolean containsNumber(Number value) {
        return range.contains(value.intValue());
    }
    
    /**
     * Checks if value is within range (inclusive)
     * 
     * @param value value to check
     * @return true if value is within range
     */
    public boolean contains(int value) {
        return containsInteger(value);
    }
    
    /**
     * Converts to array
     * 
     * @return array with all values in range
     */
    public int[] toArray() {
        int[] result = new int[max - min + 1];
        for (int i = 0; i < result.length; i++) {
            result[i] = min + i;
        }
        return result;
    }
    
    @Override
    public String toString() {
        return "IntRange[" + min + "," + max + "]";
    }
    
    @Override
    public boolean equals(Object obj) {
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof IntRange)) {
            return false;
        }
        IntRange other = (IntRange) obj;
        return this.min == other.min && this.max == other.max;
    }
    
    @Override
    public int hashCode() {
        return range.hashCode();
    }
}
