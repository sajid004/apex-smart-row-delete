prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.4'
,p_default_workspace_id=>100000
,p_default_application_id=>108
,p_default_id_offset=>0
,p_default_owner=>'HMIS'
);
end;
/
 
prompt APPLICATION 108 - LMS
--
-- Application Export:
--   Application:     108
--   Name:            LMS
--   Date and Time:   10:40 Thursday October 30, 2025
--   Exported By:     MUHAMMADSAJID
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PLUGIN: 590064203593507066
--   Manifest End
--   Version:         23.1.4
--   Instance ID:     697853336793999
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/shared_components/plugins/dynamic_action/smart_row_delete
begin
wwv_flow_imp_shared.create_plugin(
 p_id=>wwv_flow_imp.id(590064203593507066)
,p_plugin_type=>'DYNAMIC ACTION'
,p_name=>'SMART_ROW_DELETE'
,p_display_name=>'Smart Row Delete'
,p_category=>'EXECUTE'
,p_plsql_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'FUNCTION render_delete_row (',
'    p_dynamic_action IN apex_plugin.t_dynamic_action,',
'    p_plugin         IN apex_plugin.t_plugin ',
')',
'RETURN apex_plugin.t_dynamic_action_render_result',
'IS',
'    l_result              apex_plugin.t_dynamic_action_render_result;',
'    l_table_name          VARCHAR2(200);',
'    l_pk_columns          VARCHAR2(4000);',
'    l_success_message     VARCHAR2(4000);',
'    l_error_message       VARCHAR2(4000);',
'    l_confirm_message     VARCHAR2(4000);',
'    l_show_confirmation   VARCHAR2(10);',
'    l_delete_icon         VARCHAR2(200);',
'    l_icon_class          VARCHAR2(200);',
'    l_ajax_identifier     VARCHAR2(4000);',
'    l_region_static_id    VARCHAR2(200);',
'BEGIN',
'    --plugin attributes',
'    l_table_name        := p_dynamic_action.attribute_01;',
'    l_pk_columns        := p_dynamic_action.attribute_02;',
'    l_success_message   := NVL(p_dynamic_action.attribute_03, ''Record Deleted Successfully'');',
'    l_error_message     := NVL(p_dynamic_action.attribute_04, ''Error deleting record'');',
'    l_confirm_message   := NVL(p_dynamic_action.attribute_05, ''Are you sure you want to delete this record?'');',
'    l_show_confirmation := NVL(p_dynamic_action.attribute_06, ''Y'');',
'    l_delete_icon       := NVL(p_dynamic_action.attribute_07, ''fa-trash-o'');',
'    l_icon_class        := NVL(p_dynamic_action.attribute_08, ''delete-icon'');',
'    l_region_static_id  := p_dynamic_action.attribute_09;    --region static ID',
'    l_ajax_identifier   := apex_plugin.get_ajax_identifier;',
'    ',
'    -- Validate that region static ID is provided',
'    IF l_region_static_id IS NULL THEN',
'        apex_error.add_error(',
'            p_message          => ''Region Static ID is required for the Row Delete plugin.'',',
'            p_display_location => apex_error.c_inline_in_notification',
'        );',
'        RETURN l_result;',
'    END IF;',
'',
'    -- Add inline CSS (only once per page)',
'    apex_css.add(',
'        p_css => ''.delete-icon{cursor:pointer;color:#d9534f;font-size:16px;padding:4px 8px;'' ||',
'                 ''transition:all 0.3s ease;display:inline-block;}'' ||',
'                 ''.delete-icon:hover{color:#c9302c;transform:scale(1.1);}'' ||',
'                 ''.delete-icon:active{transform:scale(0.95);}'' ||',
'                 ''.delete-icon.disabled{cursor:not-allowed;opacity:0.5;pointer-events:none;}'',',
'        p_key => ''delete-row-plugin-css''',
'    );',
'',
'    -- Add inline JavaScript (only once per page)',
'    apex_javascript.add_inline_code(',
'        p_code => ',
'''(function(){',
'    if(typeof window.apexDeleteRow === "undefined"){',
'        window.apexDeleteRow = {',
'            config: {},',
'            init: function(pDaId, pConfig) {',
'                this.config[pDaId] = pConfig;',
'                var self = this;',
'                ',
'                // Scope the click handler to the specific region using region static ID',
'                var regionSelector = "#" + pConfig.regionStaticId;',
'                ',
'                apex.jQuery(regionSelector).off("click.deleteRow" + pDaId).on("click.deleteRow" + pDaId, "." + pConfig.iconClass, function(e) {',
'                    e.preventDefault();',
'                    e.stopPropagation();',
'                    var $icon = apex.jQuery(this);',
'                    var pkValues = self.getPkValues($icon, pConfig.pkColumns);',
'                    if (pkValues) {',
'                        self.deleteRow(pDaId, pkValues, $icon, pConfig.regionStaticId);',
'                    }',
'                });',
'            },',
'            getPkValues: function($icon, pkColumns) {',
'                var pkColumnArray = pkColumns.split(":");',
'                var values = [];',
'                var $row, value;',
'                ',
'                if ($icon.closest("tr[data-id]").length > 0) {',
'                    $row = $icon.closest("tr[data-id]");',
'                    for (var i = 0; i < pkColumnArray.length; i++) {',
'                        value = $row.find("[headers=\"" + pkColumnArray[i] + "\"]").text().trim();',
'                        if (!value) {',
'                            value = $icon.attr("data-" + pkColumnArray[i].toLowerCase());',
'                        }',
'                        if (!value) {',
'                            value = $row.attr("data-" + pkColumnArray[i].toLowerCase());',
'                        }',
'                        values.push(value);',
'                    }',
'                } else if ($icon.closest("tr").length > 0) {',
'                    $row = $icon.closest("tr");',
'                    for (var i = 0; i < pkColumnArray.length; i++) {',
'                        value = $icon.attr("data-" + pkColumnArray[i].toLowerCase());',
'                        if (!value) {',
'                            value = $row.attr("data-" + pkColumnArray[i].toLowerCase());',
'                        }',
'                        if (!value) {',
'                            value = $row.find("td").eq(i).text().trim();',
'                        }',
'                        values.push(value);',
'                    }',
'                } else {',
'                    for (var i = 0; i < pkColumnArray.length; i++) {',
'                        value = $icon.attr("data-" + pkColumnArray[i].toLowerCase());',
'                        values.push(value);',
'                    }',
'                }',
'                ',
'                return values.join(":");',
'            },',
'            deleteRow: function(pDaId, pkValues, $icon, regionStaticId) {',
'                var config = this.config[pDaId];',
'                var self = this;',
'                ',
'                if (config.showConfirmation === "Y") {',
'                    apex.message.confirm(config.confirmMessage, function(okPressed) {',
'                        if (okPressed) {',
'                            self.executeDelete(pDaId, pkValues, $icon, regionStaticId);',
'                        }',
'                    });',
'                } else {',
'                    this.executeDelete(pDaId, pkValues, $icon, regionStaticId);',
'                }',
'            },',
'            executeDelete: function(pDaId, pkValues, $icon, regionStaticId) {',
'                var config = this.config[pDaId];',
'                var self = this;',
'                var $region = apex.jQuery("#" + regionStaticId);',
'               // var spinner = apex.util.showSpinner($region);',
'                ',
'                apex.server.plugin(config.ajaxIdentifier, {',
'                    x01: pkValues',
'                }, {',
'                    dataType: "json",',
'                    success: function(pData) {',
'                       // if (spinner) spinner.remove();',
'                        ',
'                        if (pData.status === "success") {',
'                            apex.message.showPageSuccess(config.successMessage);',
'				                setTimeout(function () {',
'				                    var $el = apex.jQuery("#t_Alert_Success");',
'				                    if($el.length){',
'				                        $el.fadeOut("fast", function(){ $el.remove(); });',
'				                    }',
'				                }, 2000);',
'                            ',
'                            // Refresh the region only once - this will update both the data and the count',
'                            if (regionStaticId) {',
'                                apex.region(regionStaticId).refresh();',
'                            } else {',
'                                location.reload();',
'                            }',
'                        } else {',
'						          apex.message.clearErrors();',
'                            apex.message.showErrors([{',
'                                type: "error",',
'                                location: "page",',
'                                message: config.errorMessage + ": " + (pData.message || "Unknown error")',
'                            }]);',
'                        }',
'                    },',
'                    error: function(jqXHR, textStatus, errorThrown) {',
'                        if (spinner) spinner.remove();',
'                        apex.message.showErrors([{',
'                            type: "error",',
'                            location: "page",',
'                            message: config.errorMessage + ": " + (errorThrown || textStatus)',
'                        }]);',
'                    }',
'                });',
'            }',
'        };',
'    }',
'})();'',',
'        p_key => ''delete-row-plugin-js''',
'    );',
'',
'    -- Build the initialization function as a string',
'    l_result.javascript_function := ',
'        ''function(){'' ||',
'        ''if(typeof apexDeleteRow !== "undefined"){'' ||',
'        ''apexDeleteRow.init("'' || p_dynamic_action.id || ''",{'' ||',
'        ''ajaxIdentifier:"'' || l_ajax_identifier || ''",'' ||',
'        ''tableName:'' || apex_escape.js_literal(l_table_name) || '','' ||',
'        ''pkColumns:'' || apex_escape.js_literal(l_pk_columns) || '','' ||',
'        ''successMessage:'' || apex_escape.js_literal(l_success_message) || '','' ||',
'        ''errorMessage:'' || apex_escape.js_literal(l_error_message) || '','' ||',
'        ''confirmMessage:'' || apex_escape.js_literal(l_confirm_message) || '','' ||',
'        ''showConfirmation:"'' || l_show_confirmation || ''",'' ||',
'        ''deleteIcon:"'' || l_delete_icon || ''",'' ||',
'        ''iconClass:"'' || l_icon_class || ''",'' ||',
'        ''regionStaticId:"'' || l_region_static_id || ''"'' ||',
'        ''});}'' ||',
'        ''}'';',
'',
'    RETURN l_result;',
'END render_delete_row;',
'',
'-- AJAX CALLBACK FUNCTION',
'FUNCTION ajax_delete_row (',
'    p_dynamic_action IN apex_plugin.t_dynamic_action,',
'    p_plugin         IN apex_plugin.t_plugin ',
')',
'RETURN apex_plugin.t_dynamic_action_ajax_result',
'IS',
'    l_result          apex_plugin.t_dynamic_action_ajax_result;',
'    l_table_name      VARCHAR2(200);',
'    l_pk_columns      VARCHAR2(4000);',
'    l_pk_values       VARCHAR2(4000);',
'    l_sql             VARCHAR2(4000);',
'    l_column_array    apex_t_varchar2;',
'    l_value_array     apex_t_varchar2;',
'    l_where_clause    VARCHAR2(4000);',
'    l_rows_deleted    NUMBER := 0;',
'    ',
'BEGIN',
'    -- Get plugin attributes',
'    l_table_name := p_dynamic_action.attribute_01;',
'    l_pk_columns := p_dynamic_action.attribute_02;',
'    ',
'    -- Get AJAX parameters (PK values passed from JavaScript)',
'    l_pk_values := apex_application.g_x01;',
'    ',
'    -- Validate inputs',
'    IF l_table_name IS NULL OR l_pk_columns IS NULL OR l_pk_values IS NULL THEN',
'        apex_json.open_object;',
'        apex_json.write(''status'', ''error'');',
'        apex_json.write(''message'', ''Missing required parameters'');',
'        apex_json.close_object;',
'        RETURN l_result;',
'    END IF;',
'    ',
'    -- Split columns and values into arrays',
'    l_column_array := apex_string.split(l_pk_columns, '':'');',
'    l_value_array  := apex_string.split(l_pk_values, '':'');',
'    ',
'    -- Validate that we have matching columns and values',
'    IF l_column_array.COUNT = 0 OR l_column_array.COUNT != l_value_array.COUNT THEN',
'        apex_json.open_object;',
'        apex_json.write(''status'', ''error'');',
'        apex_json.write(''message'', ''Column and value count mismatch'');',
'        apex_json.close_object;',
'        RETURN l_result;',
'    END IF;',
'    ',
'    -- Validate column and table names to prevent SQL injection',
'    FOR i IN 1..l_column_array.COUNT LOOP',
'        IF NOT REGEXP_LIKE(l_column_array(i), ''^[A-Za-z0-9_]+$'') THEN',
'            apex_json.open_object;',
'            apex_json.write(''status'', ''error'');',
'            apex_json.write(''message'', ''Invalid column name: '' || l_column_array(i));',
'            apex_json.close_object;',
'            RETURN l_result;',
'        END IF;',
'    END LOOP;',
'    ',
'    IF NOT REGEXP_LIKE(l_table_name, ''^[A-Za-z0-9_\.]+$'') THEN',
'        apex_json.open_object;',
'        apex_json.write(''status'', ''error'');',
'        apex_json.write(''message'', ''Invalid table name'');',
'        apex_json.close_object;',
'        RETURN l_result;',
'    END IF;',
'    ',
'    -- Build WHERE clause',
'    FOR i IN 1..l_column_array.COUNT LOOP',
'        IF i > 1 THEN',
'            l_where_clause := l_where_clause || '' AND '';',
'        END IF;',
'        l_where_clause := l_where_clause || l_column_array(i) || '' = :b'' || i;',
'    END LOOP;',
'    ',
'    -- Build DELETE statement',
'    l_sql := ''DELETE FROM '' || l_table_name || '' WHERE '' || l_where_clause;',
'    ',
'    BEGIN',
'        -- Execute with dynamic binding based on number of columns',
'        CASE l_value_array.COUNT',
'            WHEN 1 THEN',
'                EXECUTE IMMEDIATE l_sql USING l_value_array(1);',
'            WHEN 2 THEN',
'                EXECUTE IMMEDIATE l_sql USING l_value_array(1), l_value_array(2);',
'            WHEN 3 THEN',
'                EXECUTE IMMEDIATE l_sql USING l_value_array(1), l_value_array(2), l_value_array(3);',
'            WHEN 4 THEN',
'                EXECUTE IMMEDIATE l_sql USING l_value_array(1), l_value_array(2), ',
'                                               l_value_array(3), l_value_array(4);',
'            WHEN 5 THEN',
'                EXECUTE IMMEDIATE l_sql USING l_value_array(1), l_value_array(2), ',
'                                               l_value_array(3), l_value_array(4),',
'                                               l_value_array(5);',
'            WHEN 6 THEN',
'                EXECUTE IMMEDIATE l_sql USING l_value_array(1), l_value_array(2), ',
'                                               l_value_array(3), l_value_array(4),',
'                                               l_value_array(5), l_value_array(6);',
'            WHEN 7 THEN',
'                EXECUTE IMMEDIATE l_sql USING l_value_array(1), l_value_array(2), ',
'                                               l_value_array(3), l_value_array(4),',
'                                               l_value_array(5), l_value_array(6),',
'                                               l_value_array(7);',
'            WHEN 8 THEN',
'                EXECUTE IMMEDIATE l_sql USING l_value_array(1), l_value_array(2), ',
'                                               l_value_array(3), l_value_array(4),',
'                                               l_value_array(5), l_value_array(6),',
'                                               l_value_array(7), l_value_array(8);',
'            ELSE',
'                RAISE_APPLICATION_ERROR(-20001, ''Maximum 8 primary key columns supported'');',
'        END CASE;',
'        ',
'        l_rows_deleted := SQL%ROWCOUNT;',
'        COMMIT;',
'        ',
'        apex_json.open_object;',
'        apex_json.write(''status'', ''success'');',
'        apex_json.write(''rowsDeleted'', l_rows_deleted);',
'        apex_json.close_object;',
'        ',
'    EXCEPTION',
'        WHEN OTHERS THEN',
'            ROLLBACK;',
'            apex_json.open_object;',
'            apex_json.write(''status'', ''error'');',
'            apex_json.write(''message'', SQLERRM);',
'            apex_json.close_object;',
'    END;',
'    ',
'    RETURN l_result;',
'    ',
'EXCEPTION',
'    WHEN OTHERS THEN',
'        ROLLBACK;',
'        apex_json.open_object;',
'        apex_json.write(''status'', ''error'');',
'        apex_json.write(''message'', ''Unexpected error: '' || SQLERRM);',
'        apex_json.close_object;',
'        RETURN l_result;',
'END ajax_delete_row;'))
,p_default_escape_mode=>'HTML'
,p_api_version=>2
,p_render_function=>'render_delete_row'
,p_ajax_function=>'ajax_delete_row'
,p_substitute_attributes=>true
,p_subscribe_plugin_settings=>true
,p_version_identifier=>'1.0'
,p_plugin_comment=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--add pk column in report query',
'--    ''<span class="delete-icon fa fa-trash-o" data-dept_no="'' || dept_no || ''" data-emp_id="'' || emp_id || ''"></span>'' as DELETE_ACTION'))
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(590065616793512393)
,p_plugin_id=>wwv_flow_imp.id(590064203593507066)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>1
,p_display_sequence=>10
,p_prompt=>'Table Name'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(590071887259518550)
,p_plugin_id=>wwv_flow_imp.id(590064203593507066)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>2
,p_display_sequence=>20
,p_prompt=>'Primary Key Columns'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(590072479054523638)
,p_plugin_id=>wwv_flow_imp.id(590064203593507066)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>3
,p_display_sequence=>30
,p_prompt=>'Success Message'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'Record deleted successfully'
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(590073522290526710)
,p_plugin_id=>wwv_flow_imp.id(590064203593507066)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>4
,p_display_sequence=>40
,p_prompt=>'Error Message'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'Error deleting record'
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(590074296362529957)
,p_plugin_id=>wwv_flow_imp.id(590064203593507066)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>5
,p_display_sequence=>50
,p_prompt=>'Confirmation Message'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'Are you sure you want to delete this record?'
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(590091575101565565)
,p_plugin_id=>wwv_flow_imp.id(590064203593507066)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>6
,p_display_sequence=>60
,p_prompt=>'Show Confirmation'
,p_attribute_type=>'SELECT LIST'
,p_is_required=>false
,p_default_value=>'Y'
,p_is_translatable=>false
,p_lov_type=>'STATIC'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(590092424916566590)
,p_plugin_attribute_id=>wwv_flow_imp.id(590091575101565565)
,p_display_sequence=>10
,p_display_value=>'Yes'
,p_return_value=>'Y'
);
wwv_flow_imp_shared.create_plugin_attr_value(
 p_id=>wwv_flow_imp.id(590092869433567226)
,p_plugin_attribute_id=>wwv_flow_imp.id(590091575101565565)
,p_display_sequence=>20
,p_display_value=>'No'
,p_return_value=>'N'
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(590094273342573797)
,p_plugin_id=>wwv_flow_imp.id(590064203593507066)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>7
,p_display_sequence=>70
,p_prompt=>'Delete Icon'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'fa-trash-o'
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(590094545006576331)
,p_plugin_id=>wwv_flow_imp.id(590064203593507066)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>8
,p_display_sequence=>80
,p_prompt=>'Icon CSS Class'
,p_attribute_type=>'TEXT'
,p_is_required=>false
,p_default_value=>'delete-icon'
,p_is_translatable=>false
);
wwv_flow_imp_shared.create_plugin_attribute(
 p_id=>wwv_flow_imp.id(590095008807579265)
,p_plugin_id=>wwv_flow_imp.id(590064203593507066)
,p_attribute_scope=>'COMPONENT'
,p_attribute_sequence=>9
,p_display_sequence=>90
,p_prompt=>'Region Static ID'
,p_attribute_type=>'TEXT'
,p_is_required=>true
,p_is_translatable=>false
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
