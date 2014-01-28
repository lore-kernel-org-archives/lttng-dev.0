From: Shariyar <syed.shariyar@gmail.com>
Subject: liblttng-ust-cyg-profile.so not found
Date: Tue, 28 Jan 2014 11:37:20 -0500
Message-ID: <CAKQh6pgjuidy=KzKNQx1hropC_A8Nvdsk4AX2S0j2CHXCP8ihw__19174.3640149527$1390927114$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0025889240=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <syed.shariyar@gmail.com>) id 1W8BfD-0003xj-GG
	for lttng-dev@lists.lttng.org; Tue, 28 Jan 2014 11:37:35 -0500
Received: by mail-pa0-f41.google.com with SMTP id fa1so575639pad.28
	for <lttng-dev@lists.lttng.org>; Tue, 28 Jan 2014 08:37:20 -0800 (PST)
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

--===============0025889240==
Content-Type: multipart/alternative; boundary=047d7b67823a2b0ea204f10a7070

--047d7b67823a2b0ea204f10a7070
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I am trying to collect function entry and exit points in a trace. I  have
followed the instructions written on the following man page:
http://manpages.ubuntu.com/manpages/trusty/man3/lttng-ust-cyg-profile.3.html.


In my system, UST tracepoint tracing  is working fine and I am able to
collect traces with the statically typed tracepoints in the code. However,
there is no liblttng-ust-cyg-profile.so in my system and I get an error
when I execute the following:

       *LD_PRELOAD=liblttng-ust-cyg-profile.so* appname

Please let me know how to get it to work?

Thanks,
Shariyar

--047d7b67823a2b0ea204f10a7070
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br><br>I am trying to collect function entry and =
exit points in a trace. I=A0 have followed the instructions written on the =
following man page: <br>
<a href=3D"http://manpages.ubuntu.com/manpages/trusty/man3/lttng-ust-cyg-pr=
ofile.3.html">http://manpages.ubuntu.com/manpages/trusty/man3/lttng-ust-cyg=
-profile.3.html</a>. <br><br>In my system, UST tracepoint tracing=A0 is wor=
king fine and I am able to collect traces with the statically typed tracepo=
ints in the code. However, there is no<b> </b>liblttng-ust-cyg-profile.so i=
n my system and I get an error when I execute the following:<br>
<pre>       <b>LD_PRELOAD=3Dliblttng-ust-cyg-profile.so</b> appname</pre>Pl=
ease let me know how to get it to work?<br><br></div><div>Thanks,<br></div>=
<div>Shariyar<br></div></div>

--047d7b67823a2b0ea204f10a7070--


--===============0025889240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0025889240==--
