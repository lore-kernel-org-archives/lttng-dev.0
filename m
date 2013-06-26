From: tarek slaymia <tarek.slaymia@gmail.com>
Subject: issue when installing LTTng on ubuntu
Date: Wed, 26 Jun 2013 18:01:51 -0400
Message-ID: <CAP7TvLf0LFe0wrDK2qx+JYgVcfGFqQOJmbAiDvbon8o01EprsA__32741.1447339275$1372284152$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1713751301=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f52.google.com ([209.85.212.52])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <tarek.slaymia@gmail.com>) id 1Urxmn-0002GB-Gw
	for lttng-dev@lists.lttng.org; Wed, 26 Jun 2013 18:01:57 -0400
Received: by mail-vb0-f52.google.com with SMTP id f12so1856vbg.39
	for <lttng-dev@lists.lttng.org>; Wed, 26 Jun 2013 15:01:52 -0700 (PDT)
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

--===============1713751301==
Content-Type: multipart/alternative; boundary=001a11339d9205880504e015cb43

--001a11339d9205880504e015cb43
Content-Type: text/plain; charset=ISO-8859-1

hi all, when installing lttng on ubuntu12.04 an issue is displayed related
to lttng-modules-dkms module.

Title of displayed message :
lttng-modules-dkms 2.0.2-0ubuntu1 : lttng-modules kernel module failed to
build.

in file included from
/var/lib/dkms/lttng-modules/2.0.2/build/probes/../instrumentation/event/lttng-module/../../..probes/lttng-events.h:98:0
/var/lib/dkms/lttng-modules/2.0.2/build/probes/../instrumentation/event/lttng-module/../../..probes/define_trace.h:117
/var/lib/dkms/lttng-modules/2.0.2/build/probes/../instrumentation/event/lttng-module/signal.h:165
/var/lib/dkms/lttng-modules/2.0.2/build/probes/lttng-probe-signal.c:38:
/var/lib/dkms/lttng-modules/2.0.2/build/probes/../instrumentation/event/lttng-module/signal.h:61:1:erreur:conflicting
types

Environment:
- on ubuntu 12.04.2 LTS - release amd64
- Linux 3.5.0-23-genericx86_64

BR

--001a11339d9205880504e015cb43
Content-Type: text/html; charset=ISO-8859-1

<div dir="ltr"><div>hi all, when installing lttng on ubuntu12.04 an issue is displayed related to lttng-modules-dkms module.<br><br>Title of displayed message : <br>
<div>lttng-modules-dkms 2.0.2-0ubuntu1 : lttng-modules kernel module failed to build.<br></div><div><br>in file included from /var/lib/dkms/lttng-modules/2.0.2/build/probes/../instrumentation/event/lttng-module/../../..probes/lttng-events.h:98:0<br>

/var/lib/dkms/lttng-modules/2.0.2/build/probes/../instrumentation/event/lttng-module/../../..probes/define_trace.h:117<br>/var/lib/dkms/lttng-modules/2.0.2/build/probes/../instrumentation/event/lttng-module/signal.h:165<br>

/var/lib/dkms/lttng-modules/2.0.2/build/probes/lttng-probe-signal.c:38:<br>/var/lib/dkms/lttng-modules/2.0.2/build/probes/../instrumentation/event/lttng-module/signal.h:61:1:erreur:conflicting types<br><br></div><div>Environment:<br>

</div>- on ubuntu 12.04.2 LTS - release amd64<br>- Linux 3.5.0-23-genericx86_64 <br><br></div>BR<br></div>

--001a11339d9205880504e015cb43--


--===============1713751301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1713751301==--
