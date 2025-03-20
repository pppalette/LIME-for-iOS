/*
 * File: Config.h
 * Project: SilentPwn
 * Author: Batchh
 * Created: 2024-12-14
 *
 * Copyright (c) 2024 Batchh. All rights reserved.
 *
 * Description: Configuration file for SilentPwn
 */

#pragma once

extern const char* getCurrentFrameworkName();
extern const char* getCurrentFrameworkPath();
extern const char* getAppName();
extern const char* getAppVersion();

#define frameWork getCurrentFrameworkName()
#define frameWorkPath getCurrentFrameworkPath()
#define appName getAppName()
#define appVersion getAppVersion()

#define Author "@pppalette"
#define Version "2.0.0"
#define iOSGodsAuthorProfile "https://github.com/pppalette" // add your profile link

#define About "Author: " Author "\nVersion: " Version
#define changelog "2025/03/19 v1.0.0: first release.\n2025/03/20 v2.0.0: added ModMenu."

#define WAIT 0 // seconds

#define DebugMode true // This will enable debug tools
