@echo off
REM 设置字符编码为 UTF-8
chcp 65001 > nul

REM 提示用户选择包管理器
:choose_manager
echo 请选择包管理器：
echo npm. npm
echo pnpm. pnpm
echo yarn. yarn
set /p package_manager=请输入选项（npm 或 pnpm）: 

for /f "tokens=*" %%v in ('%package_manager% -v') do set npm_version=%%v
where %package_manager% > nul 2>nul
if %errorlevel% neq 0 (
    cls
    echo '%package_manager%' 未安装或未添加到系统路径.
   echo 请重新选择或安装%package_manager%后重新运行
    goto choose_manager
) else (
    echo '%package_manager%' 已安装，版本号为：%npm_version% 
)

REM 根据用户选择执行相应的命令
IF /I "%package_manager%"=="npm" (
    set command=npm init vite@latest --
    set init=--yes
) ELSE  (
    set command=pnpm create vite
    set init= 
) 

REM 提示用户输入项目名称
set /p project_name=请输入项目名称：

REM 创建项目
%command% %project_name% --template vue-ts %init%