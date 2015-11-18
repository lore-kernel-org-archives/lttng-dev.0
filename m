From: Hani Nemati <hani_nemati@yahoo.com>
Subject: Re: Lttng add-context perf commands gives me error
Date: Wed, 18 Nov 2015 20:19:20 +0000 (UTC)
Message-ID: <886413694.5732011.1447877960962.JavaMail.yahoo__4663.87623823739$1447878197$gmane$org@mail.yahoo.com>
References: <328787043.5258001.1447796792694.JavaMail.yahoo.ref@mail.yahoo.com>
 <328787043.5258001.1447796792694.JavaMail.yahoo@mail.yahoo.com>
 <824342841.114145.1447857930891.JavaMail.zimbra@efficios.com>
Reply-To: Hani Nemati <hani_nemati@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1793550993=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm42-vm6.bullet.mail.ne1.yahoo.com ([98.138.121.62])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <hani_nemati@yahoo.com>) id 1Zz9FA-0006MM-7o
 for lttng-dev@lists.lttng.org; Wed, 18 Nov 2015 15:22:18 -0500
In-Reply-To: <824342841.114145.1447857930891.JavaMail.zimbra@efficios.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1793550993==
Content-Type: multipart/alternative;
	boundary="----=_Part_5732010_1849134228.1447877960957"
Content-Length: 9640

------=_Part_5732010_1849134228.1447877960957
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

There is no PERF symbolic name for LLC-load-misses but I can use raw identi=
fier to find out Number of code read, data read that miss the LLC. Here is =
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

  
------=_Part_5732010_1849134228.1447877960957
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:times new roman, new york, times, serif;font-size:16px">There is=
 no PERF symbolic name for LLC-load-misses but I can use raw identifier to =
find out Number of code read, data read that miss the LLC. Here is the comm=
and that I used.<br class=3D"" id=3D"yui_3_16_0_1_1447797278790_35613">&nbs=
p;<br class=3D"" id=3D"yui_3_16_0_1_1447797278790_35615">#perf stat -e r010=
9 sleep 2<br class=3D"" id=3D"yui_3_16_0_1_1447797278790_35617">&nbsp;Perfo=
rmance counter stats for 'sleep 2':<br class=3D"" id=3D"yui_3_16_0_1_144779=
7278790_35619"><br class=3D"" id=3D"yui_3_16_0_1_1447797278790_35621">&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; 117&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r0109&nbsp; <br class=3D"" id=3D"yui=
_3_16_0_1_1447797278790_35623"><br class=3D"" id=3D"yui_3_16_0_1_1447797278=
790_35625">Do you have any idea why I don't have the symbolic name? Is ther=
e any way to give raw identifier instead of perf:cpu:LLC-load-misses? <br c=
lass=3D"" id=3D"yui_3_16_0_1_1447797278790_35627"><br class=3D"" id=3D"yui_=
3_16_0_1_1447797278790_35629"><br class=3D"" id=3D"yui_3_16_0_1_14477972787=
90_35631"><br class=3D"" id=3D"yui_3_16_0_1_1447797278790_35633"><div id=3D=
"yui_3_16_0_1_1447797278790_35843" dir=3D"ltr"><br></div><br><div class=3D"=
qtdSeparateBR"><br><br></div><div style=3D"display: block;" class=3D"yahoo_=
quoted"> <div style=3D"font-family: times new roman, new york, times, serif=
; font-size: 16px;"> <div style=3D"font-family: HelveticaNeue, Helvetica Ne=
ue, Helvetica, Arial, Lucida Grande, sans-serif; font-size: 16px;"> <div di=
r=3D"ltr"> <font face=3D"Arial" size=3D"2"> On Wednesday, November 18, 2015=
 9:45 AM, Mathieu Desnoyers &lt;mathieu.desnoyers@efficios.com&gt; wrote:<b=
r> </font> </div>  <br><br> <div class=3D"y_msg_container"><div id=3D"yiv34=
46413485"><div><div style=3D"font-family:arial, helvetica, sans-serif;font-=
size:12pt;color:#000000;"><div><br clear=3D"none"></div><div><br clear=3D"n=
one"></div><span id=3D"yiv3446413485zwchr">----- On Nov 17, 2015, at 4:46 P=
M, Hani Nemati &lt;hani_nemati@yahoo.com&gt; wrote:<br clear=3D"none"></spa=
n><div><blockquote style=3D"border-left:2px solid #1010FF;margin-left:5px;p=
adding-left:5px;color:#000;font-weight:normal;font-style:normal;text-decora=
tion:none;font-family:Helvetica, Arial, sans-serif;font-size:12pt;"><div st=
yle=3D"color:#000;background-color:#fff;font-family:times new roman, new yo=
rk, times, serif;font-size:16px;"><div dir=3D"ltr" id=3D"yiv3446413485yui_3=
_16_0_1_1447772874730_12112"><span id=3D"yiv3446413485yui_3_16_0_1_14477728=
74730_12163">Hi, <br class=3D"yiv3446413485" id=3D"yiv3446413485yui_3_16_0_=
1_1447772874730_12165" clear=3D"none">I am trying to count last level cache=
 misses by using lttng add-context command. I use add-context to add perf:c=
pu:LLC-load-misses to my channel but I see an error. There is no error for =
other perf events. Just two perf events including perf:cpu:LLC-load-misses =
and&nbsp; perf:cpu:LLC-store-misses give me the following error:<br class=
=3D"yiv3446413485" id=3D"yiv3446413485yui_3_16_0_1_1447772874730_12167" cle=
ar=3D"none">Error: perf:cpu:LLC-load-misses: Add kernel context failed<br c=
lass=3D"yiv3446413485" id=3D"yiv3446413485yui_3_16_0_1_1447772874730_12169"=
 clear=3D"none">Warning: Some command(s) went wrong<br class=3D"yiv34464134=
85" id=3D"yiv3446413485yui_3_16_0_1_1447772874730_12171" clear=3D"none"><br=
 class=3D"yiv3446413485" id=3D"yiv3446413485yui_3_16_0_1_1447772874730_1217=
3" clear=3D"none">Here is result of "uname -a" on my computer: <br class=3D=
"yiv3446413485" id=3D"yiv3446413485yui_3_16_0_1_1447772874730_12175" clear=
=3D"none">Linux nemati 3.16.0-51-generic #69~14.04.1-Ubuntu SMP Wed Oct 7 1=
5:32:41 UTC 2015 x86_64 x86_64 x86_64 GNU/Linux <br class=3D"yiv3446413485"=
 id=3D"yiv3446413485yui_3_16_0_1_1447772874730_12177" clear=3D"none"><br cl=
ass=3D"yiv3446413485" id=3D"yiv3446413485yui_3_16_0_1_1447772874730_12179" =
clear=3D"none"><br class=3D"yiv3446413485" id=3D"yiv3446413485yui_3_16_0_1_=
1447772874730_12181" clear=3D"none">Here is the command that I used: <br cl=
ass=3D"yiv3446413485" id=3D"yiv3446413485yui_3_16_0_1_1447772874730_12183" =
clear=3D"none">#lttng enable-channel -k test<br class=3D"yiv3446413485" id=
=3D"yiv3446413485yui_3_16_0_1_1447772874730_12185" clear=3D"none">#Kernel c=
hannel test enabled for session hh<br class=3D"yiv3446413485" id=3D"yiv3446=
413485yui_3_16_0_1_1447772874730_12187" clear=3D"none">#lttng add-context -=
k -t perf:cpu:LLC-load-misses -c test<br class=3D"yiv3446413485" id=3D"yiv3=
446413485yui_3_16_0_1_1447772874730_12189" clear=3D"none">Error: perf:cpu:L=
LC-load-misses: Add kernel context failed<br class=3D"yiv3446413485" id=3D"=
yiv3446413485yui_3_16_0_1_1447772874730_12191" clear=3D"none">Warning: Some=
 command(s) went wrong<br class=3D"yiv3446413485" id=3D"yiv3446413485yui_3_=
16_0_1_1447772874730_12193" clear=3D"none"><br class=3D"yiv3446413485" id=
=3D"yiv3446413485yui_3_16_0_1_1447772874730_12195" clear=3D"none"><br class=
=3D"yiv3446413485" id=3D"yiv3446413485yui_3_16_0_1_1447772874730_12197" cle=
ar=3D"none">I also tried it on other machines. </span></div></div></blockqu=
ote><div><br clear=3D"none"></div><div>It is possible that your architectur=
e does not expose this counter to perf.<br clear=3D"none"></div><div>Did yo=
u try using this PMC with the perf tool ?<br clear=3D"none"></div><div><br =
clear=3D"none"></div><div>Thanks,<br clear=3D"none"></div><div><br clear=3D=
"none"></div><div>Mathieu<div class=3D"yiv3446413485yqt4842675108" id=3D"yi=
v3446413485yqtfd64414"><br clear=3D"none"></div></div><div class=3D"yiv3446=
413485yqt4842675108" id=3D"yiv3446413485yqtfd37008"><div><br clear=3D"none"=
></div></div><blockquote style=3D"border-left:2px solid #1010FF;margin-left=
:5px;padding-left:5px;color:#000;font-weight:normal;font-style:normal;text-=
decoration:none;font-family:Helvetica, Arial, sans-serif;font-size:12pt;"><=
div style=3D"color:#000;background-color:#fff;font-family:times new roman, =
new york, times, serif;font-size:16px;"><div class=3D"yiv3446413485signatur=
e" id=3D"yiv3446413485yui_3_16_0_1_1447772874730_12155"><div id=3D"yiv34464=
13485yui_3_16_0_1_1447772874730_12154"><div class=3D"yiv3446413485yqt484267=
5108" id=3D"yiv3446413485yqtfd96110">&lt;&lt;&lt;&lt;&lt;&lt;&lt;&nbsp;&nbs=
p; </div><span style=3D"color:#ff0000;"><div class=3D"yiv3446413485yqt48426=
75108" id=3D"yiv3446413485yqtfd53272">&nbsp;/-/ /\ /\/ / /\/ <em>E</em> /\/=
\ /\ <em>T</em></div> /</span>&nbsp;&nbsp;&nbsp; &gt;&gt;&gt;&gt;&gt;&gt;&g=
t;&gt;</div></div></div><br clear=3D"none">________________________________=
_______________<br clear=3D"none">lttng-dev mailing list<br clear=3D"none">=
lttng-dev@lists.lttng.org<br clear=3D"none">http://lists.lttng.org/cgi-bin/=
mailman/listinfo/lttng-dev<br clear=3D"none"></blockquote></div><br clear=
=3D"none"><div>-- <br clear=3D"none"></div><div>Mathieu Desnoyers<br clear=
=3D"none">EfficiOS Inc.<br clear=3D"none">http://www.efficios.com</div></di=
v></div></div><br><br></div>  </div> </div>  </div></div></body></html>
------=_Part_5732010_1849134228.1447877960957--


--===============1793550993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1793550993==--
