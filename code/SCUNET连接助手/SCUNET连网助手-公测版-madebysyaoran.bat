@echo off

title SCUNET�������ֹ����
setlocal enabledelayedexpansion
echo SCUNET�������֣���������һ���ۺ�¥���Ӳ���SCUNETʱ����ǿ�������ϵĽű�����syaoran����
echo=
echo ���µ�ַ��1.SCU����ܿ�ָ������ַ��https://scunet.syaoran.top
echo           2.����Ҫ������SCU��Դվ�ⲿȺ����Դվ��ַ��https://file.syaoran.top���ⲿQQȺ��534629825
echo=
echo ʹ��˵����ѡ�������ڵ����򣬽��޸�WIFI���ã��Զ����Ը������ר��ǿ������ģʽ�����Ժ���ʾ�򿪵�¼���棨����������ַ 192.168.2.135 ���س���
echo �����3����������򿪵�¼�����˵���ɹ��ˣ�һ��ÿ�����ӳɹ�����4�����ң�����򲻿��밴����ʾ���Լ��Σ��������ʮ���λ��������Ⱥ������
echo=
echo ע1��ǿ��ģʽֻ�ʺ��ض������SCUNET���������Ҫ��������WIFI����֮ǰ�ù�ǿ��ģʽ����ѡ������ġ��޸�Ϊ��ͨģʽ��������û������
echo ע2�����Ҽ�����ű��ļ�ʹ�ù���ԱȨ�����У������ױ���
echo ע3������SCUNET�źŽ�ǿ�����ӣ�����ɹ��ʲ��ߣ�����ڳ���ǿ�����Ӻ�WIFI�Ƕ��ߵ�״̬�����ȳ����ֶ��������£������ٰ�����ʾ���ԡ�
echo=

goto init

:init
set chose=
set ethernetAdapter=
set cks=
set subMask=
set gateway=
set DNS1=202.115.32.39
set DNS2=202.115.32.36
set defaultSubMask=255.255.255.0
echo �޸�Ϊ��ͨģʽ��������1
echo ����һ�̣�������2
echo �����ۺ�¥��������3
echo ����ͼ��ݣ�������4
echo=
set /p chose=��ѡ�����ѡ��:
netsh interface show interface
echo=
echo ������ʾ������������е�������Ϣ�������һ����
echo ѡ���������������Ľӿ����ƣ�һ����WLAN/WIFI/wireless�����������Ƶ��·����س���
echo һ��Ҫ��֤������ȷ����Ҫ��ո�
echo=
set /p adaptername=�������߽ӿ�����:

:reconnect
set ipAddr=

if !chose! == 1 ( 
    goto auto
) else ( 
    if !chose! == 2 ( 
        goto static2
    ) else ( 
      if !chose! == 3 ( 
          goto static3
      ) else (
        if !chose! == 4 ( 
            goto static4
        ) else (
               if !chose! == exit (
                  exit /b
               ) else (
                    goto error
                   )
                )
        )      
      )
)
:eof

:auto
echo �Զ�ģʽ
goto scanEthernetAdapter
:eof

:static2
echo=
set /a AA=10
set /a BB=132
set /a CC=!random! %% 15
set /a DD=!random! %% 254
set ipAddr=!AA!.!BB!.!CC!.!DD!
set subMask=255.255.240.0
set gateway=10.132.15.254
goto scanEthernetAdapter
:eof

:static3
echo=
set /a AA=10
set /a BB=132
set /a CC=!random! %% 3 + 36
set /a DD=!random! %% 254
set ipAddr=!AA!.!BB!.!CC!.!DD!
set subMask=255.255.252.0
set gateway=10.132.39.254
goto scanEthernetAdapter
:eof

:static4
echo=
set /a AA=10
set /a BB=132
set /a CC=!random! %% 4 + 28
set /a DD=!random! %% 254
set ipAddr=!AA!.!BB!.!CC!.!DD!
set subMask=255.255.252.0
set gateway=10.132.31.254
goto scanEthernetAdapter
:eof

:scanEthernetAdapter
set ethernetAdapter=%adaptername%
echo �����������������Ϊ!ethernetAdapter!
goto setup
pause
:eof

:setup
if !chose! == 1 (
    echo=
    echo ����������ͨģʽ...
    netsh interface ip set address name = %ethernetAdapter% source = dhcp
    netsh interface ip set dns name = %ethernetAdapter% source = dhcp
    echo ���óɹ�������������������WIFI��
) else (
    echo=
    echo ����ǿ������...
    if "%subMask%"=="" (
        echo=
        echo IP��ַ�� %ethernetAdapter% %ipAddr% %defaultSubMask% %gateway%
        netsh interface ip set addr name=%ethernetAdapter% source=static addr=%ipAddr% mask=%defaultSubMask% gateway=%gateway%
    ) else (
        echo=
        echo IP��ַ�� %ethernetAdapter% %ipAddr% %subMask% %gateway%
        netsh interface ip set addr name=%ethernetAdapter% source=static addr=%ipAddr% mask=%subMask% gateway=%gateway%
    )
    echo=
    echo ����������ѡDNS...
    cmd /c netsh interface ip set dns name=%ethernetAdapter% source=static addr=%DNS1% register=PRIMARY validate=no
    echo=
    echo �������ñ���DNS...
    cmd /c netsh interface ip add dns name=%ethernetAdapter% addr=%DNS2% validate=no
    echo=
    echo ǿ�������Ѿ����óɹ��������������ַ������192.168.2.135���س��Դ򿪵�¼ҳ
    echo=
    goto check
)
pause
exit /b
:eof

:check
echo �����Ƿ���������򿪵�¼ҳ����������1������������0����
set /p cks=������:
if !cks! == 1 (
      echo ллʹ�ã���ӭ��Ⱥ������534629825�������ڿ��Թرմ����ˣ��ǵ����ӱ��WIFIǰ�ָ�����ͨģʽŶ��
      pause
      exit /b
) else ( 
      if !cks! == 0 (
          goto reconnect
           ) else (
                goto error
                )   
        ) 
:eof

:error
echo=
echo �����������������
goto init
:eof