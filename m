From: Avi Goren <avi@reduxio.com>
Subject: infinite loop invoked using lttng enable/disable-event
Date: Tue, 25 Jun 2013 09:49:36 +0300
Message-ID: <CA+f7N8kVuJyGCywE1H8ZujrYAmBKzEEUjtDH=poJYdE541APkw__9892.41361753575$1372143017$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1048725624=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f53.google.com ([209.85.212.53])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <avi@reduxio.com>) id 1UrN4Q-00049a-Ao
	for lttng-dev@lists.lttng.org; Tue, 25 Jun 2013 02:49:42 -0400
Received: by mail-vb0-f53.google.com with SMTP id p12so9093434vbe.12
	for <lttng-dev@lists.lttng.org>; Mon, 24 Jun 2013 23:49:36 -0700 (PDT)
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

--===============1048725624==
Content-Type: multipart/alternative; boundary=001a1132f30cb31b3a04dff4eeda

--001a1132f30cb31b3a04dff4eeda
Content-Type: text/plain; charset=ISO-8859-1

Hi,
I'm using lttng 2.2.0 and encountered an infinite loop:
-------------------------------------------------------------------------
root@ubuntu:~# lttng create
Session auto-20130624-165047 created.
Traces will be written in /home/avig/lttng-traces/auto-20130624-165047
root@ubuntu:~# lttng enable-event -a -u --loglevel TRACE_ALERT
All UST events are enabled in channel channel0 for loglevel TRACE_ALERT
root@ubuntu:~# lttng enable-event -a -u --loglevel TRACE_CRIT
All UST events are enabled in channel channel0 for loglevel TRACE_CRIT
root@ubuntu:~# lttng disable-event -a -u
All UST events are disabled in channel channel0
root@ubuntu:~# lttng enable-event -a -u --loglevel TRACE_CRIT
All UST events are enabled in channel channel0 for loglevel TRACE_CRIT
root@ubuntu:~# lttng disable-event -a -u
(infinite loop here...)
-------------------------------------------------------------------------
I guess it's probably due to the setting of loglevel through enable-event
twice..?
Avi

--001a1132f30cb31b3a04dff4eeda
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div>I&#39;m using lttng 2.2.0 and encounter=
ed an infinite loop:</div><div>--------------------------------------------=
-----------------------------</div><div>root@ubuntu:~# lttng create</div><d=
iv>
Session auto-20130624-165047 created.</div><div>Traces will be written in /=
home/avig/lttng-traces/auto-20130624-165047</div><div>root@ubuntu:~# lttng =
enable-event -a -u --loglevel TRACE_ALERT</div><div>All UST events are enab=
led in channel channel0 for loglevel TRACE_ALERT</div>
<div>root@ubuntu:~# lttng enable-event -a -u --loglevel TRACE_CRIT</div><di=
v>All UST events are enabled in channel channel0 for loglevel TRACE_CRIT</d=
iv><div>root@ubuntu:~# lttng disable-event -a -u</div><div>All UST events a=
re disabled in channel channel0</div>
<div>root@ubuntu:~# lttng enable-event -a -u --loglevel TRACE_CRIT</div><di=
v>All UST events are enabled in channel channel0 for loglevel TRACE_CRIT</d=
iv><div>root@ubuntu:~# lttng disable-event -a -u</div><div>(infinite loop h=
ere...)</div>
<div>----------------------------------------------------------------------=
---</div><div>I guess it&#39;s probably due to the setting of loglevel thro=
ugh enable-event twice..?</div><div>Avi</div></div>

--001a1132f30cb31b3a04dff4eeda--


--===============1048725624==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1048725624==--
