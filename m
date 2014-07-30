From: Dmitri Shubin <sbn@tbricks.com>
Subject: Enable UST probes only in specific process
Date: Wed, 30 Jul 2014 17:58:25 +0400
Message-ID: <CADmgc-ueSkK_XZPwtjsm_6dvSDCqi1GLfCyH7SNhVw1n-7WppQ__9564.89775931022$1406728769$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0803320349=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <sbn@tbricks.com>) id 1XCUOm-00044X-UX
 for lttng-dev@lists.lttng.org; Wed, 30 Jul 2014 09:58:38 -0400
Received: by mail-ie0-f174.google.com with SMTP id rp18so1557572iec.33
 for <lttng-dev@lists.lttng.org>; Wed, 30 Jul 2014 06:58:27 -0700 (PDT)
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

--===============0803320349==
Content-Type: multipart/alternative; boundary=089e013a123cd0cd2404ff698c28

--089e013a123cd0cd2404ff698c28
Content-Type: text/plain; charset=UTF-8

Hi!

Is it possible to enable user-space tracepoint in specific process (of
given PID)?

AFAIU
lttng enable-event -u prov:probe --filter '$ctx.vpid==12345'
enables probe for all processes and then drops unmatched.

In my case I'm doing rather heavyweight thing in probe (getting stack
trace) and want to do that only in the process of interest.

Is it possible?

The only way I can do it now is playing with LTTNG_HOME variable setting it
to different paths for each process.

Thanks!

--089e013a123cd0cd2404ff698c28
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi!<div><br></div><div>Is it possible to enable user-space=
 tracepoint in specific process (of given PID)?</div><div><br></div><div>AF=
AIU=C2=A0</div><div>lttng enable-event -u prov:probe --filter &#39;$ctx.vpi=
d=3D=3D12345&#39;</div>
<div>enables probe for all processes and then drops unmatched.<br></div><di=
v><br></div><div>In my case I&#39;m doing rather heavyweight thing in probe=
 (getting stack trace) and want to do that only in the process of interest.=
</div>
<div><br></div><div>Is it possible?</div><div><br></div><div>The only way I=
 can do it now is playing with LTTNG_HOME variable setting it to different =
paths for each process.</div><div><br></div><div>Thanks!</div></div>

--089e013a123cd0cd2404ff698c28--


--===============0803320349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0803320349==--
