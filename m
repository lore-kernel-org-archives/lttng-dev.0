From: Jessica Foest <jessica.foest@gmail.com>
Subject: Question about Kprobe and function commandline options
Date: Thu, 20 Jun 2013 15:02:11 -0400
Message-ID: <CAPxN80BxSDSAEj9EmL_7weVx7nFy92xn3ax4zWTySTvM-wsanQ__24569.9977771894$1371754968$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0598464206=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oa0-f44.google.com ([209.85.219.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jessica.foest@gmail.com>) id 1Upk7c-0003e5-RL
	for lttng-dev@lists.lttng.org; Thu, 20 Jun 2013 15:02:16 -0400
Received: by mail-oa0-f44.google.com with SMTP id l10so8467748oag.31
	for <lttng-dev@lists.lttng.org>; Thu, 20 Jun 2013 12:02:11 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0598464206==
Content-Type: multipart/alternative; boundary=001a11c339d2621e8b04df9a951e

--001a11c339d2621e8b04df9a951e
Content-Type: text/plain; charset=ISO-8859-1

Hi

i try to apply kprobe to a system call , so i used probe and function
option :

lttng enable-event aname -k --probe sys_open+0x0 : this command returns ip
value


lttng enable-event aname -k --function sys_open : this command returns ip
and parent_ip values .

what does these values ip and parent_ip means ?

I try to apply probe and function options to some kernel symbols like
initialized date (like xen_vcpu_info symbol), read only data (like
linux_prob_banner symbol) and code (like reserve_ebda_region symbol) it
displays to me : Enable kernel event failed ,warning some command went(s)
wrong.
Did i make a mistake or it's a limitation in LTTng ?

regards.

--001a11c339d2621e8b04df9a951e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>

<p class=3D"" style=3D"margin-bottom:0.0001pt;line-height:normal"><span sty=
le=3D"font-size:10pt;font-family:&quot;Courier New&quot;" lang=3D"EN-CA">Hi=
=A0</span></p><p class=3D"" style=3D"margin-bottom:0.0001pt;line-height:nor=
mal"><span style=3D"font-size:10pt;font-family:&quot;Courier New&quot;" lan=
g=3D"EN-CA">i try to apply kprobe to a system call , so i used probe and fu=
nction option : <br>
</span></p><p class=3D"" style=3D"margin-bottom:0.0001pt;line-height:normal=
"><span style=3D"font-size:10pt;font-family:&quot;Courier New&quot;" lang=
=3D"EN-CA">lttng
enable-event aname -k --probe sys_open+0x0 : this command returns ip value =
<br></span></p><p class=3D"" style=3D"margin-bottom:0.0001pt;line-height:no=
rmal"><span style=3D"font-size:10pt;font-family:&quot;Courier New&quot;" la=
ng=3D"EN-CA"><br>
</span></p><span style=3D"font-size:10pt;font-family:&quot;Courier New&quot=
;" lang=3D"EN-CA"> lttng
enable-event aname -k --function sys_open</span>
: this command returns ip and parent_ip values .<br><br></div>what does the=
se values ip and parent_ip means ?<br></div><br>I try to apply probe and fu=
nction options to some kernel symbols like initialized date (like xen_vcpu_=
info symbol), read only data (like linux_prob_banner symbol) and code (like=
 reserve_ebda_region symbol) it displays to me : Enable kernel event failed=
 ,warning some command went(s) wrong.<br>
</div>Did i make a mistake or it&#39;s a limitation in LTTng ?<br><br></div=
>regards.<br><div><div><div><div>

<p class=3D"" style=3D"margin-bottom:0.0001pt;line-height:normal"><span sty=
le=3D"font-family:URWPalladioL-Roma" lang=3D"EN-CA"><br></span><span style=
=3D"font-family:URWPalladioL-Roma" lang=3D"EN-CA"></span></p>

<br></div></div></div></div></div>

--001a11c339d2621e8b04df9a951e--


--===============0598464206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0598464206==--
