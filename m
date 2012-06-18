From: somanath sahoo <bapi_mvit2004@yahoo.com>
Subject: Re: lttng - ubuntu 11.10 - problem
Date: Sun, 17 Jun 2012 23:59:41 -0700 (PDT)
Message-ID: <1340002781.5676.YahooMailNeo__38029.4770039201$1340002818$gmane$org@web161206.mail.bf1.yahoo.com>
Reply-To: somanath sahoo <bapi_mvit2004@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1852497578=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm15.bullet.mail.bf1.yahoo.com ([98.139.212.174])
	by ltt.polymtl.ca with smtp (Exim 4.72)
	(envelope-from <bapi_mvit2004@yahoo.com>) id 1SgVwB-00040o-TM
	for lttng-dev@lists.lttng.org; Mon, 18 Jun 2012 02:59:48 -0400
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1852497578==
Content-Type: multipart/alternative; boundary="1938299484-191015705-1340002781=:5676"

--1938299484-191015705-1340002781=:5676
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,=0A=0AI have tried to reinstall lttng-tools,=C2=A0 lttng-modules-dkms=C2=
=A0 and babeltrace. =0A=0A=0Athe reinstallation of lttng-tools and babeltra=
ce has been successful. But reinstallation of lttng-modules-dkms has been f=
ailing. the log is provided below=0A=0A-------------------------start of lo=
g--------------=0A=0A# apt-get install --reinstall lttng-modules-dkms=0ARea=
ding package lists... Done=0ABuilding dependency tree=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 =0AReading state information... Done=0A0 upgraded, 0 newly =
installed, 1 reinstalled, 0 to remove and 0 not upgraded.=0ANeed to get 0 B=
/198 kB of archives.=0AAfter this operation, 0 B of additional disk space w=
ill be used.=0A(Reading database ... 199394 files and directories currently=
 installed.)=0APreparing to replace lttng-modules-dkms 2.0.0-0ubuntu2~oneir=
ic1 (using .../lttng-modules-dkms_2.0.0-0ubuntu2~oneiric1_all.deb) ...=0A=
=0A------------------------------=0ADeleting module version: 2.0.0=0Acomple=
tely from the DKMS tree.=0A------------------------------=0ADone.=0AUnpacki=
ng replacement lttng-modules-dkms ...=0ASetting up lttng-modules-dkms (2.0.=
0-0ubuntu2~oneiric1) ...=0ALoading new lttng-modules-2.0.0 DKMS files...=0A=
Building only for 3.0.0-21-generic=0ABuilding initial module for 3.0.0-21-g=
eneric=0AError! Bad return status for module build on kernel: 3.0.0-21-gene=
ric (i686)=0AConsult /var/lib/dkms/lttng-modules/2.0.0/build/make.log for m=
ore information.=0A=0A------------------------------ END OF LOG -----------=
--------------=0A=0AThe content of make.log is provided below : =0A=0A=0ADK=
MS make.log for lttng-modules-2.0.0 for kernel 3.0.0-21-generic (i686)=0AMo=
n Jun 18 12:05:51 IST 2012=0Amake: Entering directory `/usr/src/linux-heade=
rs-3.0.0-21-generic'=0A=C2=A0 CC [M]=C2=A0 /var/lib/dkms/lttng-modules/2.0.=
0/build/lttng-ring-buffer-client-discard.o=0A=C2=A0 CC [M]=C2=A0 /var/lib/d=
kms/lttng-modules/2.0.0/build/lttng-ring-buffer-client-overwrite.o=0A=C2=A0=
 CC [M]=C2=A0 /var/lib/dkms/lttng-modules/2.0.0/build/lttng-ring-buffer-met=
adata-client.o=0A=C2=A0 CC [M]=C2=A0 /var/lib/dkms/lttng-modules/2.0.0/buil=
d/lttng-ring-buffer-client-mmap-discard.o=0A=C2=A0 CC [M]=C2=A0 /var/lib/dk=
ms/lttng-modules/2.0.0/build/lttng-ring-buffer-client-mmap-overwrite.o=0A=
=C2=A0 CC [M]=C2=A0 /var/lib/dkms/lttng-modules/2.0.0/build/lttng-ring-buff=
er-metadata-mmap-client.o=0A=C2=A0 CC [M]=C2=A0 /var/lib/dkms/lttng-modules=
/2.0.0/build/lttng-statedump-impl.o=0A=C2=A0 CC [M]=C2=A0 /var/lib/dkms/ltt=
ng-modules/2.0.0/build/wrapper/irqdesc.o=0A=C2=A0 CC [M]=C2=A0 /var/lib/dkm=
s/lttng-modules/2.0.0/build/lttng-events.o=0A=C2=A0 CC [M]=C2=A0 /var/lib/d=
kms/lttng-modules/2.0.0/build/lttng-abi.o=0A=C2=A0 CC [M]=C2=A0 /var/lib/dk=
ms/lttng-modules/2.0.0/build/lttng-probes.o=0A=C2=A0 CC [M]=C2=A0 /var/lib/=
dkms/lttng-modules/2.0.0/build/lttng-context.o=0A=C2=A0 CC [M]=C2=A0 /var/l=
ib/dkms/lttng-modules/2.0.0/build/lttng-context-pid.o=0A=C2=A0 CC [M]=C2=A0=
 /var/lib/dkms/lttng-modules/2.0.0/build/lttng-context-procname.o=0A=C2=A0 =
CC [M]=C2=A0 /var/lib/dkms/lttng-modules/2.0.0/build/lttng-context-prio.o=
=0A=C2=A0 CC [M]=C2=A0 /var/lib/dkms/lttng-modules/2.0.0/build/lttng-contex=
t-nice.o=0A=C2=A0 CC [M]=C2=A0 /var/lib/dkms/lttng-modules/2.0.0/build/lttn=
g-context-vpid.o=0A=C2=A0 CC [M]=C2=A0 /var/lib/dkms/lttng-modules/2.0.0/bu=
ild/lttng-context-tid.o=0A=C2=A0 CC [M]=C2=A0 /var/lib/dkms/lttng-modules/2=
.0.0/build/lttng-context-vtid.o=0A=C2=A0 CC [M]=C2=A0 /var/lib/dkms/lttng-m=
odules/2.0.0/build/lttng-context-ppid.o=0A=C2=A0 CC [M]=C2=A0 /var/lib/dkms=
/lttng-modules/2.0.0/build/lttng-context-vppid.o=0A=C2=A0 CC [M]=C2=A0 /var=
/lib/dkms/lttng-modules/2.0.0/build/lttng-calibrate.o=0A=C2=A0 CC [M]=C2=A0=
 /var/lib/dkms/lttng-modules/2.0.0/build/wrapper/random.o=0A=C2=A0 CC [M]=
=C2=A0 /var/lib/dkms/lttng-modules/2.0.0/build/lttng-syscalls.o=0A/var/lib/=
dkms/lttng-modules/2.0.0/build/lttng-syscalls.c:32:38: error: macro "is_com=
pat_task" passed 1 arguments, but takes just 0=0A/var/lib/dkms/lttng-module=
s/2.0.0/build/lttng-syscalls.c:33:1: error: expected =E2=80=98=3D=E2=80=99,=
 =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=98asm=E2=80=99 or =E2=80=
=98__attribute__=E2=80=99 before =E2=80=98{=E2=80=99 token=0Amake[1]: *** [=
/var/lib/dkms/lttng-modules/2.0.0/build/lttng-syscalls.o] Error 1=0Amake: *=
** [_module_/var/lib/dkms/lttng-modules/2.0.0/build] Error 2=0Amake: Leavin=
g directory `/usr/src/linux-headers-3.0.0-21-generic'=0A=0A----------------=
--------- End of make.log -----------------=0A=0AAs per the compilation err=
ors in the file lttng-syscalls.c, i dont think these errors are valids. It =
may be due to somethings else.=0A=0A=0AKindly guide how to come over this r=
einstallation problem of "lttng-modules-dkms" and please let me know if i n=
eed to do any other alternatives.=0A=0A=0A=0A=0AThanks & Regards,=0ASomanat=
h=0A=0A=0A------------------------------=0A=0AMessage: 3=0ADate: Fri, 15 Ju=
n 2012 09:12:40 -0400=0AFrom: David Goulet <david.goulet@polymtl.ca>=0ATo: =
Francis Giraldeau <francis.giraldeau@gmail.com>=0ACc: "lttng-dev@lists.lttn=
g.org" <lttng-dev@lists.lttng.org>=0ASubject: Re: [lttng-dev] lttng - ubunt=
u 11.10 - problem=0AMessage-ID: <4FDB34C8.7000505@polymtl.ca>=0AContent-Typ=
e: text/plain; charset=3DISO-8859-1=0A=0A-----BEGIN PGP SIGNED MESSAGE-----=
=0AHash: SHA1=0A=0AHi,=0A=0AIn order to trace the kernel, you need the LTTn=
g kernel modules available in=0Athe package "lttng-modules-dkms". So make s=
ure you have these three packages=0Ainstalled:=0A=0A# sudo apt-get install =
lttng-tools lttng-modules-dkms babeltrace=0A=0AThe error message you got in=
dicates that there is simply no LTTng modules=0Aloaded. Please make sure th=
ey are loaded and if the problem persist, let us know!=0A=0AThanks!=0ADavid=
=0A=0AOn 15/06/12 04:16 AM, Francis Giraldeau wrote:=0A> Le 2012-06-15 09:4=
1, somanath sahoo a ?crit :=0A>> Hi,=0A>> =0A>> As i am new to lttng usage,=
 I have followed the instructions from =0A>> <https://launchpad.net/~lttng/=
+archive/ppa> in order to install the lttng=0A>> tool set in my ubuntu 11.1=
0. After successful installation, i followed=0A>> the getting started link =
on lttng.org <http://lttng.org/quickstart> in=0A>> "root mode".=0A> =0A> Yo=
u may verify if kernel modules are loaded correctly. If not, then there=0A>=
 may be a problem while the installation.=0A> =0A> lsmod | grep lttng=0A> =
=0A> If not, you may try to load them and see if any error message occurs:=
=0A> =0A> sudo modprobe lttng_tracer=0A> =0A> Francis=0A> =0A> 
--1938299484-191015705-1340002781=:5676
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div>Hi,</div><div><b=
r></div><div>I have tried to reinstall lttng-tools,&nbsp; lttng-modules-dkm=
s&nbsp; and babeltrace. <br></div><div><br></div><div>the reinstallation of=
 lttng-tools and babeltrace has been successful. But reinstallation of lttn=
g-modules-dkms has been failing. the log is provided below</div><div><br></=
div><div>-------------------------start of log--------------</div><div><br>=
</div><div># apt-get install --reinstall lttng-modules-dkms<br>Reading pack=
age lists... Done<br>Building dependency tree&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; <br>Reading state information... Done<br>0 upgraded, 0 newly install=
ed, 1 reinstalled, 0 to remove and 0 not upgraded.<br>Need to get 0 B/198 k=
B of archives.<br>After this operation, 0 B of additional disk space will b=
e used.<br>(Reading database ... 199394 files and directories
 currently installed.)<br>Preparing to replace lttng-modules-dkms 2.0.0-0ub=
untu2~oneiric1 (using .../lttng-modules-dkms_2.0.0-0ubuntu2~oneiric1_all.de=
b) ...<br><br>------------------------------<br>Deleting module version: 2.=
0.0<br>completely from the DKMS tree.<br>------------------------------<br>=
Done.<br>Unpacking replacement lttng-modules-dkms ...<br>Setting up lttng-m=
odules-dkms (2.0.0-0ubuntu2~oneiric1) ...<br>Loading new lttng-modules-2.0.=
0 DKMS files...<br>Building only for 3.0.0-21-generic<br>Building initial m=
odule for 3.0.0-21-generic<br>Error! Bad return status for module build on =
kernel: 3.0.0-21-generic (i686)<br>Consult /var/lib/dkms/lttng-modules/2.0.=
0/build/make.log for more information.</div><div><br></div><div>-----------=
------------------- END OF LOG -------------------------</div><div><br></di=
v><div>The content of make.log is provided below : <br></div><div><br></div=
><div>DKMS make.log for lttng-modules-2.0.0 for kernel
 3.0.0-21-generic (i686)<br>Mon Jun 18 12:05:51 IST 2012<br>make: Entering =
directory `/usr/src/linux-headers-3.0.0-21-generic'<br>&nbsp; CC [M]&nbsp; =
/var/lib/dkms/lttng-modules/2.0.0/build/lttng-ring-buffer-client-discard.o<=
br>&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.0.0/build/lttng-ring-b=
uffer-client-overwrite.o<br>&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules=
/2.0.0/build/lttng-ring-buffer-metadata-client.o<br>&nbsp; CC [M]&nbsp; /va=
r/lib/dkms/lttng-modules/2.0.0/build/lttng-ring-buffer-client-mmap-discard.=
o<br>&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.0.0/build/lttng-ring=
-buffer-client-mmap-overwrite.o<br>&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-=
modules/2.0.0/build/lttng-ring-buffer-metadata-mmap-client.o<br>&nbsp; CC [=
M]&nbsp; /var/lib/dkms/lttng-modules/2.0.0/build/lttng-statedump-impl.o<br>=
&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.0.0/build/wrapper/irqdesc=
.o<br>&nbsp; CC [M]&nbsp;
 /var/lib/dkms/lttng-modules/2.0.0/build/lttng-events.o<br>&nbsp; CC [M]&nb=
sp; /var/lib/dkms/lttng-modules/2.0.0/build/lttng-abi.o<br>&nbsp; CC [M]&nb=
sp; /var/lib/dkms/lttng-modules/2.0.0/build/lttng-probes.o<br>&nbsp; CC [M]=
&nbsp; /var/lib/dkms/lttng-modules/2.0.0/build/lttng-context.o<br>&nbsp; CC=
 [M]&nbsp; /var/lib/dkms/lttng-modules/2.0.0/build/lttng-context-pid.o<br>&=
nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.0.0/build/lttng-context-pr=
ocname.o<br>&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.0.0/build/ltt=
ng-context-prio.o<br>&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.0.0/=
build/lttng-context-nice.o<br>&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modul=
es/2.0.0/build/lttng-context-vpid.o<br>&nbsp; CC [M]&nbsp; /var/lib/dkms/lt=
tng-modules/2.0.0/build/lttng-context-tid.o<br>&nbsp; CC [M]&nbsp; /var/lib=
/dkms/lttng-modules/2.0.0/build/lttng-context-vtid.o<br>&nbsp; CC [M]&nbsp;
 /var/lib/dkms/lttng-modules/2.0.0/build/lttng-context-ppid.o<br>&nbsp; CC =
[M]&nbsp; /var/lib/dkms/lttng-modules/2.0.0/build/lttng-context-vppid.o<br>=
&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.0.0/build/lttng-calibrate=
.o<br>&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.0.0/build/wrapper/r=
andom.o<br>&nbsp; CC [M]&nbsp; /var/lib/dkms/lttng-modules/2.0.0/build/lttn=
g-syscalls.o<br>/var/lib/dkms/lttng-modules/2.0.0/build/lttng-syscalls.c:32=
:38: error: macro "is_compat_task" passed 1 arguments, but takes just 0<br>=
/var/lib/dkms/lttng-modules/2.0.0/build/lttng-syscalls.c:33:1: error: expec=
ted =E2=80=98=3D=E2=80=99, =E2=80=98,=E2=80=99, =E2=80=98;=E2=80=99, =E2=80=
=98asm=E2=80=99 or =E2=80=98__attribute__=E2=80=99 before =E2=80=98{=E2=80=
=99 token<br>make[1]: *** [/var/lib/dkms/lttng-modules/2.0.0/build/lttng-sy=
scalls.o] Error 1<br>make: *** [_module_/var/lib/dkms/lttng-modules/2.0.0/b=
uild] Error 2<br>make: Leaving directory `/usr/src/linux-headers-3.0.0-21-g=
eneric'</div><div><br></div><div>------------------------- End of
 make.log -----------------</div><div><br></div><div>As per the compilation=
 errors in the file lttng-syscalls.c, i dont think these errors are valids.=
 It may be due to somethings else.<br></div><div><br></div><div>Kindly guid=
e how to come over this reinstallation problem of "lttng-modules-dkms" and =
please let me know if i need to do any other alternatives.<br></div><div><b=
r></div><div><br></div><div><br></div><div>Thanks &amp; Regards,<br>Somanat=
h<br></div><div><br></div><div>------------------------------<br><br>Messag=
e: 3<br>Date: Fri, 15 Jun 2012 09:12:40 -0400<br>From: David Goulet &lt;<a =
href=3D"mailto:david.goulet@polymtl.ca">david.goulet@polymtl.ca</a>&gt;<br>=
To: Francis Giraldeau &lt;<a href=3D"mailto:francis.giraldeau@gmail.com">fr=
ancis.giraldeau@gmail.com</a>&gt;<br>Cc: "<a href=3D"mailto:lttng-dev@lists=
.lttng.org">lttng-dev@lists.lttng.org</a>" &lt;<a href=3D"mailto:lttng-dev@=
lists.lttng.org">lttng-dev@lists.lttng.org</a>&gt;<br>Subject: Re:
 [lttng-dev] lttng - ubuntu 11.10 - problem<br>Message-ID: &lt;<a href=3D"m=
ailto:4FDB34C8.7000505@polymtl.ca">4FDB34C8.7000505@polymtl.ca</a>&gt;<br>C=
ontent-Type: text/plain; charset=3DISO-8859-1<br><br>-----BEGIN PGP SIGNED =
MESSAGE-----<br>Hash: SHA1<br><br>Hi,<br><br>In order to trace the kernel, =
you need the LTTng kernel modules available in<br>the package "lttng-module=
s-dkms". So make sure you have these three packages<br>installed:<br><br># =
sudo apt-get install lttng-tools lttng-modules-dkms babeltrace<br><br>The e=
rror message you got indicates that there is simply no LTTng modules<br>loa=
ded. Please make sure they are loaded and if the problem persist, let us kn=
ow!<br><br>Thanks!<br>David<br><br>On 15/06/12 04:16 AM, Francis Giraldeau =
wrote:<br>&gt; Le 2012-06-15 09:41, somanath sahoo a ?crit :<br>&gt;&gt; Hi=
,<br>&gt;&gt; <br>&gt;&gt; As i am new to lttng usage, I have followed the =
instructions from <br>&gt;&gt; &lt;<a
 href=3D"https://launchpad.net/%7Elttng/+archive/ppa" target=3D"_blank">htt=
ps://launchpad.net/~lttng/+archive/ppa</a>&gt; in order to install the lttn=
g<br>&gt;&gt; tool set in my ubuntu 11.10. After successful installation, i=
 followed<br>&gt;&gt; the getting started link on lttng.org &lt;<a href=3D"=
http://lttng.org/quickstart" target=3D"_blank">http://lttng.org/quickstart<=
/a>&gt; in<br>&gt;&gt; "root mode".<br>&gt; <br>&gt; You may verify if kern=
el modules are loaded correctly. If not, then there<br>&gt; may be a proble=
m while the installation.<br>&gt; <br>&gt; lsmod | grep lttng<br>&gt; <br>&=
gt; If not, you may try to load them and see if any error message occurs:<b=
r>&gt; <br>&gt; sudo modprobe lttng_tracer<br>&gt; <br>&gt; Francis<br>&gt;=
 <br>&gt; </div></div></body></html>
--1938299484-191015705-1340002781=:5676--


--===============1852497578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1852497578==--
