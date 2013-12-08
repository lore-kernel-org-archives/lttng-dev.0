From: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Subject: =?utf-8?q?no_trace_data_are_collected_for_UST?=
Date: Sun, 08 Dec 2013 10:33:09 +0800
Message-ID: <c3d1fc94-92e2-43b3-af78-6315aaa7419d__43826.6030316756$1386470059$gmane$org@aliyun.com>
Reply-To: "zhenyu.ren" <zhenyu.ren@aliyun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1722363429=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtpcm9-302.freemail.mail.aliyun.com ([110.75.46.2])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <zhenyu.ren@aliyun.com>) id 1VpUBL-0002Ui-BL
	for lttng-dev@lists.lttng.org; Sat, 07 Dec 2013 21:33:24 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1722363429==
Content-Type: multipart/alternative;
  boundary="----=ALIBOUNDARY_3291_5adb3940_52a3da65_1189e"

------=ALIBOUNDARY_3291_5adb3940_52a3da65_1189e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, lttng-dev=C2=A0=C2=A0 =C2=A0 All seems well but no trace data are produced=
 for UST.=C2=A0(1) link static lib(.a) into target program=C2=A0 =C2=A0g++ -o =
target ... provider.o xx.o ... -ldl -llttng-ust -lurcu-cds -lurcu-bp -llttng-u=
st-tracepoint(2) run target and lttng-sessiond(root&uid)/consumerd etc....$ltt=
ng-startAvailable tracing sessions:=C2=A0 1) auto-20131208-100815 (/home/admin=
/lttng-traces/auto-20131208-100815) [active]Use lttng list <session_name> for =
more details$lttng list -uUST events:-------------=0APID: 42025 - Name: /home/=
admin/target=C2=A0 =C2=A0 =C2=A0 target_ioitem:AddIOWorkItem (loglevel: TRACE_=
DEBUG_LINE (13)) (type: tracepoint)$lttng list auto-20131208-100815Tracing ses=
sion auto-20131208-100815: [active]=C2=A0 =C2=A0 Trace path: /home/admin/lttng=
-traces/auto-20131208-100815=0A=3D=3D=3D Domain: UST global =3D=3D=3D=0ABuffer=
 type: per UID=0AChannels:-------------- channel0: [enabled]=0A=C2=A0 =C2=A0 A=
ttributes:=C2=A0 =C2=A0 =C2=A0 overwrite mode: 0=C2=A0 =C2=A0 =C2=A0 subbufers=
 size: 131072=C2=A0 =C2=A0 =C2=A0 number of subbufers: 4=C2=A0 =C2=A0 =C2=A0 s=
witch timer interval: 0=C2=A0 =C2=A0 =C2=A0 read timer interval: 0=C2=A0 =C2=A0=
 =C2=A0 output: mmap()=0A=C2=A0 =C2=A0 Events:=C2=A0 =C2=A0 =C2=A0 * (type: tr=
acepoint) [enabled]=0A$lttng stopWaiting for data availability......Tracing st=
opped for session auto-20131208-100815$ls -l ~/lttng-traces/auto-20131208-1008=
15/ust/uid/505/64-bit/total 100-rw-rw---- 1 admin admin 4096 Dec =C2=A08 10:11=
 channel0_0-rw-rw---- 1 admin admin 4096 Dec =C2=A08 10:11 channel0_1-rw-rw---=
- 1 admin admin 4096 Dec =C2=A08 10:11 channel0_10-rw-rw---- 1 admin admin 409=
6 Dec =C2=A08 10:11 channel0_11...-rw-rw---- 1 admin admin 4096 Dec =C2=A08 10=
:11 metadata$babeltrace ~/lttng-traces/auto-20131208-100815/"empty result"=C2=A0=
 =C2=A0I am very sure tracepoint=C2=A0target_ioitem:AddIOWorkItem has been run=
ning since printf log at the next line does work. Why lttng list -u shows me=C2=
=A0=C2=A0tracepoint=C2=A0target_ioitem:AddIOWorkItem there,but no trace data a=
re produced for ust?Thankszhenyu.ren
------=ALIBOUNDARY_3291_5adb3940_52a3da65_1189e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div class=3D"__aliyun_email_body_block"><div style=3D"color:#333333;font-size=
:14px;font-family:Tahoma,Arial,STHeiti,SimSun;;">Hi, lttng-dev&nbsp;</div><div=
 style=3D"color:#333333;font-size:14px;font-family:Tahoma,Arial,STHeiti,SimSun=
;;"><br data-mce-bogus=3D"1"></div><div style=3D"color:#333333;font-size:14px;=
font-family:Tahoma,Arial,STHeiti,SimSun;;">&nbsp; &nbsp; All seems well but no=
 trace data are produced for UST.&nbsp;</div><div style=3D"color:#333333;font-=
size:14px;font-family:Tahoma,Arial,STHeiti,SimSun;;"><br data-mce-bogus=3D"1">=
</div><div style=3D"color:#333333;font-size:14px;font-family:Tahoma,Arial,STHe=
iti,SimSun;;">(1) link static lib(.a) into target program</div><div style=3D"c=
olor:#333333;font-size:14px;font-family:Tahoma,Arial,STHeiti,SimSun;;">&nbsp; =
&nbsp;g++ -o target ... provider.o xx.o ... -ldl -llttng-ust -lurcu-cds -lurcu=
-bp -llttng-ust-tracepoint</div><div style=3D"color:#333333;font-size:14px;fon=
t-family:Tahoma,Arial,STHeiti,SimSun;;">(2) run target and lttng-sessiond(root=
&amp;uid)/consumerd etc.</div><div style=3D"color:#333333;font-size:14px;font-=
family:Tahoma,Arial,STHeiti,SimSun;;">...</div><div style=3D"color:#333333;fon=
t-size:14px;font-family:Tahoma,Arial,STHeiti,SimSun;;">$lttng-start</div><div =
style=3D"color:#333333;font-size:14px;font-family:Tahoma,Arial,STHeiti,SimSun;=
;"><div>Available tracing sessions:</div><div>&nbsp; 1) auto-20131208-100815 (=
/home/admin/lttng-traces/auto-20131208-100815) [active]</div><div>Use lttng li=
st &lt;session_name&gt; for more details</div><div><br data-mce-bogus=3D"1"></=
div><div><div>$lttng list -u</div><div>UST events:</div><div>-------------</di=
v><div><br></div><div>PID: 42025 - Name: /home/admin/target</div><div>&nbsp; &=
nbsp; &nbsp; target_ioitem:AddIOWorkItem (loglevel: TRACE_DEBUG_LINE (13)) (ty=
pe: tracepoint)</div><div><br data-mce-bogus=3D"1"></div><div><br data-mce-bog=
us=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div><div>$lttng list auto-=
20131208-100815</div><div>Tracing session auto-20131208-100815: [active]</div>=
<div>&nbsp; &nbsp; Trace path: /home/admin/lttng-traces/auto-20131208-100815</=
div><div><br></div><div>=3D=3D=3D Domain: UST global =3D=3D=3D</div><div><br><=
/div><div>Buffer type: per UID</div><div><br></div><div>Channels:</div><div>--=
-----------</div><div>- channel0: [enabled]</div><div><br></div><div>&nbsp; &n=
bsp; Attributes:</div><div>&nbsp; &nbsp; &nbsp; overwrite mode: 0</div><div>&n=
bsp; &nbsp; &nbsp; subbufers size: 131072</div><div>&nbsp; &nbsp; &nbsp; numbe=
r of subbufers: 4</div><div>&nbsp; &nbsp; &nbsp; switch timer interval: 0</div=
><div>&nbsp; &nbsp; &nbsp; read timer interval: 0</div><div>&nbsp; &nbsp; &nbs=
p; output: mmap()</div><div><br></div><div>&nbsp; &nbsp; Events:</div><div>&nb=
sp; &nbsp; &nbsp; * (type: tracepoint) [enabled]</div><div><br></div><div>$ltt=
ng stop</div><div><div>Waiting for data availability......</div><div>Tracing s=
topped for session auto-20131208-100815</div><div><br data-mce-bogus=3D"1"></d=
iv><div><div>$ls -l ~/lttng-traces/auto-20131208-100815/ust/uid/505/64-bit/</d=
iv><div>total 100</div><div>-rw-rw---- 1 admin admin 4096 Dec &nbsp;8 10:11 ch=
annel0_0</div><div>-rw-rw---- 1 admin admin 4096 Dec &nbsp;8 10:11 channel0_1<=
/div><div>-rw-rw---- 1 admin admin 4096 Dec &nbsp;8 10:11 channel0_10</div><di=
v>-rw-rw---- 1 admin admin 4096 Dec &nbsp;8 10:11 channel0_11</div><div>...</d=
iv><div>-rw-rw---- 1 admin admin 4096 Dec &nbsp;8 10:11 metadata</div><div><br=
 data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>$babeltra=
ce ~/lttng-traces/auto-20131208-100815/</div><div>"empty result"</div><div><br=
 data-mce-bogus=3D"1"></div><div>&nbsp; &nbsp;I am very sure tracepoint&nbsp;t=
arget_ioitem:AddIOWorkItem has been running since printf log at the next line =
does work. Why lttng list -u shows me&nbsp;&nbsp;tracepoint&nbsp;target_ioitem=
:AddIOWorkItem there,but no trace data are produced for ust?</div><div><br dat=
a-mce-bogus=3D"1"></div><div>Thanks</div><div>zhenyu.ren</div></div></div></di=
v></div></div></div>
------=ALIBOUNDARY_3291_5adb3940_52a3da65_1189e--



--===============1722363429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1722363429==--
