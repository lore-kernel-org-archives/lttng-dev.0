From: Anand Neeli <anand.neeli@gmail.com>
Subject: No trace data until app restart
Date: Mon, 23 Feb 2015 18:03:08 +0530
Message-ID: <CAM5kDqxFbM0TVXGuke9KO1KDrqJfUK3kXtCESkD9COT1C3mLQA__2657.34312492913$1424694850$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0977950352=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1YPsCI-0006P1-GK
 for lttng-dev@lists.lttng.org; Mon, 23 Feb 2015 07:33:16 -0500
Received: by mail-wi0-f179.google.com with SMTP id hi2so16249971wib.0
 for <lttng-dev@lists.lttng.org>; Mon, 23 Feb 2015 04:33:08 -0800 (PST)
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

--===============0977950352==
Content-Type: multipart/alternative; boundary=f46d0418257cce6df1050fc09a1f

--f46d0418257cce6df1050fc09a1f
Content-Type: text/plain; charset=UTF-8

Hi All,

I'm using 2.4.1 and i see following issue. Can anyone let me know if there
is/was a bug for this? or let me know if i'm doing anything wrong here.

I have my app running, and now if i create a trace session then nothing
gets logged until the app is restarted.
Also i have multiple session configured with same events enabled on all
sessions, but nothing gets logged into any of the sessions until the app is
restarted.

I'm using following commands.

lttng-sessiond --consumerd32-path /usr/lib/lttng/libexec/lttng-consumerd
--consumerd32-libdir /usr/lib/ --consumerd64-path
/usr/lib64/lttng/libexec/lttng-consumerd --consumerd64-libdir /usr/lib64/
-b --no-kernel
lttng  --no-sessiond create mys5
lttng enable-channel myc5 --userspace --buffers-pid -s mys5
--tracefile-size 8388608 --tracefile-count 8
lttng enable-event --channel myc5 --userspace --all --exclude 'ust_libc:*'
-s mys5
lttng start mys5


Thanks,
Anand Neeli

--f46d0418257cce6df1050fc09a1f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div><br></div><div>I&#39;m using 2.4.1 and i see f=
ollowing issue. Can anyone let me know if there is/was a bug for this? or l=
et me know if i&#39;m doing anything wrong here.</div><div><br></div><div>I=
 have my app running, and now if i create a trace session then nothing gets=
 logged until the app is restarted.</div><div>Also i have multiple session =
configured with same events enabled on all sessions, but nothing gets logge=
d into any of the sessions until the app is restarted.<br></div><div><div><=
br></div><div>I&#39;m using following commands.</div><div>







<p class=3D"">lttng-sessiond --consumerd32-path /usr/lib/lttng/libexec/lttn=
g-consumerd --consumerd32-libdir /usr/lib/ --consumerd64-path /usr/lib64/lt=
tng/libexec/lttng-consumerd --consumerd64-libdir /usr/lib64/ -b --no-kernel=
=C2=A0</p></div><div>lttng=C2=A0 --no-sessiond create mys5</div><div>lttng =
enable-channel myc5 --userspace --buffers-pid -s mys5 --tracefile-size 8388=
608 --tracefile-count 8</div><div>lttng enable-event --channel myc5 --users=
pace --all <span class=3D"">--exclude &#39;ust_libc:*&#39;</span> -s mys5</=
div><div>lttng start mys5</div></div><div><br></div><div><br></div><div>Tha=
nks,</div><div>Anand Neeli</div></div>

--f46d0418257cce6df1050fc09a1f--


--===============0977950352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0977950352==--
