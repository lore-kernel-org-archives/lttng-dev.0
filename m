From: Hani Nemati <hani_nemati@yahoo.com>
Subject: Lttng add-context perf commands gives me error
Date: Thu, 19 Nov 2015 15:37:18 +0000 (UTC)
Message-ID: <1043364994.6119959.1447947438952.JavaMail.yahoo__49842.7477352836$1447947707$gmane$org@mail.yahoo.com>
References: <328787043.5258001.1447796792694.JavaMail.yahoo.ref@mail.yahoo.com>
 <328787043.5258001.1447796792694.JavaMail.yahoo@mail.yahoo.com>
 <824342841.114145.1447857930891.JavaMail.zimbra@efficios.com>
 <886413694.5732011.1447877960962.JavaMail.yahoo@mail.yahoo.com>
Reply-To: Hani Nemati <hani_nemati@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1279068561=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm36-vm6.bullet.mail.ne1.yahoo.com ([98.138.229.118])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <hani_nemati@yahoo.com>) id 1ZzRK7-0003oK-Qv
 for lttng-dev@lists.lttng.org; Thu, 19 Nov 2015 10:40:37 -0500
In-Reply-To: <886413694.5732011.1447877960962.JavaMail.yahoo@mail.yahoo.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1279068561==
Content-Type: multipart/alternative;
	boundary="----=_Part_6119958_13304706.1447947438942"
Content-Length: 13281

------=_Part_6119958_13304706.1447947438942
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Hi Mathieu,=20
LCC is last level cache and it is shared between CPU cores. Also, I was run=
ning several VMs in background. That's why I used sleep command.=C2=A0Based=
 on Intel's manual r0109 is raw identifier for LCC-load-misses,=20
The question is how can I fix the problem since Lttng is using perf symboli=
c name.=20

Thanks,=20
Hani =C2=A0

     On Wednesday, November 18, 2015 3:19 PM, Hani Nemati <hani_nemati@yaho=
o.com> wrote:
=20

 There is no PERF symbolic name for LLC-load-misses but I can use raw ident=
ifier to find out Number of code read, data read that miss the LLC. Here is=
 the command that I used.
=C2=A0
#perf stat -e r0109 sleep 2
=C2=A0Performance counter stats for 'sleep 2':

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 117=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r0109=C2=A0=20

Do you have any idea why I don't have the symbolic name? Is there any way t=
o give raw identifier instead of perf:cpu:LLC-load-misses?=20







     On Wednesday, November 18, 2015 9:45 AM, Mathieu Desnoyers <mathieu.de=
snoyers@efficios.com> wrote:
  =20

=20

----- On Nov 17, 2015, at 4:46 PM, Hani Nemati <hani_nemati@yahoo.com> wrot=
e:

Hi,=20
I am trying to count last level cache misses by using lttng add-context com=
mand. I use add-context to add perf:cpu:LLC-load-misses to my channel but I=
 see an error. There is no error for other perf events. Just two perf event=
s including perf:cpu:LLC-load-misses and=C2=A0 perf:cpu:LLC-store-misses gi=
ve me the following error:
Error: perf:cpu:LLC-load-misses: Add kernel context failed
Warning: Some command(s) went wrong

Here is result of "uname -a" on my computer:=20
Linux nemati 3.16.0-51-generic #69~14.04.1-Ubuntu SMP Wed Oct 7 15:32:41 UT=
C 2015 x86_64 x86_64 x86_64 GNU/Linux=20


Here is the command that I used:=20
#lttng enable-channel -k test
#Kernel channel test enabled for session hh
#lttng add-context -k -t perf:cpu:LLC-load-misses -c test
Error: perf:cpu:LLC-load-misses: Add kernel context failed
Warning: Some command(s) went wrong


I also tried it on other machines.=20

It is possible that your architecture does not expose this counter to perf.
Did you try using this PMC with the perf tool ?

Thanks,

Mathieu


<<<<<<<=C2=A0=C2=A0 =C2=A0/-/ /\ /\/ / /\/ E /\/\ /\ T /=C2=A0=C2=A0=C2=A0 =
>>>>>>>>
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

  =20

  
------=_Part_6119958_13304706.1447947438942
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:times new roman, new york, times, serif;font-size:16px"><div id=
=3D"yui_3_16_0_1_1447880899551_31232"><br><span></span></div><div dir=3D"lt=
r" id=3D"yui_3_16_0_1_1447880899551_31331"><span class=3D"" id=3D"yui_3_16_=
0_1_1447880899551_31564">Hi </span><span id=3D"yui_3_16_0_1_1447880899551_3=
1564"><span class=3D"" id=3D"yui_3_16_0_1_1447880899551_31748">Mathieu</spa=
n>, <br></span></div><div id=3D"yui_3_16_0_1_1447880899551_31394"><span id=
=3D"yui_3_16_0_1_1447880899551_31393">LCC is last level cache and it is sha=
red between CPU cores. Also, I was running several VMs in background. That'=
s why I used sleep command.&nbsp;</span></div><div id=3D"yui_3_16_0_1_14478=
80899551_31749"><span id=3D"yui_3_16_0_1_1447880899551_31393">Based on Inte=
l's manual r0109 is raw identifier for LCC-load-misses, <br></span></div><d=
iv dir=3D"ltr" id=3D"yui_3_16_0_1_1447880899551_31420"><span id=3D"yui_3_16=
_0_1_1447880899551_31393">The question is how can I fix the problem since L=
ttng is using perf symbolic name. <br></span></div><div id=3D"yui_3_16_0_1_=
1447880899551_31534" dir=3D"ltr"><br><span id=3D"yui_3_16_0_1_1447880899551=
_31393"></span></div><div id=3D"yui_3_16_0_1_1447880899551_31535" dir=3D"lt=
r"><span id=3D"yui_3_16_0_1_1447880899551_31393">Thanks, <br></span></div><=
div id=3D"yui_3_16_0_1_1447880899551_31560" dir=3D"ltr"><span id=3D"yui_3_1=
6_0_1_1447880899551_31393">Hani </span></div><div id=3D"yui_3_16_0_1_144788=
0899551_31561" class=3D"qtdSeparateBR">&nbsp;<br><br></div>  <div style=3D"=
display: block;" id=3D"yui_3_16_0_1_1447880899551_31652" class=3D"yahoo_quo=
ted"> <div id=3D"yui_3_16_0_1_1447880899551_31651" style=3D"font-family: ti=
mes new roman, new york, times, serif; font-size: 16px;"> <div id=3D"yui_3_=
16_0_1_1447880899551_31650" style=3D"font-family: HelveticaNeue, Helvetica =
Neue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 16px;"> <div =
id=3D"yui_3_16_0_1_1447880899551_31649" dir=3D"ltr"><font id=3D"yui_3_16_0_=
1_1447880899551_31648" face=3D"Arial" size=3D"2"> On Wednesday, November 18=
, 2015 3:19 PM, Hani Nemati &lt;hani_nemati@yahoo.com&gt; wrote:<br></font>=
</div>  <br><br> <div id=3D"yui_3_16_0_1_1447880899551_31962" class=3D"y_ms=
g_container"><div id=3D"yiv4671081710"><div id=3D"yui_3_16_0_1_144788089955=
1_31961"><div id=3D"yui_3_16_0_1_1447880899551_31960" style=3D"color:#000;b=
ackground-color:#fff;font-family:times new roman, new york, times, serif;fo=
nt-size:16px;">There is no PERF symbolic name for LLC-load-misses but I can=
 use raw identifier to find out Number of code read, data read that miss th=
e LLC. Here is the command that I used.<br class=3D"yiv4671081710" id=3D"yi=
v4671081710yui_3_16_0_1_1447797278790_35613" clear=3D"none">&nbsp;<br class=
=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447797278790_35615" cle=
ar=3D"none">#perf stat -e r0109 sleep 2<br class=3D"yiv4671081710" id=3D"yi=
v4671081710yui_3_16_0_1_1447797278790_35617" clear=3D"none">&nbsp;Performan=
ce counter stats for 'sleep 2':<br class=3D"yiv4671081710" id=3D"yiv4671081=
710yui_3_16_0_1_1447797278790_35619" clear=3D"none"><br class=3D"yiv4671081=
710" id=3D"yiv4671081710yui_3_16_0_1_1447797278790_35621" clear=3D"none">&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; 117&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r0109&nbsp; <br class=3D"yiv46710=
81710" id=3D"yiv4671081710yui_3_16_0_1_1447797278790_35623" clear=3D"none">=
<br class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447797278790_3=
5625" clear=3D"none">Do you have any idea why I don't have the symbolic nam=
e? Is there any way to give raw identifier instead of perf:cpu:LLC-load-mis=
ses? <br class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447797278=
790_35627" clear=3D"none"><br class=3D"yiv4671081710" id=3D"yiv4671081710yu=
i_3_16_0_1_1447797278790_35629" clear=3D"none"><br class=3D"yiv4671081710" =
id=3D"yiv4671081710yui_3_16_0_1_1447797278790_35631" clear=3D"none"><br cla=
ss=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447797278790_35633" c=
lear=3D"none"><div dir=3D"ltr" id=3D"yiv4671081710yui_3_16_0_1_144779727879=
0_35843"><br clear=3D"none"></div><br clear=3D"none"><div class=3D"yiv46710=
81710qtdSeparateBR"><br clear=3D"none"><br clear=3D"none"></div><div class=
=3D"yiv4671081710yqt9882023943" id=3D"yiv4671081710yqt48910"><div class=3D"=
yiv4671081710yahoo_quoted" style=3D"display:block;"> <div style=3D"font-fam=
ily:times new roman, new york, times, serif;font-size:16px;"> <div style=3D=
"font-family:HelveticaNeue, Helvetica Neue, Helvetica, Arial, Lucida Grande=
, sans-serif;font-size:16px;"> <div dir=3D"ltr"> <font face=3D"Arial" size=
=3D"2"> On Wednesday, November 18, 2015 9:45 AM, Mathieu Desnoyers &lt;math=
ieu.desnoyers@efficios.com&gt; wrote:<br clear=3D"none"> </font> </div>  <b=
r clear=3D"none"><br clear=3D"none"> <div class=3D"yiv4671081710y_msg_conta=
iner"><div id=3D"yiv4671081710"><div><div style=3D"font-family:arial, helve=
tica, sans-serif;font-size:12pt;color:#000000;"><div><br clear=3D"none"></d=
iv><div><br clear=3D"none"></div><span id=3D"yiv4671081710zwchr">----- On N=
ov 17, 2015, at 4:46 PM, Hani Nemati &lt;hani_nemati@yahoo.com&gt; wrote:<b=
r clear=3D"none"></span><div><blockquote style=3D"border-left:2px solid #10=
10FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-st=
yle:normal;text-decoration:none;font-family:Helvetica, Arial, sans-serif;fo=
nt-size:12pt;"><div style=3D"color:#000;background-color:#fff;font-family:t=
imes new roman, new york, times, serif;font-size:16px;"><div dir=3D"ltr" id=
=3D"yiv4671081710yui_3_16_0_1_1447772874730_12112"><span id=3D"yiv467108171=
0yui_3_16_0_1_1447772874730_12163">Hi, <br class=3D"yiv4671081710" id=3D"yi=
v4671081710yui_3_16_0_1_1447772874730_12165" clear=3D"none">I am trying to =
count last level cache misses by using lttng add-context command. I use add=
-context to add perf:cpu:LLC-load-misses to my channel but I see an error. =
There is no error for other perf events. Just two perf events including per=
f:cpu:LLC-load-misses and&nbsp; perf:cpu:LLC-store-misses give me the follo=
wing error:<br class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447=
772874730_12167" clear=3D"none">Error: perf:cpu:LLC-load-misses: Add kernel=
 context failed<br class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_=
1447772874730_12169" clear=3D"none">Warning: Some command(s) went wrong<br =
class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447772874730_12171=
" clear=3D"none"><br class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_=
1_1447772874730_12173" clear=3D"none">Here is result of "uname -a" on my co=
mputer: <br class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447772=
874730_12175" clear=3D"none">Linux nemati 3.16.0-51-generic #69~14.04.1-Ubu=
ntu SMP Wed Oct 7 15:32:41 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux <br clas=
s=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447772874730_12177" cl=
ear=3D"none"><br class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_14=
47772874730_12179" clear=3D"none"><br class=3D"yiv4671081710" id=3D"yiv4671=
081710yui_3_16_0_1_1447772874730_12181" clear=3D"none">Here is the command =
that I used: <br class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_14=
47772874730_12183" clear=3D"none">#lttng enable-channel -k test<br class=3D=
"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447772874730_12185" clear=
=3D"none">#Kernel channel test enabled for session hh<br class=3D"yiv467108=
1710" id=3D"yiv4671081710yui_3_16_0_1_1447772874730_12187" clear=3D"none">#=
lttng add-context -k -t perf:cpu:LLC-load-misses -c test<br class=3D"yiv467=
1081710" id=3D"yiv4671081710yui_3_16_0_1_1447772874730_12189" clear=3D"none=
">Error: perf:cpu:LLC-load-misses: Add kernel context failed<br class=3D"yi=
v4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447772874730_12191" clear=3D"=
none">Warning: Some command(s) went wrong<br class=3D"yiv4671081710" id=3D"=
yiv4671081710yui_3_16_0_1_1447772874730_12193" clear=3D"none"><br class=3D"=
yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_1447772874730_12195" clear=
=3D"none"><br class=3D"yiv4671081710" id=3D"yiv4671081710yui_3_16_0_1_14477=
72874730_12197" clear=3D"none">I also tried it on other machines. </span></=
div></div></blockquote><div><br clear=3D"none"></div><div>It is possible th=
at your architecture does not expose this counter to perf.<br clear=3D"none=
"></div><div>Did you try using this PMC with the perf tool ?<br clear=3D"no=
ne"></div><div><br clear=3D"none"></div><div>Thanks,<br clear=3D"none"></di=
v><div><br clear=3D"none"></div><div>Mathieu<div class=3D"yiv4671081710yqt4=
842675108" id=3D"yiv4671081710yqtfd64414"><br clear=3D"none"></div></div><d=
iv class=3D"yiv4671081710yqt4842675108" id=3D"yiv4671081710yqtfd37008"><div=
><br clear=3D"none"></div></div><blockquote style=3D"border-left:2px solid =
#1010FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font=
-style:normal;text-decoration:none;font-family:Helvetica, Arial, sans-serif=
;font-size:12pt;"><div style=3D"color:#000;background-color:#fff;font-famil=
y:times new roman, new york, times, serif;font-size:16px;"><div class=3D"yi=
v4671081710signature" id=3D"yiv4671081710yui_3_16_0_1_1447772874730_12155">=
<div id=3D"yiv4671081710yui_3_16_0_1_1447772874730_12154"><div class=3D"yiv=
4671081710yqt4842675108" id=3D"yiv4671081710yqtfd96110">&lt;&lt;&lt;&lt;&lt=
;&lt;&lt;&nbsp;&nbsp; </div><span style=3D"color:#ff0000;"></span><div clas=
s=3D"yiv4671081710yqt4842675108" id=3D"yiv4671081710yqtfd53272">&nbsp;/-/ /=
\ /\/ / /\/ <em>E</em> /\/\ /\ <em>T</em></div> /&nbsp;&nbsp;&nbsp; &gt;&gt=
;&gt;&gt;&gt;&gt;&gt;&gt;</div></div></div><br clear=3D"none">_____________=
__________________________________<br clear=3D"none">lttng-dev mailing list=
<br clear=3D"none">lttng-dev@lists.lttng.org<br clear=3D"none">http://lists=
.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br clear=3D"none"></blockquot=
e></div><br clear=3D"none"><div>-- <br clear=3D"none"></div><div>Mathieu De=
snoyers<br clear=3D"none">EfficiOS Inc.<br clear=3D"none">http://www.effici=
os.com</div></div></div></div><br clear=3D"none"><br clear=3D"none"></div> =
 </div> </div>  </div></div></div></div></div><br><br></div>  </div> </div>=
  </div></div></body></html>
------=_Part_6119958_13304706.1447947438942--


--===============1279068561==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1279068561==--
