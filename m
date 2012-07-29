From: Rui Han <r.han@umiami.edu>
Subject: Module lttng_tracer not found.
Date: Sun, 29 Jul 2012 16:26:12 -0400
Message-ID: <CABy43G956NYAU4MG9p32+17jwJt8-6TZsdP9xysNs63CGw0hbg__43040.705115027$1343593607$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1908293735=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <iurnah@gmail.com>) id 1Sva4A-00045X-AD
	for lttng-dev@lists.lttng.org; Sun, 29 Jul 2012 16:26:18 -0400
Received: by obbtb18 with SMTP id tb18so10144770obb.35
	for <lttng-dev@lists.lttng.org>; Sun, 29 Jul 2012 13:26:12 -0700 (PDT)
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

--===============1908293735==
Content-Type: multipart/alternative; boundary=e89a8fb1ef5699bf3304c5fdc1d1

--e89a8fb1ef5699bf3304c5fdc1d1
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I used lttng last week and didn't touch it ever since. I am trying to use
it again. I use lttng list -k, it give me error messages:

FATAL: Module lttng_tracer not found.
Error: Unable to load module lttng-tracer
Error: Unable to remove module lttng-tracer
Warning: No kernel tracer available
Error: Unable to list kernel events

I run kernel tracing as root. At first, I thought I have to start the
daemon by lttng-sessiond command. It gave me the error: "Error: Already
running daemon." At this time, I can create session, it gave "Session
session created. Traces will be written in
/root/lttng-traces/session-20120729-160806". However, it failed to generate
a single term of tracing. While I tried lsmod, there are no lttng related
module in the list. Which I remember there were several. The same thing
happened to my two ubuntu systems. I restarted the system, it still doesn't
work. Does any one know how to make lttng work again in this situation?

Thank you very much.

Best regards,
Rui

--e89a8fb1ef5699bf3304c5fdc1d1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Hi,</div><div><br></div><div>I used lttng last week and didn&#39;t tou=
ch it ever since. I am trying to use it again. I use lttng list -k, it give=
 me error messages:</div><div><br></div><div>FATAL: Module lttng_tracer not=
 found.</div>
<div>Error: Unable to load module lttng-tracer</div><div>Error: Unable to r=
emove module lttng-tracer</div><div>Warning: No kernel tracer available</di=
v><div>Error: Unable to list kernel events</div><div><br></div><div>I run k=
ernel tracing as root. At first, I thought I have to start the daemon by lt=
tng-sessiond command. It gave me the error: &quot;Error: Already running da=
emon.&quot; At this time, I can create session, it gave &quot;Session sessi=
on created.=A0Traces will be written in /root/lttng-traces/session-20120729=
-160806&quot;. However, it failed to generate a single term of tracing. Whi=
le I tried lsmod, there are no lttng related module in the list. Which I re=
member there were several. The same thing happened to my two ubuntu systems=
. I restarted the system, it still doesn&#39;t work.=A0Does any one know ho=
w to make lttng work again in this situation?</div>
<div><br></div><div>Thank you very much.</div><div><br></div><div>Best rega=
rds,</div><div>Rui</div>

--e89a8fb1ef5699bf3304c5fdc1d1--


--===============1908293735==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1908293735==--
