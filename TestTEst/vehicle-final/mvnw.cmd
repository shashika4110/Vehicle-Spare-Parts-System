@REM ----------------------------------------------------------------------------
@REM Maven Wrapper - mvnw.cmd
@REM ----------------------------------------------------------------------------
@REM Script to run Maven Wrapper on Windows
@REM Generated content adapted for typical mvnw.cmd behavior
@REM ----------------------------------------------------------------------------
@echo off
setlocal

set MAVEN_PROJECTBASEDIR=%~dp0

:: If JAVA_HOME is set use it, else rely on java in PATH
if not defined JAVA_HOME (
  set JAVA_EXE=java
) else (
  set JAVA_EXE=%JAVA_HOME%\bin\java
)

:: Wrapper jar path
set WRAPPER_JAR=%MAVEN_PROJECTBASEDIR%\.mvn\wrapper\maven-wrapper.jar

if exist "%WRAPPER_JAR%" (
  "%JAVA_EXE%" -jar "%WRAPPER_JAR%" %*
  exit /b %errorlevel%
) else (
  echo Maven Wrapper JAR not found: %WRAPPER_JAR%
  echo Please run 'mvn -v' to ensure Maven is installed, or regenerate the Maven wrapper (mvn -N io.takari:maven:wrapper).
  exit /b 1
)

endlocal
