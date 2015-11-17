From: Hani Nemati <hani_nemati@yahoo.com>
Subject: Lttng add-context perf commands gives me error
Date: Tue, 17 Nov 2015 21:46:32 +0000 (UTC)
Message-ID: <328787043.5258001.1447796792694.JavaMail.yahoo__22446.9146495268$1447797025$gmane$org@mail.yahoo.com>
References: <328787043.5258001.1447796792694.JavaMail.yahoo.ref@mail.yahoo.com>
Reply-To: Hani Nemati <hani_nemati@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0270064180=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from nm32-vm9.bullet.mail.ne1.yahoo.com ([98.138.229.57])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <hani_nemati@yahoo.com>) id 1Zyo81-0007xR-Er
 for lttng-dev@lists.lttng.org; Tue, 17 Nov 2015 16:49:30 -0500
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

--===============0270064180==
Content-Type: multipart/alternative;
	boundary="----=_Part_5258000_1235831345.1447796792691"
Content-Length: 3812

------=_Part_5258000_1235831345.1447796792691
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

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


I also tried it on other machines. =C2=A0<<<<<<<=C2=A0=C2=A0 =C2=A0/-/ /\ /=
\/ / /\/ E /\/\ /\ T /=C2=A0=C2=A0=C2=A0 >>>>>>>>
------=_Part_5258000_1235831345.1447796792691
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><div style=3D"color:#000; background-color:#fff; f=
ont-family:times new roman, new york, times, serif;font-size:16px"><div dir=
=3D"ltr" id=3D"yui_3_16_0_1_1447772874730_12112"><span id=3D"yui_3_16_0_1_1=
447772874730_12163">Hi, <br class=3D"" id=3D"yui_3_16_0_1_1447772874730_121=
65">I am trying to count last level cache misses by using lttng add-context=
 command. I use add-context to add perf:cpu:LLC-load-misses to my channel b=
ut I see an error. There is no error for other perf events. Just two perf e=
vents including perf:cpu:LLC-load-misses and&nbsp; perf:cpu:LLC-store-misse=
s give me the following error:<br class=3D"" id=3D"yui_3_16_0_1_14477728747=
30_12167">Error: perf:cpu:LLC-load-misses: Add kernel context failed<br cla=
ss=3D"" id=3D"yui_3_16_0_1_1447772874730_12169">Warning: Some command(s) we=
nt wrong<br class=3D"" id=3D"yui_3_16_0_1_1447772874730_12171"><br class=3D=
"" id=3D"yui_3_16_0_1_1447772874730_12173">Here is result of "uname -a" on =
my computer: <br class=3D"" id=3D"yui_3_16_0_1_1447772874730_12175">Linux n=
emati 3.16.0-51-generic #69~14.04.1-Ubuntu SMP Wed Oct 7 15:32:41 UTC 2015 =
x86_64 x86_64 x86_64 GNU/Linux <br class=3D"" id=3D"yui_3_16_0_1_1447772874=
730_12177"><br class=3D"" id=3D"yui_3_16_0_1_1447772874730_12179"><br class=
=3D"" id=3D"yui_3_16_0_1_1447772874730_12181">Here is the command that I us=
ed: <br class=3D"" id=3D"yui_3_16_0_1_1447772874730_12183">#lttng enable-ch=
annel -k test<br class=3D"" id=3D"yui_3_16_0_1_1447772874730_12185">#Kernel=
 channel test enabled for session hh<br class=3D"" id=3D"yui_3_16_0_1_14477=
72874730_12187">#lttng add-context -k -t perf:cpu:LLC-load-misses -c test<b=
r class=3D"" id=3D"yui_3_16_0_1_1447772874730_12189">Error: perf:cpu:LLC-lo=
ad-misses: Add kernel context failed<br class=3D"" id=3D"yui_3_16_0_1_14477=
72874730_12191">Warning: Some command(s) went wrong<br class=3D"" id=3D"yui=
_3_16_0_1_1447772874730_12193"><br class=3D"" id=3D"yui_3_16_0_1_1447772874=
730_12195"><br class=3D"" id=3D"yui_3_16_0_1_1447772874730_12197">I also tr=
ied it on other machines. </span></div><div id=3D"yui_3_16_0_1_144777287473=
0_12113">&nbsp;</div><div id=3D"yui_3_16_0_1_1447772874730_12155" class=3D"=
signature"><div id=3D"yui_3_16_0_1_1447772874730_12154">&lt;&lt;&lt;&lt;&lt=
;&lt;&lt;&nbsp;&nbsp; <font color=3D"#ff0000">&nbsp;/-/ /\ /\/ / /\/ <em>E<=
/em> /\/\ /\ <em>T</em> /</font>&nbsp;&nbsp;&nbsp; &gt;&gt;&gt;&gt;&gt;&gt;=
&gt;&gt;</div></div></div></body></html>
------=_Part_5258000_1235831345.1447796792691--


--===============0270064180==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0270064180==--
