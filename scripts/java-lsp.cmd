@ECHO off

SET JAR=%LOCALAPPDATA%\nvim-data\mason\packages\jdtls\plugins\org.eclipse.equinox.launcher_*.jar

java -jar %JAR%
