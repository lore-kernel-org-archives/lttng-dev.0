From: Anand Neeli <anand.neeli@gmail.com>
Subject: not able to read 32-bit app traces running on a 64-bit
	system with relayd
Date: Thu, 27 Nov 2014 17:01:13 +0530
Message-ID: <CAM5kDqwFTs3VeOV7JVM61QYn-Ruhtr6woDcwPNVE4A8OMP-ehQ__32571.6134314009$1417087925$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=001a11c3882050be3e0508d57bf8
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1XtxI7-0007ee-6f
 for lttng-dev@lists.lttng.org; Thu, 27 Nov 2014 06:31:22 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so8008296wiv.14
 for <lttng-dev@lists.lttng.org>; Thu, 27 Nov 2014 03:31:13 -0800 (PST)
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

--001a11c3882050be3e0508d57bf8
Content-Type: multipart/alternative; boundary=001a11c3882050be370508d57bf6

--001a11c3882050be370508d57bf6
Content-Type: text/plain; charset=UTF-8

Hi All,
I'm running both 32-bit and 64-bit app's on a 64-bit system.  I have
consumerd's build for both 32-bit and 64-bits (followed
http://lttng.org/docs/#doc-instrumenting-32-bit-app-on-64-bit-system)

I'm seeing problem in reading 32-bit app traces, although it is logging
something and logfile size in lttng-traces/ is increasing.
I have compiled same app for 64-bit and it works fine.

One more point here is that, this happens only when relaying traces.
Without using relayd and by using local tracing i dont see any issues.

Attached are the logs from 32-bit and 64-bit app's. There sizes are same
except the files in index/

I'm using 2.4.1 lttng and tried 1.2.0 and 1.2.1 version of babeltrace.

Can anyone please tell me how can i avoid this problem.

Thanks,
Anand Neeli

--001a11c3882050be370508d57bf6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div>I&#39;m running both 32-bit and 64-bit app&#39=
;s on a 64-bit system.=C2=A0 I have consumerd&#39;s build for both 32-bit a=
nd 64-bits (followed=C2=A0<a href=3D"http://lttng.org/docs/#doc-instrumenti=
ng-32-bit-app-on-64-bit-system">http://lttng.org/docs/#doc-instrumenting-32=
-bit-app-on-64-bit-system</a>)</div><div><br></div><div>I&#39;m seeing prob=
lem in reading 32-bit app traces, although it is logging something and logf=
ile size in lttng-traces/ is increasing.</div><div>I have compiled same app=
 for 64-bit and it works fine.</div><div><br></div><div>One more point here=
 is that, this happens only when relaying traces. Without using relayd and =
by using local tracing i dont see any issues.</div><div><br></div><div>Atta=
ched are the logs from 32-bit and 64-bit app&#39;s. There sizes are same ex=
cept the files in index/</div><div><br></div><div>I&#39;m using 2.4.1 lttng=
 and tried 1.2.0 and 1.2.1 version of babeltrace.=C2=A0</div><div><br></div=
><div>Can anyone please tell me how can i avoid this problem.=C2=A0</div><d=
iv><br></div><div>Thanks,</div><div>Anand Neeli</div></div>

--001a11c3882050be370508d57bf6--

--001a11c3882050be3e0508d57bf8
Content-Type: application/x-gzip;
	name="logtrace32-6965-20141127-023258.tar.gz"
Content-Disposition: attachment;
	filename="logtrace32-6965-20141127-023258.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i2zzy72s0

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
--001a11c3882050be3e0508d57bf8
Content-Type: application/x-gzip;
	name="logtrace64-6970-20141127-023301.tar.gz"
Content-Disposition: attachment;
	filename="logtrace64-6970-20141127-023301.tar.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_i2zzy7371

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
--001a11c3882050be3e0508d57bf8
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--001a11c3882050be3e0508d57bf8--
