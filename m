From: =?ISO-8859-1?Q?S=E9bastien_Barth=E9l=E9my?= <barthelemy@crans.org>
Subject: Misc questions regarding kernel tracing
Date: Fri, 26 Jul 2013 18:36:07 +0200
Message-ID: <CAPkDDd4QX-Coj5rnqZp5pLjrzWOUDOvRu+6PWZW+EOYAEH0vtw__22716.9807804332$1374856629$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1293240106=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-we0-f175.google.com ([74.125.82.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <sebastien.barthelemy@gmail.com>) id 1V2l01-0008Ow-89
	for lttng-dev@lists.lttng.org; Fri, 26 Jul 2013 12:36:19 -0400
Received: by mail-we0-f175.google.com with SMTP id q58so2073542wes.20
	for <lttng-dev@lists.lttng.org>; Fri, 26 Jul 2013 09:36:07 -0700 (PDT)
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

--===============1293240106==
Content-Type: multipart/alternative; boundary=089e010d8a024cba2c04e26cbdd0

--089e010d8a024cba2c04e26cbdd0
Content-Type: text/plain; charset=ISO-8859-1

Hello all,

I am investigating a problem on a rt system which misses deadlines under
load. Yet another occasion to use LTTng! But this comes with a bunch of
newcomer questions.

I'd like to reconstruct the state of the scheduler (the control view in
eclipse) with the minimum amount of traces from the kernel. So far I
recorded only the sched* events and it seems ok. But I suspect I should
also enable some lttng_statedump* to garantee a clean state at the very
beginning of the trace. Could you confirm this?

Also, I see threads which do "clone" a lot in the eclipse control view, but
looking at the raw traces (only the sched* events) I do not understand how
eclipse can figure it out. Is this an artefact of trying to use a kernel
trace which misses the syscall events or can I trust these "clone"?

More generally, is there a comprehensive guide somewhere that you would
recommend in order to understand the precise meaning of these sched* events?

Is there a way to trim a trace (remove the beginning and/or the end)
without compromising the scheduler state reconstruction?

I sometimes miss kernel events. Is there a point in using different
channels for kernel and user space traces (besides giving them distinct
sizes)? I suspect they're already effectively different even if they have
the same name. Also, I have increased the subbuffer size a lot, but did not
change the number of subbuffers. Would that help preventing missed events?

Thanks!

--089e010d8a024cba2c04e26cbdd0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><p dir=3D"ltr">Hello all,<br></p><p dir=3D"ltr">I am inves=
tigating a problem on a rt system which misses deadlines under load. Yet an=
other occasion to use LTTng! But this comes with a bunch of newcomer questi=
ons.<br>
</p>
<p dir=3D"ltr">I&#39;d like to reconstruct the state of the scheduler (the =
control view in eclipse) with the minimum amount of traces from the kernel.=
 So far I recorded only the sched* events and it seems ok. But I suspect I =
should also enable some lttng_statedump* to garantee a clean state at the v=
ery beginning of the trace. Could you confirm this?</p>


<p dir=3D"ltr">Also, I see threads which do &quot;clone&quot; a lot in the =
eclipse control view, but looking at the raw traces (only the sched* events=
) I do not understand how eclipse can figure it out. Is this an artefact of=
 trying to use a kernel trace which misses the syscall events or can I trus=
t these &quot;clone&quot;?<br>
</p>
<p dir=3D"ltr">More generally, is there a comprehensive guide somewhere tha=
t you would recommend in order to understand the precise meaning of these s=
ched* events?<br></p><p dir=3D"ltr">Is there a way to trim a trace (remove =
the beginning and/or the end) without compromising the scheduler state reco=
nstruction?<br>
</p>
<p>I sometimes miss kernel events. Is there a point in using different chan=
nels for kernel and user space traces (besides giving them distinct sizes)?=
 I suspect they&#39;re already effectively different even if they have the =
same name. Also, I have increased the subbuffer size a lot, but did not cha=
nge the number of subbuffers. Would that help preventing missed events?</p>
<p></p><p>Thanks!<br></p></div>

--089e010d8a024cba2c04e26cbdd0--


--===============1293240106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1293240106==--
