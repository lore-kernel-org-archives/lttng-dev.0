From: Ilya Mirsky <ilya.mirsky@gmail.com>
Subject: Performance impact using the "filter" option
Date: Wed, 19 Mar 2014 14:46:29 +0200
Message-ID: <CANRvXTPktqrjRDa8WvRV=UoJi97mQT6bXVZr8==Ta8DjkkuiCQ__30282.2841717445$1395233289$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2026560718=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <ilya.mirsky@gmail.com>) id 1WQFtq-0004eb-Pk
	for lttng-dev@lists.lttng.org; Wed, 19 Mar 2014 08:47:16 -0400
Received: by mail-vc0-f180.google.com with SMTP id lf12so8826486vcb.39
	for <lttng-dev@lists.lttng.org>; Wed, 19 Mar 2014 05:47:09 -0700 (PDT)
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

--===============2026560718==
Content-Type: multipart/alternative; boundary=001a11c3d97c0224a004f4f50d88

--001a11c3d97c0224a004f4f50d88
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

It's a simple question, but I couldn't find the answer in the documentation.
Figured out I'll ask here before looking this in the code.

Should I expect LTTng's overhead to be lower when filtering some of the
trace points,
or is the main overhead is due to the trace point call and not the
recording itself?
In practice I see no noticeable difference in performance,
while I was hoping to get at least some improvement...

Thanks,
Ilya

--001a11c3d97c0224a004f4f50d88
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>It&#39;s a simple question, but=
 I couldn&#39;t find the answer in the documentation.</div><div>Figured out=
 I&#39;ll ask here before looking this in the code.</div><div><br></div><di=
v>

Should I expect LTTng&#39;s overhead to be lower when filtering some of the=
 trace points,</div><div>or is the main overhead is due to the trace point =
call and not the recording itself?</div><div>In practice I see no noticeabl=
e difference in performance,=A0</div>

<div>while I was hoping to get at least some improvement...</div><div><br><=
/div><div>Thanks,</div><div>Ilya</div><div><br></div><div><br></div><div><d=
iv><div><br></div><div><br></div></div></div></div>

--001a11c3d97c0224a004f4f50d88--


--===============2026560718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2026560718==--
