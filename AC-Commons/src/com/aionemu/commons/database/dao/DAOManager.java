/**
 * This file is part of Aion-Lightning <aion-lightning.org>.
 *
 *  Aion-Lightning is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Aion-Lightning is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details. *
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Aion-Lightning.
 *  If not, see <http://www.gnu.org/licenses/>.
 *
 *
 * Credits goes to all Open Source Core Developer Groups listed below
 * Please do not change here something, ragarding the developer credits, except the "developed by XXXX".
 * Even if you edit a lot of files in this source, you still have no rights to call it as "your Core".
 * Everybody knows that this Emulator Core was developed by Aion Lightning 
 * @-Aion-Unique-
 * @-Aion-Lightning
 * @Aion-Engine
 * @Aion-Extreme
 * @Aion-NextGen
 * @Aion-Core Dev.
 */
package com.aionemu.commons.database.dao;

import com.aionemu.commons.configs.DatabaseConfig;
import com.aionemu.commons.scripting.classlistener.AggregatedClassListener;
import com.aionemu.commons.scripting.classlistener.OnClassLoadUnloadListener;
import com.aionemu.commons.scripting.classlistener.ScheduledTaskClassListener;
import com.aionemu.commons.scripting.scriptmanager.ScriptManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.xml.bind.JAXBException;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.HashMap;
import java.util.Map;

import static com.aionemu.commons.database.DatabaseFactory.*;

/**
 * This class manages {@link DAO} implementations, it resolves valid
 * implementation for current database
 *
 * @author SoulKeeper, Saelya
 */
public class DAOManager {

    /**
     * Logger for DAOManager class
     */
    private static final Logger log = LoggerFactory.getLogger(DAOManager.class);

    /**
     * Collection of registered DAOs
     */
    private static final Map<String, DAO> daoMap = new HashMap<String, DAO>();

    /**
     * This script manager is responsible for loading
     * {@link com.aionemu.commons.database.dao.DAO} implementations
     */
    private static ScriptManager scriptManager;

    /**
     * Initializes DAOManager.
     */
    public static void init() {
        try {
            // Load pre-compiled DAO JAR if exists (to avoid runtime compilation issues)
            File precompiledJar = new File("libs/ac-game-daos-precompiled.jar");
            boolean hasPrecompiledJar = precompiledJar.exists();
            java.net.URLClassLoader precompiledLoader = null;
            
            if (hasPrecompiledJar) {
                try {
                    java.net.URL jarUrl = precompiledJar.toURI().toURL();
                    precompiledLoader = new java.net.URLClassLoader(
                        new java.net.URL[]{jarUrl}, 
                        Thread.currentThread().getContextClassLoader()
                    );
                    Thread.currentThread().setContextClassLoader(precompiledLoader);
                    log.info("Loaded pre-compiled DAO JAR: " + precompiledJar.getAbsolutePath());
                } catch (Exception e) {
                    log.warn("Failed to load pre-compiled DAO JAR: " + e.getMessage());
                    hasPrecompiledJar = false;
                }
            }
            
            scriptManager = new ScriptManager();

            // initialize default class listeners for this ScriptManager
            AggregatedClassListener acl = new AggregatedClassListener();
            acl.addClassListener(new OnClassLoadUnloadListener());
            acl.addClassListener(new ScheduledTaskClassListener());
            DAOLoader daoLoader = new DAOLoader();
            acl.addClassListener(daoLoader);
            scriptManager.setGlobalClassListener(acl);

            scriptManager.load(DatabaseConfig.DATABASE_SCRIPTCONTEXT_DESCRIPTOR);
            
            log.info("After script load, daoMap size: {}", daoMap.size());
            
            // If pre-compiled JAR was loaded but no DAOs were registered (empty compilation), load manually
            if (hasPrecompiledJar && daoMap.size() == 0 && precompiledLoader != null) {
                log.info("No DAOs from script compilation, loading from pre-compiled JAR...");
                try {
                    java.util.List<Class<?>> daoClasses = new java.util.ArrayList<>();
                    java.util.jar.JarFile jar = new java.util.jar.JarFile(precompiledJar);
                    java.util.Enumeration<java.util.jar.JarEntry> entries = jar.entries();
                    
                    int classCount = 0;
                    while (entries.hasMoreElements()) {
                        java.util.jar.JarEntry entry = entries.nextElement();
                        String name = entry.getName();
                        if (name.endsWith(".class") && !name.contains("$")) {
                            classCount++;
                            String className = name.replace('/', '.').substring(0, name.length() - 6);
                            try {
                                Class<?> clazz = precompiledLoader.loadClass(className);
                                if (daoLoader.isValidDAO(clazz)) {
                                    daoClasses.add(clazz);
                                    log.debug("Found valid DAO class: {}", className);
                                }
                            } catch (Exception e) {
                                log.debug("Skipping class {}: {}", className, e.getMessage());
                            }
                        }
                    }
                    jar.close();
                    
                    log.info("Scanned {} classes from JAR, found {} valid DAOs", classCount, daoClasses.size());
                    
                    if (!daoClasses.isEmpty()) {
                        Class<?>[] classArray = daoClasses.toArray(new Class<?>[0]);
                        daoLoader.postLoad(classArray);
                        log.info("Loaded {} DAO classes from pre-compiled JAR", daoClasses.size());
                    }
                } catch (Exception e) {
                    log.error("Failed to load DAOs from pre-compiled JAR", e);
                }
            } else {
                log.info("Skipping manual DAO load: hasPrecompiledJar={}, daoMap.size={}, precompiledLoader!=null={}", 
                         hasPrecompiledJar, daoMap.size(), (precompiledLoader != null));
            }
        } catch (RuntimeException e) {
            throw new Error(e.getMessage(), e);
        } catch (FileNotFoundException e) {
            throw new Error("Can't load database script context: " + DatabaseConfig.DATABASE_SCRIPTCONTEXT_DESCRIPTOR, e);
        } catch (JAXBException e) {
            throw new Error("Can't compile database handlers - check your MySQL5 implementations", e);
        } catch (Exception e) {
            throw new Error("A fatal error occured during loading or compiling the database handlers", e);
        }

        log.info("Loaded " + daoMap.size() + " DAO implementations.");
    }

    /**
     * Shutdown DAOManager
     */
    public static void shutdown() {
        scriptManager.shutdown();
        daoMap.clear();
        scriptManager = null;
    }

    /**
     * Returns DAO implementation by DAO class. Typical usage:
     * <p/>
     * <
     * pre>
     * <p/>
     * AccountDAO dao = DAOManager.getDAO(AccountDAO.class);
     * </pre>
     *
     * @param clazz Abstract DAO class implementation of which was registered
     * @param <T>   Subclass of DAO
     * @return DAO implementation
     * @throws DAONotFoundException if DAO implementation not found
     */
    @SuppressWarnings("unchecked")
    public static <T extends DAO> T getDAO(Class<T> clazz) throws DAONotFoundException {

        DAO result = daoMap.get(clazz.getName());

        if (result == null) {
            String s = "DAO for class " + clazz.getSimpleName() + " not implemented";
            log.error(s);
            throw new DAONotFoundException(s);
        }

        return (T) result;
    }

    /**
     * Registers {@link DAO}.<br>
     * First it creates new instance of DAO, then invokes
     * {@link DAO#supports(String, int, int)} <br>
     * . If the result was possitive - it associates DAO instance with
     * {@link com.aionemu.commons.database.dao.DAO#getClassName()} <br>
     * If another DAO was registed -
     * {@link com.aionemu.commons.database.dao.DAOAlreadyRegisteredException}
     * will be thrown
     *
     * @param daoClass DAO implementation
     * @throws DAOAlreadyRegisteredException if DAO is already registered
     * @throws IllegalAccessException        if something went wrong during
     *                                       instantiation of DAO
     * @throws InstantiationException        if something went wrong during
     *                                       instantiation of DAO
     */
    public static void registerDAO(Class<? extends DAO> daoClass) throws DAOAlreadyRegisteredException,
            IllegalAccessException, InstantiationException {
        DAO dao = daoClass.newInstance();

        if (!dao.supports(getDatabaseName(), getDatabaseMajorVersion(), getDatabaseMinorVersion())) {
            return;
        }

        synchronized (DAOManager.class) {
            DAO oldDao = daoMap.get(dao.getClassName());
            if (oldDao != null) {
                StringBuilder sb = new StringBuilder();
                sb.append("DAO with className ").append(dao.getClassName()).append(" is used by ");
                sb.append(oldDao.getClass().getName()).append(". Can't override with ");
                sb.append(daoClass.getName()).append(".");
                String s = sb.toString();
                log.error(s);
                throw new DAOAlreadyRegisteredException(s);
            }
            daoMap.put(dao.getClassName(), dao);
        }

        if (log.isDebugEnabled()) {
            log.debug("DAO " + dao.getClassName() + " was successfuly registered.");
        }
    }

    /**
     * Unregisters DAO class
     *
     * @param daoClass DAO implementation to unregister
     */
    public static void unregisterDAO(Class<? extends DAO> daoClass) {
        synchronized (DAOManager.class) {
            for (DAO dao : daoMap.values()) {
                if (dao.getClass() == daoClass) {
                    daoMap.remove(dao.getClassName());

                    if (log.isDebugEnabled()) {
                        log.debug("DAO " + dao.getClassName() + " was successfuly unregistered.");
                    }

                    break;
                }
            }
        }
    }

    private DAOManager() {
        // empty
    }
}
