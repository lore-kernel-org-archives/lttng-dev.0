From: Sergei Dyshel <qyron.private@gmail.com>
Subject: Using LLTNG within shared library (not dlopen-ed).
Date: Mon, 10 Aug 2015 20:27:20 +0300
Message-ID: <CAAeL1MGw9i1yHyxpAfJOq++zsNYM7+-_aJDAh2yN1B9k9K3U0w__46749.5767436505$1439231646$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1112719074=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <qyron.private@gmail.com>) id 1ZOqrR-00014g-Ck
 for lttng-dev@lists.lttng.org; Mon, 10 Aug 2015 13:27:50 -0400
Received: by wibhh20 with SMTP id hh20so160540689wib.0
 for <lttng-dev@lists.lttng.org>; Mon, 10 Aug 2015 10:27:39 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1112719074==
Content-Type: multipart/alternative; boundary=f46d0444ef3167fd92051cf84dfb

--f46d0444ef3167fd92051cf84dfb
Content-Type: text/plain; charset=UTF-8

Hi all,

I have some code using traces compiled as shared object (together with
trace provider).
This ".so" is linked to main code during compile-time.
When I run main application and try to read traces after that I get errors
about corrupted trace file.

I've read docs about dynamical linking of trace provider which recommends
compiling trace provider into separate .so and using LD_PRELOAD to preload
it. But that is only needed for shared objects loaded with "dlopen". In my
case "dlclose" isn't called and shared object is unloaded on the exit (i.e.
after all traces produced).

So this shouldn't be a problem... Am I right?
-- 
Regards,
Sergei Dyshel

--f46d0444ef3167fd92051cf84dfb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br></div><div>I have some code using traces c=
ompiled as shared object (together with trace provider).</div><div>This &qu=
ot;.so&quot; is linked to main code during compile-time.</div><div>When I r=
un main application and try to read traces after that I get errors about co=
rrupted trace file.</div><div><br></div><div>I&#39;ve read docs about dynam=
ical linking of trace provider which recommends compiling trace provider in=
to separate .so and using LD_PRELOAD to preload it. But that is only needed=
 for shared objects loaded with &quot;dlopen&quot;. In my case &quot;dlclos=
e&quot; isn&#39;t called and shared object is unloaded on the exit (i.e. af=
ter all traces produced).=C2=A0</div><div><br></div><div>So this shouldn&#3=
9;t be a problem... Am I right?</div><div><div><div class=3D"gmail_signatur=
e"><div dir=3D"ltr">-- <br>Regards,<br>Sergei Dyshel</div></div></div>
</div></div>

--f46d0444ef3167fd92051cf84dfb--


--===============1112719074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1112719074==--
