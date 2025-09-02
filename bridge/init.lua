-- Framework detection function
local DetectFramework = function()
    if GetResourceState('qb-core') == 'started' then
        print('^3[DEBUG]^7 QBCore detected and loaded.')
        return 'qb', exports['qb-core']:GetCoreObject()
    end

    if GetResourceState('es_extended') == 'started' then
        print('^3[DEBUG]^7 ESX detected and loaded.')
        return 'esx', exports['es_extended']:getSharedObject()
    end

    print('^1[DEBUG]^7 No supported framework found (qb-core or es_extended not started).')
    return nil, nil
end

-- Detect and initialize framework
local framework, core = DetectFramework()

if not framework then
    error([[
        ^1CRITICAL ERROR: No supported framework detected!^0
        ^3This resource requires one of the following frameworks:^0
        - QBCore (qb-core)  
        - ESX (es_extended)
        
        Please ensure your framework is started before this resource.
    ]])
    return
end

Framework = framework
Core = core

-- Set framework-specific globals for compatibility
if Framework == 'qb' then
    QBCore = Core
    print('^2[INIT]^7 QBCore framework is now active.')
elseif Framework == 'esx' then
    ESX = Core
    print('^2[INIT]^7 ESX framework is now active.')
end
