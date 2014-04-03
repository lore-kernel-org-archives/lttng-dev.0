From: Anand Neeli <anand.neeli@gmail.com>
Subject: instrumenting shared library
Date: Thu, 3 Apr 2014 16:55:38 +0530
Message-ID: <CAM5kDqyY-SvBStNo7fC4S1nuVoZLrw9iw2C88oaFC0QR-+XE9A__13437.5935922892$1396527293$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0810698937=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <anand.neeli@gmail.com>) id 1WVfmC-0008C4-FR
 for lttng-dev@lists.lttng.org; Thu, 03 Apr 2014 07:25:48 -0400
Received: by mail-pa0-f52.google.com with SMTP id rd3so1704491pab.39
 for <lttng-dev@lists.lttng.org>; Thu, 03 Apr 2014 04:25:38 -0700 (PDT)
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

--===============0810698937==
Content-Type: multipart/alternative; boundary=047d7bf15e2c1cd93904f621a999

--047d7bf15e2c1cd93904f621a999
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I have a library which is instrumented and tracepoints are added. And i
have 2 binary's(or daemons) which try to include this library.(one binary
has instrumented code with tracepoints and other binary doesn't use
tracing)
I found that i need to instrument the daemon which includes the
instrumented library for the code to compile.

Cant i have a daemon(without tracing functionality) which can include a
instrumented library (i don't want to use tracing functionality in this
case)
I'm only able to build if both library and daemon which includes it are
instrumented.

Can anyone please give me more details on how to do this?
this is useful for huge code bases where you can selectively add tracing
support to few librarys or daemons.


Hope i have written clearly, please ask me more if you are not able to
follow my query.

Thanks,
Anand Neeli

--047d7bf15e2c1cd93904f621a999
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I have a library which is instrumen=
ted and tracepoints are added. And i have 2 binary&#39;s(or daemons) which =
try to include this library.(one binary has instrumented code with tracepoi=
nts and other binary doesn&#39;t use tracing)=A0</div>
<div>I found that i need to instrument the daemon which includes the instru=
mented library for the code to compile.</div><div><br></div><div>Cant i hav=
e a daemon(without tracing functionality) which can include a instrumented =
library (i don&#39;t want to use tracing functionality in this case)</div>
<div>I&#39;m only able to build if both library and daemon which includes i=
t are instrumented.</div><div><br></div><div>Can anyone please give me more=
 details on how to do this?</div><div>this is useful for huge code bases wh=
ere you can selectively add tracing support to few librarys or daemons.</di=
v>
<div><br></div><div><br></div><div>Hope i have written clearly, please ask =
me more if you are not able to follow my query.</div><div><br></div><div>Th=
anks,</div><div>Anand Neeli</div><div><br></div><div><br></div></div>

--047d7bf15e2c1cd93904f621a999--


--===============0810698937==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0810698937==--
