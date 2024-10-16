package com.atos.lms.common.utl;

import java.io.IOException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Properties;
import java.util.Set;


import jakarta.annotation.PostConstruct;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PropertiesLoaderUtils;
import org.springframework.stereotype.Component;

@Component
public class SortFieldProperties {

	private final Map<String, Set<String>> allowedSortFields = new HashMap<>();
    private final Map<String, String> defaultSortFields = new HashMap<>();

	@PostConstruct
    public void init() throws IOException {
        Resource resource = new ClassPathResource("atos/props/sort.properties");
        Properties properties = PropertiesLoaderUtils.loadProperties(resource);

        for (String key : properties.stringPropertyNames()) {
            if (key.startsWith("allowedSortFields.")) {
                String tableName = key.substring("allowedSortFields.".length());
                String fields = properties.getProperty(key);
                if (fields != null && !fields.trim().isEmpty()) {
                    Set<String> fieldSet = new HashSet<>();
                    for (String field : fields.split(",")) {
                        fieldSet.add(field.trim());
                    }
                    allowedSortFields.put(tableName, fieldSet);
                }
            } else if (key.startsWith("defaultSortField.")) {
                String tableName = key.substring("defaultSortField.".length());
                String defaultField = properties.getProperty(key);
                if (defaultField != null && !defaultField.trim().isEmpty()) {
                    defaultSortFields.put(tableName, defaultField.trim());
                }
            }
        }
    }

    public Map<String, Set<String>> getAllowedSortFields() {
        return allowedSortFields;
    }

    public Map<String, String> getDefaultSortFields() {
        return defaultSortFields;
    }


}
